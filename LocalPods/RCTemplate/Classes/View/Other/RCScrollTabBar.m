//
//  RCScrollTabBar.m
//  LookinServer
//
//  Created by crx on 2021/11/24.
//

#import "RCScrollTabBar.h"

#pragma mark - RCScrollTabBarItem
@interface RCScrollTabBarItem : UIButton
@end

@implementation RCScrollTabBarItem
- (instancetype)init {
    if (self = [super init]) {
        [self setTitleColor:UIColor.rte_colorA2A2A2 forState:UIControlStateNormal];
        [self setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
        self.selected = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (self.selected) {
        self.titleLabel.font = Font_PFSC_M(16);
    } else {
        self.titleLabel.font = Font_PFSC_R(14);
    }
}
@end



#pragma mark - RCScrollTabBar
@interface RCScrollTabBar ()
@property (nonatomic, strong) NSMutableArray<RCScrollTabBarItem *> *items;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *indicatorView;
@end

@implementation RCScrollTabBar

- (instancetype)init {
    if (self = [super init]) {
        self.items = [NSMutableArray array];
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
        
        CGRect indicatorFrame = CGRectMake(0, 0, 15, 2); // 这个frame之后会随着选中的item的位置改变
        self.indicatorView = [UIView rut_viewWithBackgroundColor:UIColor.rte_themeColor cornerRadius:CGRectGetHeight(indicatorFrame) * 0.5];
        self.indicatorView.frame = indicatorFrame;
        [self.scrollView addSubview:self.indicatorView];
    }
    return self;
}

#pragma mark - Public
- (void)setItemTitles:(NSArray<NSString *> *)titles barHeight:(CGFloat)barHeight {
    [self.items makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.items removeAllObjects];
    
    CGFloat itemSpacing = 32;
    CGFloat itemMarginLR = 25; /**< item距离父视图左右边距 */
    CGFloat itemX = itemMarginLR;
    UIFont *itemFont = Font_PFSC_R(14);
    CGFloat itemHeight = itemFont.lineHeight;
    for (int i = 0; i < titles.count; i++) {
        NSString *title = titles[i];
        RCScrollTabBarItem *itemView = [RCScrollTabBarItem new];
        [itemView addTarget:self action:@selector(itemDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [itemView setTitle:title forState:UIControlStateNormal];
        CGFloat itemWidth = [itemView sizeThatFits:CGSizeMake(MAXFLOAT, itemHeight)].width;
        itemView.frame = CGRectMake(itemX, (barHeight - itemHeight) * 0.5, itemWidth, itemHeight);
        [self.scrollView addSubview:itemView];
        [self.items addObject:itemView];
        
        itemX = CGRectGetMaxX(itemView.frame) + itemSpacing;
    }
    self.scrollView.contentSize = CGSizeMake(itemX - itemSpacing + itemMarginLR, barHeight);
    
    CGRect indicatorFrame = self.indicatorView.frame;
    CGFloat indicatorBottom = 7;
    indicatorFrame.origin.y = barHeight - CGRectGetHeight(indicatorFrame) - indicatorBottom;
    self.indicatorView.frame = indicatorFrame;
    
    [self setSelectedIndex:0 animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated {
    if (self.items.count == 0) {
        _selectedIndex = 0;
        self.indicatorView.hidden = YES;
    } else if (selectedIndex >= self.items.count) {
        return;
    }
    
    RCScrollTabBarItem *previousSelectedItem = self.items[self.selectedIndex];
    _selectedIndex = selectedIndex;
    RCScrollTabBarItem *currentSelectedItem = self.items[self.selectedIndex];
    
    
    previousSelectedItem.selected = NO;
    CGSize previousSISize = [previousSelectedItem sizeThatFits:CGSizeMake(MAXFLOAT, previousSelectedItem.titleLabel.font.lineHeight)];
    previousSelectedItem.frame = CGRectMake(CGRectGetMidX(previousSelectedItem.frame) - previousSISize.width * 0.5, CGRectGetMidY(previousSelectedItem.frame) - previousSISize.height * 0.5, previousSISize.width, previousSISize.height);
    
    currentSelectedItem.selected = YES;
    CGSize currentSISize = [currentSelectedItem sizeThatFits:CGSizeMake(MAXFLOAT, currentSelectedItem.titleLabel.font.lineHeight)];
    currentSelectedItem.frame = CGRectMake(CGRectGetMidX(currentSelectedItem.frame) - currentSISize.width * 0.5, CGRectGetMidY(currentSelectedItem.frame) - currentSISize.height * 0.5, currentSISize.width, currentSISize.height);
    
    self.indicatorView.hidden = NO;
    
    NSTimeInterval duration = 0;
    if (animated) {
        duration = 0.25;
    }
    [UIView animateWithDuration:duration animations:^{
        CGRect indicatorFrame = self.indicatorView.frame;
        indicatorFrame.origin.x = CGRectGetMidX(currentSelectedItem.frame) - CGRectGetWidth(indicatorFrame) * 0.5;
        self.indicatorView.frame = indicatorFrame;
    }];
    
    CGFloat scrollWidth = CGRectGetWidth(self.scrollView.frame); // 由于scrollView是使用约束，所以frame要在视图显示之后才生效，按钮点击时frame已经设置好了
    CGRect rect = self.items[self.selectedIndex].frame;
    rect.origin.x = CGRectGetMidX(rect) - scrollWidth * 0.5;
    rect.size.width = scrollWidth;
    [self.scrollView scrollRectToVisible:rect animated:YES];
}

- (NSUInteger)tabCount {
    return self.items.count;
}

#pragma mark - Action
- (void)itemDidClicked:(RCScrollTabBarItem *)item {
    NSUInteger idx = [self.items indexOfObject:item];
    [self setSelectedIndex:idx animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(scrollTabBar:didSelectItem:)]) {
        [self.delegate scrollTabBar:self didSelectItem:idx];
    }
}

@end
