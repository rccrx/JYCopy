//
//  AppDelegate.m
//  JYCopy
//
//  Created by crx on 2021/10/13.
//

#import "AppDelegate.h"
#import "RCMainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    RCMainTabBarController *mainTBC = [[RCMainTabBarController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.rootViewController = mainTBC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
