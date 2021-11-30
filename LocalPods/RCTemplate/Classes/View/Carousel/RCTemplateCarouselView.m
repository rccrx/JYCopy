//
//  RCTemplateCarouselView.m
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import "RCTemplateCarouselView.h"
#import "RCTemplatePageControl.h"

@implementation RCTemplateCarouselView

- (instancetype)initWithImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight {
    if (self = [super initWithImageEdgeInsets:imageEdgeInsets viewWidth:viewWidth viewHeight:viewHeight]) {
        RCTemplatePageControl *pageControl = [[RCTemplatePageControl alloc] init];
        self.pageControl = pageControl;
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@([RCTemplatePageControl indicatorWH]));
            make.bottom.equalTo(self).offset(-10);
        }];
    }
    return self;
}

@end
