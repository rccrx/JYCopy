//
//  RCRefreshingView.m
//  RCCommonUI
//
//  Created by crx on 2022/2/17.
//

#import "RCRefreshingView.h"

@implementation RCRefreshingView

- (instancetype)init {
    if (self = [super init]) {
        CALayer *layer1 = [[CALayer alloc] init];
        layer1.frame = CGRectMake(0, 0, 10, 10);
        layer1.backgroundColor = [UIColor colorWithRed:104/255.0 green:239/255.0 blue:245/255.0 alpha:0.5].CGColor;
        layer1.cornerRadius = CGRectGetHeight(layer1.frame) * 0.5;
        [self.layer addSublayer:layer1];
        
        CALayer *layer2 = [[CALayer alloc] init];
        layer2.frame = CGRectMake(0, 0, 10, 10);
        layer2.backgroundColor = [UIColor colorWithRed:255/255.0 green:82/255.0 blue:218/255.0 alpha:0.5].CGColor;
        layer2.cornerRadius = CGRectGetHeight(layer2.frame) * 0.5;
        [self.layer insertSublayer:layer2 below:layer1];
        
        CAKeyframeAnimation *translation1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
        translation1.values = @[@0, @5, @10, @5, @0];
        translation1.timingFunctions = @[[CAMediaTimingFunction functionWithControlPoints:0.8 :0 :1 :1], [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.2 :1], [CAMediaTimingFunction functionWithControlPoints:0.8 :0 :1 :1], [CAMediaTimingFunction functionWithControlPoints:0 :0 :0.2 :1]]; //kCAMediaTimingFunctionEaseIn大概控制点是(0.42,0)，(1,1)，调大c1x使得开始更慢，使得停留在@0的时间比EaseIn长一点；以(0,0)，(0.2,1)代替EaseOut使得停留在@10的时间长一点
        CAKeyframeAnimation *scale1 = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scale1.values = @[@1, @0.55, @1, @1.15, @1];
        scale1.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        
        CAAnimationGroup *group1 = [CAAnimationGroup animation];
        group1.animations = @[translation1, scale1];
        group1.repeatCount = INFINITY;
        group1.duration = 1;
        group1.removedOnCompletion = NO;
        [layer1 addAnimation:group1 forKey:@"animationGroup"];
        
        CAAnimationGroup *group2 = [CAAnimationGroup animation];
        group2.animations = @[translation1, scale1];
        group2.repeatCount = INFINITY;
        group2.duration = group1.duration;
        group2.removedOnCompletion = NO;
        group2.timeOffset = 0.5 * group2.duration;
        [layer2 addAnimation:group2 forKey:@"animationGroup"];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(20, 10);
}

@end
