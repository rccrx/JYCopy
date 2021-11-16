//
//  RCCarouselView.h
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//@protocol RCPageControlDelegate;

@interface RCCarouselView : UIView

@property (nonatomic, copy) NSArray<UIImage *> *images;
/** 设置时会自动添加到self中，但还需要手动设置约束 */
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 * @param imageEdgeInsets 图片距离scrollView的边源边距
 * @param viewWidth 整个视图宽度
 * @param viewHeight 整个视图高度
 */
- (instancetype)initWithImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight;

@end



//@protocol RCPageControlDelegate <NSObject>
//
//@end

NS_ASSUME_NONNULL_END
