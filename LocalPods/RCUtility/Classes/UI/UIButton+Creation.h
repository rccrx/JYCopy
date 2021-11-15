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

@end

NS_ASSUME_NONNULL_END
