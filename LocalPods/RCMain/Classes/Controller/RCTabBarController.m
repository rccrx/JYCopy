//
//  RCTabBarController.m
//  RCMain
//
//  Created by crx on 2021/11/11.
//

#import "RCTabBarController.h"

@interface RCTabBarController ()

@end

@implementation RCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Setter & Getter
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
    for (UIViewController *vc in _viewControllers) {
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
    if (self.tabBar) {
        [self.view bringSubviewToFront:self.tabBar];
    }
}

- (void)setTabBar:(RCTabBar *)tabBar {
    _tabBar = tabBar;
    _tabBar.delegate = self;
    [self.view addSubview:_tabBar];
}

//- (void)setSelectedViewController:(UIViewController *)selectedViewController {
//    NSUInteger idx = [self.viewControllers indexOfObject:selectedViewController];
//    if (idx < self.viewControllers.count) {
//        _selectedViewController = selectedViewController;
//        _selectedIndex = idx;
//    }
//}
//
//- (void)setSelectedIndex:(NSUInteger)selectedIndex {
//    if (selectedIndex < self.viewControllers.count) {
//        _selectedIndex = selectedIndex;
//
//    }
//}

#pragma mark - RCTabBarDelegate
- (void)tabBar:(RCTabBar *)tabBar didSelectItem:(UIControl<RCTabBarItemDelegate> *)item {
    NSLog(@"1abcitem=%@", item);
    NSUInteger idx = [tabBar.items indexOfObject:item];
    self.selectedIndex = idx;
    if (self.viewControllers.count > idx) {
        self.selectedViewController = self.viewControllers[idx];
    }
}

#pragma mark - Private

#pragma mark - Public
- (void)updateViewsBottomMargin:(CGFloat)bottomMargin {
    for (UIViewController *vc in self.viewControllers) {
        [vc.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(bottomMargin);
        }];
    }
}

@end
