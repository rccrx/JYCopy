//
//  RCMainTabBarController.m
//  RCMain
//
//  Created by crx on 2021/10/14.
//

#import "RCMainTabBarController.h"
#import "RCTabBarButton.h"

@interface RCMainTabBarController () <RCTabBarDelegate, RCTabBarControllerDelegate>

@end

@implementation RCMainTabBarController
//- (BOOL)tabBarController:(RCTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//    NSLog(@"shousel:tbc=%@, vc=%@", tabBarController, viewController);
//    if (viewController == tabBarController.viewControllers[1]) {
////        return NO;
//    }
//    return YES;
//}
//
//- (void)tabBarController:(RCTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
//    NSLog(@"dislel:tbc=%@, vc=%@", tabBarController, viewController);
//}

- (instancetype)init {
    if (self = [super init]) {
#if 0
        NSLog(@"self.omor=%@, self.tabbar=%@", self.moreNavigationController, self.tabBar);
        UITabBarItem *item1 = [[UITabBarItem alloc] initWithTitle:@"1" image:nil selectedImage:nil];
        UITabBarItem *item2 = [[UITabBarItem alloc] initWithTitle:@"2" image:nil selectedImage:nil];
        UITabBarItem *item3 = [[UITabBarItem alloc] initWithTitle:@"3" image:nil selectedImage:nil];
        UIViewController *vc1 = [UIViewController new];
        vc1.view.backgroundColor = UIColor.whiteColor;
        vc1.tabBarItem = item1;
        
        UIViewController *vc2 = [UIViewController new];
        vc2.view.backgroundColor = UIColor.redColor;
        vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"20" image:nil selectedImage:nil];
        
        UIViewController *vc3 = [UIViewController new];
        vc3.view.backgroundColor = UIColor.greenColor;
        vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"13" image:nil selectedImage:nil];
        UIViewController *vc4 = [UIViewController new];
        vc4.view.backgroundColor = UIColor.blueColor;
        UIImage *image = [UIImage rma_imageNamedInMainBundle:@"mine"];
        vc4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"1234" image:image selectedImage:nil];
        
        UIImage *selectedImage = [UIImage rma_imageNamedInMainBundle:@"mine"];
        
        
        
        UIViewController *vc5 = [UIViewController new];
        vc5.view.backgroundColor = UIColor.yellowColor;
        UIViewController *vc6 = [UIViewController new];
        vc6.view.backgroundColor = UIColor.systemPinkColor;
        
//        self.viewControllers = @[vc1, vc2, vc3];
        self.delegate = self;
        self.viewControllers = @[vc1, vc2, vc3, vc4, vc5, vc6];
//        self.tabBar.frame = CGRectMake(20, -20, 100, 100);
//        self.tabBar.hidden = YES;
//        [self.tabBar removeFromSuperview];
        self.selectedIndex = 2;
//        self.selectedViewController = vc2;
//        self.selectedViewController = [UIViewController new];
//        self.selectedViewController = nil;
        NSLog(@"selfvcs=%@, self.slelectecvc=%@, self.selecindx=%llu", self.viewControllers, self.selectedViewController, self.selectedIndex);
#else
        RCTabBarButton *itm1 = [[RCTabBarButton alloc]
                                initWithTitle:@"剪辑"
                                image:[[UIImage rma_imageNamedInMainBundle:@"clip"] rut_imageWithTintColor:UIColor.rma_color8C8C8C]
                                selectedImage:[[UIImage rma_imageNamedInMainBundle:@"clip"] rut_imageWithTintColor:UIColor.whiteColor]
                                size:CGSizeMake(45, 45)];
        RCTabBarButton *itm2 = [[RCTabBarButton alloc]
                                initWithTitle:@"剪同款"
                                image:[[UIImage rma_imageNamedInMainBundle:@"template"] rut_imageWithTintColor:UIColor.rma_color8C8C8C]
                                selectedImage:[[UIImage rma_imageNamedInMainBundle:@"template"] rut_imageWithTintColor:UIColor.whiteColor]
                                size:CGSizeMake(45, 45)];
        RCTabBarButton *itm3 = [[RCTabBarButton alloc]
                                initWithTitle:@"我的"
                                image:[[UIImage rma_imageNamedInMainBundle:@"mine"] rut_imageWithTintColor:UIColor.rma_color8C8C8C]
                                selectedImage:[[UIImage rma_imageNamedInMainBundle:@"mine"] rut_imageWithTintColor:UIColor.whiteColor]
                                size:CGSizeMake(45, 45)];
        
        RCTabBar *tabBar = [[RCTabBar alloc] init];
        tabBar.items = @[itm1, itm2, itm3];
        tabBar.itemCenterXLRMargin = ScreenWidth / (tabBar.items.count * 2);
        tabBar.itemSpacing = tabBar.itemCenterXLRMargin * 2;
        tabBar.backgroundColor = UIColor.rma_color181818;
        self.tabBar = tabBar;
        [tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(60));
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        UIView *tabBarLineView = [UIView rut_viewWithBackgroundColor:UIColor.rma_color2F2F2F];
        [tabBar addSubview:tabBarLineView];
        [tabBarLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tabBar);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(tabBar.mas_top);
        }];
        
        
        UIViewController *vc1 = [UIViewController new];
        vc1.view.backgroundColor = UIColor.whiteColor;
        UIViewController *vc2 = [UIViewController new];
        vc2.view.backgroundColor = UIColor.redColor;
        UIViewController *vc3 = [UIViewController new];
        vc3.view.backgroundColor = UIColor.greenColor;
        UIView *view = [[UIView alloc] init];
        UIView *superview = vc3.view;
        [superview addSubview:view];
        view.backgroundColor = UIColor.magentaColor;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(superview);
            make.bottom.equalTo(superview);
            make.height.width.equalTo(@100);
        }];
        
        self.delegate = self;
        self.viewControllers = @[vc1, vc2, vc3];
        [self updateViewsBottomMargin:-60];
//        self.selectedViewController = vc2;
//        self.selectedIndex = 1;
#endif
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
