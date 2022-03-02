//
//  UIButton+Creation.m
//  RCUtility
//
//  Created by crx on 2021/10/15.
//

#import "UIButton+Creation.h"

@implementation UIButton (Creation)

+ (instancetype)rut_buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (instancetype)rut_buttonWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (instancetype)rut_buttonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.layer.cornerRadius = cornerRadius;
    button.backgroundColor = backgroundColor;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
