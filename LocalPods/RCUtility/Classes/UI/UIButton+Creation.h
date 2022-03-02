//
//  UIButton+Creation.h
//  RCUtility
//
//  Created by crx on 2021/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Creation)

+ (instancetype)rut_buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action;

+ (instancetype)rut_buttonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action;

+ (instancetype)rut_buttonWithImage:(nullable UIImage *)image title:(nullable NSString *)title titleColor:(nullable UIColor *)titleColor font:(nullable UIFont *)font cornerRadius:(CGFloat)cornerRadius backgroundColor:(nullable UIColor *)backgroundColor target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
