//
//  UILabel+Creation.m
//  RCUtility
//
//  Created by crx on 2021/10/15.
//

#import "UILabel+Creation.h"

@implementation UILabel (Creation)

+ (instancetype)rut_labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment {
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = textAlignment;
    return label;
}

+ (instancetype)rut_labelWithTextColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment cornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)backgroundColor {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    label.textAlignment = textAlignment;
    label.layer.cornerRadius = cornerRadius;
    label.layer.masksToBounds = YES;
    label.backgroundColor = backgroundColor;
    return label;
}

+ (instancetype)rut_labelWithTextColor:(UIColor *)textColor font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = textColor;
    label.font = font;
    return label;
}

@end
