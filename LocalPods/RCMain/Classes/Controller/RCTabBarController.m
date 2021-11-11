//
//  RCTabBarController.m
//  RCMain
//
//  Created by crx on 2021/11/11.
//

#import "RCTabBarController.h"

@interface RCTabBarController ()
@property (nonatomic, assign) CGFloat bottomMargin;
@end

@implementation RCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Setter & Getter
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    for (UIViewController *vc in self.viewControllers) {
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
    
    _viewControllers = viewControllers;
    
    for (UIViewController *vc in self.viewControllers) {
        [self addChildViewController:vc];
        [self.view addSubview:vc.view];
        [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view).offset(self.bottomMargin);
        }];
        [vc didMoveToParentViewController:self];
    }
    self.selectedIndex = 0;
    
    if (self.tabBar) {
        [self.view bringSubviewToFront:self.tabBar];
    }
}

- (void)setTabBar:(RCTabBar *)tabBar {
    _tabBar = tabBar;
    self.tabBar.delegate = self;
    [self.view addSubview:self.tabBar];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController {
    NSUInteger idx = [self.viewControllers indexOfObject:selectedViewController];
    BOOL didSet = [self setSelectedViewControllerAndSelectedIndexWithIndex:idx];
    if (didSet) {
        [self showSelectedViewControllerAndUpdateTabBarSelectedItem];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    BOOL didSet = [self setSelectedViewControllerAndSelectedIndexWithIndex:selectedIndex];
    if (didSet) {
        [self showSelectedViewControllerAndUpdateTabBarSelectedItem];
    }
}

#pragma mark - RCTabBarDelegate
- (BOOL)tabBar:(RCTabBar *)tabBar shouldSelectItem:(UIControl *)item {
    if ([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        NSUInteger idx = [tabBar.items indexOfObject:item];
        if (idx < self.viewControllers.count) {
            return [self.delegate tabBarController:self shouldSelectViewController:self.viewControllers[idx]];
        }
    }
    return YES;
}

- (void)tabBar:(RCTabBar *)tabBar didSelectItem:(UIControl *)item {
    NSUInteger idx = [tabBar.items indexOfObject:item];
    self.selectedIndex = idx;
    
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.delegate tabBarController:self didSelectViewController:self.selectedViewController];
    }
}

#pragma mark - Private
/** 返回是否重新设置了_selectedIndex和_selectedViewController变量 */
- (BOOL)setSelectedViewControllerAndSelectedIndexWithIndex:(NSUInteger)index {
    if (self.viewControllers.count == 0) {
        _selectedIndex = 0;
        _selectedViewController = nil;
        return YES;
    }
    
    if (index < self.viewControllers.count) {
        _selectedIndex = index;
        _selectedViewController = self.viewControllers[self.selectedIndex];
        return YES;
    } else {
        return NO;
    }
}

- (void)showSelectedViewControllerAndUpdateTabBarSelectedItem {
    for (UIViewController *vc in self.viewControllers) {
        vc.view.hidden = !(vc == self.selectedViewController);
    }
    if (self.selectedIndex < self.tabBar.items.count) {
        self.tabBar.selectedItem = self.tabBar.items[self.selectedIndex];
    }
}

#pragma mark - Public
- (void)updateViewsBottomMargin:(CGFloat)bottomMargin {
    self.bottomMargin = bottomMargin;
    
    for (UIViewController *vc in self.viewControllers) {
        [vc.view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view).offset(bottomMargin);
        }];
    }
}

@end
