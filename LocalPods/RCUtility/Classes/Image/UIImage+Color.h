//
//  UIImage+Color.h
//  RCUtility
//
//  Created by crx on 2021/10/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)

/** 一般情况下使用-rut_imageWithTintColor:或者-rut_imageOfGrayscaleWithTintColor:即可 */
- (UIImage *)rut_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
/** 适用于纯色图片，保留透明信息 */
- (UIImage *)rut_imageWithTintColor:(UIColor *)tintColor;
/** 适用于需要保留灰度信息的情况，比如用于灰度图片（图片中原本灰色即与UIColor.grayColor同色的部分会显示为tintColor，其他颜色换算成灰度等级显示亮一点或暗一点）*/
- (UIImage *)rut_imageOfGrayscaleWithTintColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
