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

@end
