//
//  RCCollectionViewAdaptiveHeightLayout.m
//  RCTemplate
//
//  Created by crx on 2021/11/29.
//

#import "RCCollectionViewAdaptiveHeightLayout.h"

@interface RCCollectionViewAdaptiveHeightLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cachedAttributes;
@property (nonatomic, assign) CGRect contentBounds;
@property (nonatomic, assign) CGFloat leftItemX;

@end

@implementation RCCollectionViewAdaptiveHeightLayout

- (instancetype)init {
    if (self = [super init]) {
        self.lineSpacing = 10;
        self.interitemSpacing = 10;
        
        self.cachedAttributes = [NSMutableArray array];
        self.contentBounds = CGRectZero;
    }
    return self;
}

#pragma mark - Override
- (void)prepareLayout {
    [super prepareLayout];
    
    [self.cachedAttributes removeAllObjects];
    self.contentBounds = CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
    
    if (self.itemWidth <= 0) {
        return;
    }
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat itemWidth = self.itemWidth;
    CGFloat leftItemX = self.sectionInset.left;
    self.leftItemX = leftItemX;
    CGFloat rightItemX = self.sectionInset.left + itemWidth + self.interitemSpacing;
    CGFloat leftItemY = self.sectionInset.top;
    CGFloat rightItemY = self.sectionInset.top;
    BOOL isLeftOrRight = YES; /**< YES表示left，NO表示right，代表当前indexPath的cell应该放在左边还是右边（如果左右轮流放置，可能会出现一边的高度比另一边高出n个cell） */
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat itemHeight = [(id<RCCollectionViewDelegateAdaptiveHeightLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];
        CGRect frame = CGRectZero;
        if (isLeftOrRight) {
            frame = CGRectMake(leftItemX, leftItemY, itemWidth, itemHeight);
            leftItemY = CGRectGetMaxY(frame) + self.lineSpacing;
        } else {
            frame = CGRectMake(rightItemX, rightItemY, itemWidth, itemHeight);
            rightItemY = CGRectGetMaxY(frame) + self.lineSpacing;
        }
        isLeftOrRight = leftItemY <= rightItemY; // 哪边的Y小，下一个cell就放在哪边，相等则放左边
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = frame;
        
        [self.cachedAttributes addObject:attributes];
        self.contentBounds = CGRectUnion(self.contentBounds, frame);
    }
    if (count != 0) {
        CGRect contentBounds = self.contentBounds;
        contentBounds.size.height += self.sectionInset.bottom;
        self.contentBounds = contentBounds;
    }
}

- (CGSize)collectionViewContentSize {
    return self.contentBounds.size;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *attributesArray = [NSMutableArray array];
    
    NSInteger firstMatchIndex = [self binarySearchCachedAttributesInRect:rect startIndex:0 endIndex:self.cachedAttributes.count - 1];
    if (firstMatchIndex == -1) {
        return attributesArray;
    }
    
    BOOL leftDone = NO;
    BOOL rightDone = NO;
    for (NSInteger i = firstMatchIndex; i >= 0; i--) {
        UICollectionViewLayoutAttributes *attr = self.cachedAttributes[i];
        if (CGRectGetMaxY(attr.frame) >= CGRectGetMinY(rect)) {
            [attributesArray addObject:attr];
        } else { // 由于cachedAttributes的MaxY并不是递增的，所以当前indexPath不在rect，不代表indexPath前面的不在rect，比如idx=1的高度极其高导致左边idx=0、2~n共n-1个cell而右边仅一个cell的布局情况
            if (CGRectGetMinX(attr.frame) - self.leftItemX < 0.00001) {
                leftDone = YES;
            } else {
                rightDone = YES;
            }
            if (leftDone && rightDone) {
                break;
            }
        }
    }
    
    for (NSUInteger i = firstMatchIndex + 1; i < self.cachedAttributes.count; i++) {
        UICollectionViewLayoutAttributes *attr = self.cachedAttributes[i];
        if (CGRectGetMinY(attr.frame) <= CGRectGetMaxY(rect)) {
            [attributesArray addObject:attr];
        } else {
            break;
        }
    }
    
    return attributesArray;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.cachedAttributes[indexPath.item];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGSizeEqualToSize(newBounds.size, self.collectionView.bounds.size);
}

#pragma mark - Private
/** 使用二份查找来搜索cachedAttributes中第一个匹配rect的index，-1表示没有找到 */
- (NSInteger)binarySearchCachedAttributesInRect:(CGRect)rect startIndex:(NSUInteger)start endIndex:(NSUInteger)end {
    if (end < start) {
        return -1;
    }
    
    NSUInteger mid = (start + end) / 2;
    UICollectionViewLayoutAttributes *attr = self.cachedAttributes[mid];
    
    if (CGRectIntersectsRect(attr.frame, rect)) {
        return mid;
    } else {
        if (CGRectGetMinY(attr.frame) > CGRectGetMaxY(rect)) { // cachedAttributes的MinY是递增的，MaxY不是递增的
            return [self binarySearchCachedAttributesInRect:rect startIndex:start endIndex:mid - 1];
        } else {
            return [self binarySearchCachedAttributesInRect:rect startIndex:mid + 1 endIndex:end];
        }
    }
}

- (CGFloat)itemWidth {
    return (CGRectGetWidth(self.collectionView.bounds) - self.sectionInset.left - self.sectionInset.right - self.interitemSpacing) * 0.5;
}

@end
