//
//  UIImage+Main.m
//  RCMain
//
//  Created by crx on 2021/10/15.
//

#import "UIImage+Main.h"

@implementation UIImage (Main)

+ (NSBundle *)rma_getRCMainBundle {
    // 注意：这个类名必须是本模块即RCMain中包含的类
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"RCMainTabBarController")]; // 可以兼容Podfile使用和不使用”use_frameworks!“两种情况
    NSString *path = [bundle pathForResource:@"RCMain" ofType:@"bundle"];
    NSBundle *rcmainBundle = [NSBundle bundleWithPath:path];
    return rcmainBundle;
}

+ (UIImage *)rma_imageNamedInMainBundle:(NSString *)name {
    return [UIImage imageNamed:name inBundle:[self rma_getRCMainBundle] compatibleWithTraitCollection:nil];
}

@end
