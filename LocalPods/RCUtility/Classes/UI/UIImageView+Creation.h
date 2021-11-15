//
//  UIImageView+Creation.h
//  RCUtility
//
//  Created by crx on 2021/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Creation)

+ (instancetype)rut_imageViewWithImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode;

@end

NS_ASSUME_NONNULL_END
