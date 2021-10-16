//
//  RCMain.m
//  RCMain
//
//  Created by crx on 2021/10/15.
//

#import "RCMain.h"
#import "RCMainTabBarController.h"

@implementation RCMain

+ (UIViewController *)getMainTabBarController {
    RCMainTabBarController *mainTBC = [[RCMainTabBarController alloc] init];
    return mainTBC;
}

@end
