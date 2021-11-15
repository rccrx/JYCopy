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

@end
