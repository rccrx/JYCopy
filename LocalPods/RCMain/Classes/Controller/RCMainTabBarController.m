//
//  RCMainTabBarController.m
//  RCMain
//
//  Created by crx on 2021/10/14.
//

#import "RCMainTabBarController.h"
#import "RCTabBarButton.h"
#import "RCTemplateViewController.h"

@implementation RCMainTabBarController

- (instancetype)init {
    if (self = [super init]) {
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
        UIView *tabBarLineView = [UIView rut_viewWithBackgroundColor:UIColor.rma_color2F2F2F];
        [tabBar addSubview:tabBarLineView];
        [tabBarLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tabBar);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(tabBar.mas_top);
        }];
        
        self.tabBar = tabBar;
        [tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(60));
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        
        
        RCTemplateViewController *templateVC = [RCTemplateViewController new];
        UINavigationController *templateNav = [[UINavigationController alloc] initWithRootViewController:templateVC];
        
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
        
        self.viewControllers = @[templateNav, vc2, vc3];
        [self updateViewsBottomMargin:-60];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
