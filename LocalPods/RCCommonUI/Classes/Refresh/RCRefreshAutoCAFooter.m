//
//  RCRefreshAutoCAFooter.m
//  RCCommonUI
//
//  Created by crx on 2022/2/17.
//

#import "RCRefreshAutoCAFooter.h"
#import "RCRefreshingView.h"

@interface RCRefreshAutoCAFooter ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) RCRefreshingView *refreshingView;
@end

@implementation RCRefreshAutoCAFooter

#pragma mark - Override
- (void)prepare {
    [super prepare];
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = [UIColor colorWithRed:162/255.0 green:162/255.0 blue:162/255.0 alpha:1];
    self.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
    
    self.textLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLabelDidTapped:)];
    [self.textLabel addGestureRecognizer:tap];
    
    self.refreshingView = [RCRefreshingView new];
    [self addSubview:self.refreshingView];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    self.textLabel.frame = self.bounds;
    self.refreshingView.frame = CGRectMake((self.mj_w - self.refreshingView.intrinsicContentSize.width) * 0.5, (self.mj_h - self.refreshingView.intrinsicContentSize.height) * 0.5, self.refreshingView.intrinsicContentSize.width, self.refreshingView.intrinsicContentSize.height);
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    
    switch (state) {
        case MJRefreshStateIdle:
        {
            self.textLabel.text = @"点击加载更多";
            self.textLabel.hidden = NO;
            self.refreshingView.hidden = YES;
            break;
        }
        case MJRefreshStateRefreshing:
        {
            self.textLabel.hidden = YES;
            self.refreshingView.hidden = NO;
            break;
        }
        case MJRefreshStateNoMoreData:
        {
            self.textLabel.text = @"没有更多数据";
            self.textLabel.hidden = NO;
            self.refreshingView.hidden = YES;
            break;
        }
        default:
            break;
    }
}

#pragma mark - Action
- (void)textLabelDidTapped:(UITapGestureRecognizer *)tap {
    if (self.state == MJRefreshStateIdle) {
        [self beginRefreshing];
    }
}

@end

