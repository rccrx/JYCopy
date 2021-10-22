//
//  UIView+Creation.m
//  RCUtility
//
//  Created by crx on 2021/10/15.
//

#import "UIView+Creation.h"

@implementation UIView (Creation)

+ (instancetype)rut_viewWithBackgroundColor:(UIColor *)color {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    return view;
}

+ (instancetype)rut_viewWithBackgroundColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = color;
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = true;
    return view;
}

@end
