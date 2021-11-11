//
//  UILabel+Creation.h
//  RCUtility
//
//  Created by crx on 2021/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Creation)

+ (instancetype)rut_labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font textAlignment:(NSTextAlignment)textAlignment;

@end

NS_ASSUME_NONNULL_END