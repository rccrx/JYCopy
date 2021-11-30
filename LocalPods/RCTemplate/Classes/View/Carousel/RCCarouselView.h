//
//  RCCarouselView.h
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RCPageControl;

@interface RCCarouselView : UIView

@property (nonatomic, copy) NSArray<UIImage *> *images;
/** 设置时会自动添加到self中，但还需要手动设置约束 */
@property (nonatomic, strong) UIView<RCPageControl> *pageControl;
/** 启动或者暂停自动滑动（当本视图从父视图中移除时会停止滑动。） */
@property (nonatomic, assign) BOOL enableAutoslide;
/** 要在enableAutoslide设置为YES之前设置才生效，否则使用默认值 */
@property (nonatomic, assign) NSTimeInterval timeInterval;

/**
 * @param imageEdgeInsets 图片距离scrollView的边源边距
 * @param viewWidth 整个视图宽度
 * @param viewHeight 整个视图高度
 */
- (instancetype)initWithImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
