//
//  UIImageView+Creation.h
//  RCUtility
//
//  Created by crx on 2021/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Creation)

+ (instancetype)rut_imageViewWithImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode;

+ (instancetype)rut_imageViewWithCornerRadius:(CGFloat)cornerRadius contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor;

@end

NS_ASSUME_NONNULL_END
