//
//  RCTemplateCarouselView.m
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import "RCTemplateCarouselView.h"

@implementation RCTemplateCarouselView

- (instancetype)initWithImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight {
    if (self = [super initWithImageEdgeInsets:imageEdgeInsets viewWidth:viewWidth viewHeight:viewHeight]) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = 3;
        self.pageControl = pageControl;
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@20);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

@end
