//
//  UIImage+Template.m
//  RCTemplate
//
//  Created by crx on 2021/11/14.
//

#import "UIImage+Template.h"

@implementation UIImage (Template)

+ (NSBundle *)rte_getRCTemplateBundle {
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"RCTemplateViewController")]; // 这个类名必须是本模块即RCTemplate中包含的类
    NSString *path = [bundle pathForResource:@"RCTemplate" ofType:@"bundle"];
    NSBundle *templateBundle = [NSBundle bundleWithPath:path];
    return templateBundle;
}

+ (UIImage *)rte_imageNamedInTemplateBundle:(NSString *)name {
    return [UIImage imageNamed:name inBundle:[self rte_getRCTemplateBundle] compatibleWithTraitCollection:nil];
}

@end
