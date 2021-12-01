//
//  UIColor+TemplateStyle.h
//  RCTemplate
//
//  Created by crx on 2021/11/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (TemplateStyle)

/** 主题色：F1385A */
+ (UIColor *)rte_themeColor;
+ (UIColor *)rte_backgroundColor;

+ (UIColor *)rte_color181818;
+ (UIColor *)rte_color282828;
+ (UIColor *)rte_colorFCCF14;
+ (UIColor *)rte_color8C8C8C;
+ (UIColor *)rte_colorCDCDCD;
+ (UIColor *)rte_colorA2A2A2;

+ (UIColor *)rte_color000000WithAlpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
