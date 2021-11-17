//
//  RCTemplatePageControl.m
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import "RCTemplatePageControl.h"

#pragma mark - RCTemplatePageControlIndicator
@interface RCTemplatePageControlIndicator : UIView
@property (nonatomic, assign) BOOL selected;
@end

@implementation RCTemplatePageControlIndicator
- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius {
    if (self = [super init]) {
        self.selected = NO;
        self.layer.cornerRadius = cornerRadius;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (selected) {
        self.backgroundColor = UIColor.whiteColor;
    } else {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    }
}

@end



#pragma mark - RCTemplatePageControl
@interface RCTemplatePageControl ()
@property (nonatomic, strong) NSMutableArray<RCTemplatePageControlIndicator *> *indicators;
@end

@implementation RCTemplatePageControl

@synthesize currentPage = _currentPage;
@synthesize numberOfPages = _numberOfPages;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.indicators = [NSMutableArray array];
    }
    return self;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    if (self.numberOfPages == numberOfPages) {
        return;
    }
    
    [self.indicators makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.indicators removeAllObjects];
    
    _numberOfPages = numberOfPages;
    
    CGFloat indicatorWH = [self.class indicatorWH];
    CGFloat indicatorCenterXSpace = [self.class indicatorCenterXSpace];
    CGFloat centerIdx = (self.numberOfPages - 1) * 0.5; // 比如3个page时1是中心索引值；4个page时1.5是中心索引值
    for (int i = 0; i < self.numberOfPages; i++) {
        RCTemplatePageControlIndicator *indicatorView = [[RCTemplatePageControlIndicator alloc] initWithCornerRadius:indicatorWH * 0.5];
        [self addSubview:indicatorView];
        [indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset((i - centerIdx) * indicatorCenterXSpace);
            make.centerY.equalTo(self);
            make.width.height.equalTo(@(indicatorWH));
        }];
        
        [self.indicators addObject:indicatorView];
    }
    
    self.currentPage = 0;
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (self.indicators.count <= currentPage) {
        return;
    }
    
    RCTemplatePageControlIndicator *previousIndicator = self.indicators[self.currentPage];
    previousIndicator.selected = NO;
    
    _currentPage = currentPage;
    
    RCTemplatePageControlIndicator *currentIndicator = self.indicators[self.currentPage];
    currentIndicator.selected = YES;
}

#pragma mark - Class Methods
+ (CGFloat)indicatorWH {
    return 5;
}

+ (CGFloat)indicatorCenterXSpace {
    return 15;
}

@end
