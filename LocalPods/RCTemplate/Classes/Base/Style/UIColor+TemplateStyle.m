//
//  UIColor+TemplateStyle.m
//  RCTemplate
//
//  Created by crx on 2021/11/12.
//

#import "UIColor+TemplateStyle.h"

@implementation UIColor (TemplateStyle)

+ (UIColor *)rte_themeColor {
    return RGB(0xF1385A);
}

+ (UIColor *)rte_backgroundColor {
    return UIColor.rte_color181818;
}

+ (UIColor *)rte_color181818 {
    return RGB(0x181818);
}

+ (UIColor *)rte_color282828 {
    return RGB(0x282828);
}

+ (UIColor *)rte_colorFCCF14 {
    return RGB(0xFCCF14);
}

+ (UIColor *)rte_color8C8C8C {
    return RGB(0x8C8C8C);
}

+ (UIColor *)rte_colorCDCDCD {
    return RGB(0xCDCDCD);
}

+ (UIColor *)rte_colorA2A2A2 {
    return RGB(0xA2A2A2);
}

+ (UIColor *)rte_color000000WithAlpha:(CGFloat)alpha {
    return RGBA(0x000000, alpha);
}

+ (UIColor *)rte_colorFCCF14WithAlpha:(CGFloat)alpha {
    return RGBA(0xFCCF14, alpha);
}

+ (UIColor *)rte_colorFFFFFFWithAlpha:(CGFloat)alpha {
    return RGBA(0xFFFFFF, alpha);
}

@end
