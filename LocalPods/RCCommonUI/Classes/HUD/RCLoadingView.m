//
//  RCLoadingView.m
//  RCCommonUI
//
//  Created by crx on 2021/12/10.
//

#import "RCLoadingView.h"

#define PointCount 9

@interface RCLoadingView ()
{
    CGPoint _pathPoints[PointCount]; // 路径的关键点
    CGFloat _pointScales[PointCount]; // 每个关键点的刻度，在0-1之间
}
@property (nonatomic, strong) CAShapeLayer *redLayer;
@property (nonatomic, strong) CAShapeLayer *blueLayer;
@property (nonatomic, strong) CAShapeLayer *whiteLayer;
@property (nonatomic, strong) CADisplayLink *animationDisplayLink;
@property (nonatomic, assign) CFTimeInterval animationStartTime;
@property (nonatomic, assign) CGFloat initialStartPoint; /**< 当前三个颜色图层中的蓝图层的起始点 */
@end

@implementation RCLoadingView

/** 如果strokeEnd > strokeStart，则表示所绘路径跨越(完整路径的)起始点 */
- (CGPathRef)calculatePathWithStrokeStart:(CGFloat)strokeStart strokeEnd:(CGFloat)strokeEnd {
    if (strokeStart == strokeEnd || !(strokeStart >= 0 && strokeStart <= 1) || !(strokeEnd >= 0 && strokeEnd <= 1)) {
        return NULL;
    }
    
    // 所画线段在这两个index之间
    int startIndex = -1;
    int endIndex = -1;
    for (int i = 0; i < PointCount; i++) {
        CGFloat scaleValueI = _pointScales[i];
        if (strokeStart < scaleValueI && startIndex == -1) {
            startIndex = i - 1;
        }
        if (strokeEnd <= scaleValueI && endIndex == -1) {
            endIndex = i;
        }
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    if (strokeStart < strokeEnd) {
        [self addSubpathToPath:path withStrokeStart:strokeStart strokeEnd:strokeEnd startIndex:startIndex endIndex:endIndex];
    } else {
        [self addSubpathToPath:path withStrokeStart:strokeStart strokeEnd:1 startIndex:startIndex endIndex:PointCount - 1];
        [self addSubpathToPath:path withStrokeStart:0 strokeEnd:strokeEnd startIndex:0 endIndex:endIndex];
    }
    return CGPathCreateCopyByStrokingPath(path, NULL, 5, kCGLineCapButt, kCGLineJoinRound, 0);
}

/** 设置_pathPoints和_pointScales的值，需要在调用“-calculatePathWithStrokeStart:strokeEnd:”之前设置好！！ */
- (void)setupPathPointsAndPointScales {
    // 设置_pathPoints
    _pathPoints[0] = CGPointMake(40, 2.5);
    _pathPoints[1] = CGPointMake(2.5, 22);
    _pathPoints[2] = CGPointMake(2.5, 27);
    _pathPoints[3] = CGPointMake(30, 27);
    _pathPoints[4] = CGPointMake(30, 2.5);
    _pathPoints[5] = CGPointMake(2.5, 2.5);
    _pathPoints[6] = CGPointMake(2.5, 7.5);
    _pathPoints[7] = CGPointMake(40, 27);
    _pathPoints[8] = CGPointMake(40, 2.5);
    
    // 设置_pointScales
    CGFloat segmentLengths[PointCount - 1] = {0};
    CGFloat totalLength = 0;
    for (int i = 0; i < PointCount - 1; i++) {
        CGPoint p1 = _pathPoints[i];
        CGPoint p2 = _pathPoints[i + 1];
        segmentLengths[i] = sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
        totalLength += segmentLengths[i];
    }
    
    CGFloat cumulativeLength = 0;
    for (int i = 1; i < PointCount; i++) {
        cumulativeLength += segmentLengths[i - 1];
        _pointScales[i] = cumulativeLength / totalLength;
    }
}

- (void)addSubpathToPath:(CGMutablePathRef)path withStrokeStart:(CGFloat)strokeStart strokeEnd:(CGFloat)strokeEnd startIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex {
    for (NSUInteger i = startIndex; i <= endIndex; i++) {
        CGFloat scaleValueI = _pointScales[i];
        CGPoint pointI = _pathPoints[i];
        if (i == startIndex) {
            CGPoint startPoint = CGPointZero;
            if (strokeStart == scaleValueI) {
                startPoint = pointI;
            } else {
                CGPoint pointIPlus1 = _pathPoints[i + 1];
                CGFloat scaleValueIPlus1 = _pointScales[i + 1];
                CGFloat ratio = (strokeStart - scaleValueI) / (scaleValueIPlus1 - scaleValueI); // 起始点的位置 相对于 所在线段 的比值
                startPoint = CGPointMake(pointI.x + ratio * (pointIPlus1.x - pointI.x), pointI.y + ratio * (pointIPlus1.y - pointI.y));
            }
            
            CGPathMoveToPoint(path, NULL, startPoint.x, startPoint.y);
        } else if (i > startIndex && i < endIndex) {
            CGPathAddLineToPoint(path, NULL, pointI.x, pointI.y);
        } else if (i == endIndex) {
            CGPoint endPoint = CGPointZero;
            if (strokeEnd == scaleValueI) {
                endPoint = pointI;
            } else {
                CGPoint pointIMinus1 = _pathPoints[i - 1];
                CGFloat scaleValueIMinus1 = _pointScales[i - 1];
                CGFloat ratio = (strokeEnd - scaleValueIMinus1) / (scaleValueI - scaleValueIMinus1); // 终止点的位置 相对于 所在线段 的比值
                endPoint = CGPointMake(pointIMinus1.x + ratio * (pointI.x - pointIMinus1.x), pointIMinus1.y + ratio * (pointI.y - pointIMinus1.y));
            }
            
            CGPathAddLineToPoint(path, NULL, endPoint.x, endPoint.y);
        }
    }
}

/** startPoint的值在0-1之间 */
- (void)setupShapeLayerPathWithStartPoint:(CGFloat)startPoint {
    CGFloat p1 = startPoint;
    CGFloat length = 0.158;
    CGFloat p2 = p1 + length;
    p2 = p2 > 1 ? (p2 - 1) : p2;
    CGFloat p3 = p2 + (1 - length - self.initialStartPoint);
    p3 = p3 > 1 ? (p3 - 1) : p3;
    CGFloat p4 = p3 + length;
    p4 = p4 > 1 ? (p4 - 1) : p4;
    
    self.blueLayer.path = [self calculatePathWithStrokeStart:p1 strokeEnd:p2];
    self.whiteLayer.path = [self calculatePathWithStrokeStart:p2 strokeEnd:p3];
    self.redLayer.path = [self calculatePathWithStrokeStart:p3 strokeEnd:p4];
}

- (void)strokeAnimation:(CADisplayLink *)displayLink {
    CGFloat animationDuration = 10;
    CGFloat tempRatio = (displayLink.targetTimestamp - self.animationStartTime) / animationDuration;
    CGFloat startPoint = self.initialStartPoint + (tempRatio - (NSInteger)tempRatio);
    startPoint = startPoint > 1 ? (startPoint - 1) : startPoint;
    [self setupShapeLayerPathWithStartPoint:startPoint];
    NSLog(@"aaaaaa: target=%f, temp=%f, target-curr=%f, time=%f, tar-time=%f", displayLink.targetTimestamp, tempRatio, displayLink.targetTimestamp - CACurrentMediaTime(), displayLink.timestamp, displayLink.targetTimestamp-displayLink.timestamp);
}

- (void)dealloc {
    NSLog(@"%@: %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)didMoveToSuperview {
    if (self.superview == nil) {
        [self.animationDisplayLink invalidate];
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        
        CGRect layerFrame = CGRectMake(0, 0, 40, 40);
        CGFloat lineWidth = 0.2;
        UIColor *strokeColor = UIColor.grayColor;
        
        self.redLayer = [CAShapeLayer new];
        self.redLayer.frame = layerFrame;
        self.redLayer.lineWidth = lineWidth;
        self.redLayer.strokeColor = strokeColor.CGColor;
        self.redLayer.fillColor = UIColor.redColor.CGColor;
        [self.layer addSublayer:self.redLayer];
        
        self.blueLayer = [CAShapeLayer new];
        self.blueLayer.frame = layerFrame;
        self.blueLayer.lineWidth = lineWidth;
        self.blueLayer.strokeColor = strokeColor.CGColor;
        self.blueLayer.fillColor = UIColor.blueColor.CGColor;
        [self.layer addSublayer:self.blueLayer];
        
        self.whiteLayer = [CAShapeLayer new];
        self.whiteLayer.frame = layerFrame;
        self.whiteLayer.lineWidth = lineWidth;
        self.whiteLayer.strokeColor = strokeColor.CGColor;
        self.whiteLayer.fillColor = UIColor.whiteColor.CGColor;
        [self.layer addSublayer:self.whiteLayer];
        
        [self setupPathPointsAndPointScales];
        self.initialStartPoint = 0.338;
        [self setupShapeLayerPathWithStartPoint:self.initialStartPoint];
        
        self.animationStartTime = CACurrentMediaTime();
        self.animationDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(strokeAnimation:)]; // 会导致循环引用，所以需要在视图消失时执行CADisplayLink的invalidate
        [self.animationDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(60, 60);
}

@end
