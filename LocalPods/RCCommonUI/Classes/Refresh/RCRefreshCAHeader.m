//
//  RCRefreshCAHeader.m
//  RCCommonUI
//
//  Created by crx on 2021/12/15.
//

#import "RCRefreshCAHeader.h"
#import "RCRefreshingView.h"

@interface RCRefreshCAHeader ()
@property (nonatomic, strong) RCRefreshingView *refreshingView;
@end

@implementation RCRefreshCAHeader

- (void)prepare {
    [super prepare];
    
    self.refreshingView = [RCRefreshingView new];
    [self addSubview:self.refreshingView];
}

- (void)placeSubviews {
    [super placeSubviews];

    self.refreshingView.frame = CGRectMake((self.mj_w - self.refreshingView.intrinsicContentSize.width) * 0.5, (self.mj_h - self.refreshingView.intrinsicContentSize.height) * 0.5, self.refreshingView.intrinsicContentSize.width, self.refreshingView.intrinsicContentSize.height);
}

@end
