//
//  RCMainTabBarController.m
//  RCMain
//
//  Created by crx on 2021/10/14.
//

#import "RCMainTabBarController.h"
#import "UIImage+Main.h"

@interface RCMainTabBarController ()

@end

@implementation RCMainTabBarController

- (instancetype)init {
    if (self = [super init]) {
        
        NSLog(@"self.omor=%@, self.tabbar=%@", self.moreNavigationController, self.tabBar);
        UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil selectedImage:nil];
        UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil selectedImage:nil];
        UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil selectedImage:nil];
        UIViewController *vc1 = [UIViewController new];
        vc1.view.backgroundColor = UIColor.blueColor;
        vc1.tabBarItem = item1;
        
        UIViewController *vc2 = [UIViewController new];
        vc2.view.backgroundColor = UIColor.redColor;
//        vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"20" image:nil selectedImage:nil];
        
        UIViewController *vc3 = [UIViewController new];
        vc3.view.backgroundColor = UIColor.greenColor;
//        vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"13" image:nil selectedImage:nil];
        UIViewController *vc4 = [UIViewController new];
        vc4.view.backgroundColor = UIColor.greenColor;
        UIImage *image = [UIImage imageNamedInMainBundle:@"petal"];
        vc4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"1234" image:image selectedImage:nil];
        UIViewController *vc5 = [UIViewController new];
        vc5.view.backgroundColor = UIColor.greenColor;
        UIViewController *vc6 = [UIViewController new];
        vc6.view.backgroundColor = UIColor.greenColor;
        
//        self.viewControllers = @[vc1, vc2, vc3];
        self.viewControllers = @[vc1, vc2, vc3, vc4, vc5, vc6];
//        self.tabBar.frame = CGRectMake(20, -20, 100, 100);
//        self.tabBar.hidden = YES;
//        [self.tabBar removeFromSuperview];
//
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
