//
//  UIImage+Main.h
//  RCMain
//
//  Created by crx on 2021/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Main)

/** 在RCMain.bundle中的图片，不是指[NSBundle mainBundle] */
+ (nullable UIImage *)imageNamedInMainBundle:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
