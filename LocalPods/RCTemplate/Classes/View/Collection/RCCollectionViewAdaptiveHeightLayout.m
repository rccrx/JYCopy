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

- (void)prepareLayout {
    [super prepareLayout];
    
    [self.cachedAttributes removeAllObjects];
    self.contentBounds = CGRectMake(0, 0, CGRectGetWidth(self.collectionView.bounds), CGRectGetHeight(self.collectionView.bounds));
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.bounds) - self.sectionInset.left - self.sectionInset.right - self.interitemSpacing) * 0.5;
    CGFloat leftItemX = self.sectionInset.left;
    CGFloat rightItemX = self.sectionInset.left + itemWidth + self.interitemSpacing;
    CGFloat leftItemY = self.sectionInset.top;
    CGFloat rightItemY = self.sectionInset.top;
    for (int i = 0; i < count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGFloat itemHeight = [(id<RCCollectionViewDelegateAdaptiveHeightLayout>)self.collectionView.delegate collectionView:self.collectionView layout:self heightForItemAtIndexPath:indexPath];
        CGRect frame = CGRectZero;
        if (i % 2 == 0) {
            frame = CGRectMake(leftItemX, leftItemY, itemWidth, itemHeight);
            leftItemY = CGRectGetMaxY(frame) + self.lineSpacing;
        } else {
            frame = CGRectMake(rightItemX, rightItemY, itemWidth, itemHeight);
            rightItemY = CGRectGetMaxY(frame) + self.lineSpacing;
        }
        
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
    return self.cachedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.cachedAttributes[indexPath.item];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return !CGSizeEqualToSize(newBounds.size, self.collectionView.bounds.size);
}

@end
