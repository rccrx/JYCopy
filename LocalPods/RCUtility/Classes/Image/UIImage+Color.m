//
//  UIImage+Color.m
//  RCUtility
//
//  Created by crx on 2021/10/22.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

- (UIImage *)rut_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    
    [self drawInRect:bounds blendMode:blendMode alpha:1];
    if (blendMode != kCGBlendModeDestinationIn) {
        // 这一步是为了保留透明信息，xxDestinationIn的效果是“R = D*Sa”，D是包含alpha的目标色，Sa是原色的alpha，这里的原色应该指的是self也就是本图片的颜色，目标色应该指的是已经绘制的背景的颜色(即第一次drawInRect:blendMode:alpha:的结果)
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1];
    }
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}

- (UIImage *)rut_imageWithTintColor:(UIColor *)tintColor {
    return [self rut_imageWithTintColor:tintColor blendMode:kCGBlendModeDestinationIn];
}

- (UIImage *)rut_imageOfGrayscaleWithTintColor:(UIColor *)tintColor {
    return [self rut_imageWithTintColor:tintColor blendMode:kCGBlendModeOverlay];
}

@end
