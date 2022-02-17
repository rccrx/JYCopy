//
//  RCRefreshAutoCAFooter.m
//  RCCommonUI
//
//  Created by crx on 2022/2/17.
//

#import "RCRefreshAutoCAFooter.h"
#import "RCRefreshingView.h"

/** 如果是MJRefreshStateIdle状态，则可以通过点击和上拉启动刷新，为了在显示“点击加载更多”时禁止上拉启动刷新，需要新状态不能是Idle状态 */
MJRefreshState const MJRefreshStateDataFailed = -99;

@interface RCRefreshAutoCAFooter ()
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) RCRefreshingView *refreshingView;
@end

@implementation RCRefreshAutoCAFooter

#pragma mark - Override
- (void)prepare {
    [super prepare];
    
    self.mj_h = 80;
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = [UIColor colorWithRed:162/255.0 green:162/255.0 blue:162/255.0 alpha:1];
    self.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
    
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
        case MJRefreshStateDataFailed:
        {
            self.textLabel.userInteractionEnabled = YES;
            self.textLabel.text = @"点击加载更多";
            self.textLabel.hidden = NO;
            self.refreshingView.hidden = YES;
            break;
        }
        case MJRefreshStateNoMoreData:
        {
            self.textLabel.userInteractionEnabled = NO;
            self.textLabel.text = @"没有更多数据";
            self.textLabel.hidden = NO;
            self.refreshingView.hidden = YES;
            break;
        }
        default:
        {
            self.textLabel.hidden = YES;
            self.refreshingView.hidden = NO;
            break;
        }
    }
}

#pragma mark - Action
- (void)textLabelDidTapped:(UITapGestureRecognizer *)tap {
    if (self.state == MJRefreshStateDataFailed) {
        [self beginRefreshing];
    }
}

#pragma mark - Public
- (void)endRefreshingWithDataFailed {
    MJRefreshDispatchAsyncOnMainQueue(self.state = MJRefreshStateDataFailed;)
}

@end

