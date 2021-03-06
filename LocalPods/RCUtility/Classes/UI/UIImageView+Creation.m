//
//  UIImageView+Creation.m
//  RCUtility
//
//  Created by crx on 2021/11/15.
//

#import "UIImageView+Creation.h"

@implementation UIImageView (Creation)

+ (instancetype)rut_imageViewWithImage:(UIImage *)image contentMode:(UIViewContentMode)contentMode {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = contentMode;
    return imageView;
}

+ (instancetype)rut_imageViewWithContentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = contentMode;
    imageView.backgroundColor = backgroundColor;
    return imageView;
}

+ (instancetype)rut_imageViewWithCornerRadius:(CGFloat)cornerRadius contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.cornerRadius = cornerRadius;
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = contentMode;
    imageView.backgroundColor = backgroundColor;
    return imageView;
}

+ (instancetype)rut_imageViewWithCornerRadius:(CGFloat)cornerRadius contentMode:(UIViewContentMode)contentMode backgroundColor:(UIColor *)backgroundColor borderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor {
    UIImageView *imageView = [self rut_imageViewWithCornerRadius:cornerRadius contentMode:contentMode backgroundColor:backgroundColor];
    imageView.layer.borderWidth = borderWidth;
    imageView.layer.borderColor = borderColor;
    return imageView;
}

@end
