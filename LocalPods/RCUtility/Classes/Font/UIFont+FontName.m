//
//  UIFont+FontName.m
//  RCUtility
//
//  Created by crx on 2021/10/20.
//

#import "UIFont+FontName.h"

@implementation UIFont (FontName)

+ (UIFont *)rut_PingFangSCRegularFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
}

+ (UIFont *)rut_PingFangSCMediumFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
}

+ (UIFont *)rut_PingFangSCSemiboldFontOfSize:(CGFloat)fontSize {
    return [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
}

@end
