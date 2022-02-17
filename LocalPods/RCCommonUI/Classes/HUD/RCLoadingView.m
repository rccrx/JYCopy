//
//  RCLoadingView.m
//  RCCommonUI
//
//  Created by crx on 2021/12/10.
//

#import "RCLoadingView.h"

@interface RCLoadingView ()
@property (nonatomic, strong) CAShapeLayer *redLayer;
@property (nonatomic, strong) CAShapeLayer *blueLayer;
@property (nonatomic, strong) CAShapeLayer *whiteLayer;
@property (nonatomic, strong) CAShapeLayer *redBorderLayer; /**< redLayer的边框 */
@property (nonatomic, strong) CAShapeLayer *blueBorderLayer;
@property (nonatomic, strong) CAShapeLayer *whiteBorderLayer;
@end

@implementation RCLoadingView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 40, 2.5);
        CGPathAddLineToPoint(path, NULL, 2.5, 22);
        CGPathAddLineToPoint(path, NULL, 2.5, 27);
        CGPathAddLineToPoint(path, NULL, 30, 27);
        CGPathAddLineToPoint(path, NULL, 30, 2.5);
        CGPathAddLineToPoint(path, NULL, 2.5, 2.5);
        CGPathAddLineToPoint(path, NULL, 2.5, 7.5);
        CGPathAddLineToPoint(path, NULL, 40, 27);
        // 为了绘制跨越起始点的线段，所以路径绕两圈
        CGPathAddLineToPoint(path, NULL, 40, 2.5);
        CGPathAddLineToPoint(path, NULL, 2.5, 22);
        CGPathAddLineToPoint(path, NULL, 2.5, 27);
        CGPathAddLineToPoint(path, NULL, 30, 27);
        CGPathAddLineToPoint(path, NULL, 30, 2.5);
        CGPathAddLineToPoint(path, NULL, 2.5, 2.5);
        CGPathAddLineToPoint(path, NULL, 2.5, 7.5);
        CGPathAddLineToPoint(path, NULL, 40, 27);
        CGPathCloseSubpath(path);
        
        CGRect layerFrame = CGRectMake(0, 0, 40, 40);
        
        self.redLayer = [CAShapeLayer new];
        self.redLayer.strokeColor = UIColor.redColor.CGColor;
        self.redBorderLayer = [CAShapeLayer new];
        
        self.blueLayer = [CAShapeLayer new];
        self.blueLayer.strokeColor = UIColor.blueColor.CGColor;
        self.blueBorderLayer = [CAShapeLayer new];
        
        self.whiteLayer = [CAShapeLayer new];
        self.whiteLayer.strokeColor = UIColor.whiteColor.CGColor;
        self.whiteBorderLayer = [CAShapeLayer new];
        
        NSArray<CAShapeLayer *> *layers = @[self.redLayer, self.blueLayer, self.whiteLayer];
        for (CAShapeLayer *layer in layers) {
            layer.frame = layerFrame;
            layer.lineWidth = 5;
            layer.path = path;
            layer.fillColor = nil;
            layer.lineJoin = kCALineJoinRound;
        }
        
        NSArray<CAShapeLayer *> *borderLayers = @[self.redBorderLayer, self.blueBorderLayer, self.whiteBorderLayer];
        for (CAShapeLayer *layer in borderLayers) {
            layer.frame = layerFrame;
            layer.lineWidth = 5.2;
            layer.path = path;
            layer.fillColor = nil;
            layer.strokeColor = UIColor.grayColor.CGColor;
            layer.lineJoin = kCALineJoinRound;
        }
        
        
        NSArray *ssFromValues = @[@(0 * 0.5), @(0.338 * 0.5), @(0.498 * 0.5)];
        NSArray *ssToValues = @[@(1 * 0.5), @(1.338 * 0.5), @(1.498 * 0.5)];
        NSArray *seFromValues = @[@(0.16 * 0.5), @(0.498 * 0.5), @(1 * 0.5)];
        NSArray *seToValues = @[@(1.16 * 0.5), @(1.498 * 0.5), @(2 * 0.5)];
        
        for (int i = 0; i < layers.count; i++) {
            [self.layer addSublayer:borderLayers[i]];
            [self.layer addSublayer:layers[i]];
            
            
            CABasicAnimation *ssAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
            ssAnimation.fromValue = ssFromValues[i];
            ssAnimation.toValue = ssToValues[i];
            
            CAAnimation *seAnimation = nil;
            if (layers[i] == self.redLayer) { // 红色图层进行特殊处理，因为红色图层动画不跨越起始点
                CAKeyframeAnimation *strokeEndAnimation = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
                strokeEndAnimation.values = @[@(0.16 * 0.5), @(1 * 0.5), @(1 * 0.5)];
                strokeEndAnimation.keyTimes = @[@0, @0.84, @1];
                seAnimation = strokeEndAnimation;
            } else {
                CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
                strokeEndAnimation.fromValue = seFromValues[i];
                strokeEndAnimation.toValue = seToValues[i];
                seAnimation = strokeEndAnimation;
            }
            
            CAAnimationGroup *group = [CAAnimationGroup animation];
            group.animations = @[ssAnimation, seAnimation];
            group.duration = 2;
            group.repeatCount = INFINITY;
            group.removedOnCompletion = NO;
            [layers[i] addAnimation:group forKey:@"AnimationGroup"];
            [borderLayers[i] addAnimation:group forKey:@"AnimationGroup"];
        }
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(60, 60);
}

@end
