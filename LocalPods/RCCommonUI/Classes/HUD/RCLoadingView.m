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
        
        CGMutablePathRef maskPath = CGPathCreateMutable();
        CGPathMoveToPoint(maskPath, NULL, 0, 0);
        CGPathAddLineToPoint(maskPath, NULL, 37.5, 0);
        CGPathAddLineToPoint(maskPath, NULL, 37.5, 6.5);
        CGPathAddLineToPoint(maskPath, NULL, 21.5, 14.75);
        CGPathAddLineToPoint(maskPath, NULL, 37.5, 23);
        CGPathAddLineToPoint(maskPath, NULL, 37.5, 29.5);
        CGPathAddLineToPoint(maskPath, NULL, 0, 29.5);
        CGPathCloseSubpath(maskPath);
        
        
        CGRect layerFrame = CGRectMake(0, 0, 40, 40);
        
        CAShapeLayer *maskLayer = [CAShapeLayer new];
        maskLayer.frame = layerFrame;
        maskLayer.path = maskPath;
        self.layer.mask = maskLayer;
        
        self.redLayer = [CAShapeLayer new];
        self.redLayer.strokeColor = [UIColor colorWithRed:248/255.0 green:3/255.0 blue:88/255.0 alpha:1].CGColor;
        self.redBorderLayer = [CAShapeLayer new];
        
        self.blueLayer = [CAShapeLayer new];
        self.blueLayer.strokeColor = [UIColor colorWithRed:6/255.0 green:232/255.0 blue:250/255.0 alpha:1].CGColor;
        self.blueBorderLayer = [CAShapeLayer new];
        
        self.whiteLayer = [CAShapeLayer new];
        self.whiteLayer.strokeColor = UIColor.whiteColor.CGColor;
        self.whiteBorderLayer = [CAShapeLayer new];
        
        NSArray<CAShapeLayer *> *layers = @[self.redLayer, self.blueLayer, self.whiteLayer];
        for (CAShapeLayer *layer in layers) {
            layer.frame = layerFrame;
            layer.lineWidth = 4.3;
            layer.path = path;
            layer.fillColor = nil;
            layer.lineJoin = kCALineJoinRound;
        }
        
        NSArray<CAShapeLayer *> *borderLayers = @[self.redBorderLayer, self.blueBorderLayer, self.whiteBorderLayer];
        for (CAShapeLayer *layer in borderLayers) {
            layer.frame = layerFrame;
            layer.lineWidth = 4.5;
            layer.path = path;
            layer.fillColor = nil;
            layer.strokeColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1].CGColor;
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
            
            /* 优化微调：
             1、如果希望白色图层跨越截断处时显示斜线边框，则可以考虑将边框图层和颜色图层分开放在两个图层B和C中，然后B图层的mask比C图层的mask在截断处留出的空间宽一点点。（截断处指的是：靠近中间交叉点的右边第一条竖线被截断，截断的上部分和下部分都是斜角。）
             2、如果希望颜色图层与图层之间的线段连接处显示边框，则可以考虑边框图层的线段长度比颜色图层的线段长度长一点点。
             3、如果希望拐角处圆一点，可以考虑在路径的拐角处添加Arc弧形（现在是利用kCALineJoinRound添加拐角弧形）。
             */
        }
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(40, 40);
}

@end
