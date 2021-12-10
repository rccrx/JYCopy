//
//  RCLoadingView.m
//  RCCommonUI
//
//  Created by crx on 2021/12/10.
//

#import "RCLoadingView.h"

@implementation RCLoadingView

- (instancetype)init {
    if (self = [super init]) {
        CALayer *layer = [[CALayer alloc] init];
        layer.frame = CGRectMake(0, 0, self.intrinsicContentSize.width, self.intrinsicContentSize.height);
        layer.backgroundColor = [UIColor colorWithRed:0 green:1 blue:1 alpha:0.7].CGColor;
        layer.cornerRadius = CGRectGetHeight(layer.frame) * 0.5;
        [self.layer addSublayer:layer];
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.fromValue = @0.5;
        animation.toValue = @1.5;
        animation.autoreverses = YES;
        animation.repeatCount = INFINITY;
        animation.duration = 1;
        animation.removedOnCompletion = NO;
        [layer addAnimation:animation forKey:@"animation1"];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(60, 60);
}

@end
