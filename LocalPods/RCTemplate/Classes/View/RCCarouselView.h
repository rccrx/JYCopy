//
//  RCCarouselView.h
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCCarouselView : UIView

@property (nonatomic, copy) NSArray<UIImage *> *images;

/**
 * @param imageEdgeInsets 图片距离scrollView的边源边距
 * @param viewWidth 整个视图宽度
 * @param viewHeight 整个视图高度
 */
- (instancetype)initWithImageEdgeInsets:(UIEdgeInsets)imageEdgeInsets viewWidth:(CGFloat)viewWidth viewHeight:(CGFloat)viewHeight;

@end

NS_ASSUME_NONNULL_END
