//
//  RCTabBarController.h
//  RCMain
//
//  Created by crx on 2021/11/11.
//

#import <UIKit/UIKit.h>
#import "RCTabBar.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RCTabBarControllerDelegate;

@interface RCTabBarController : UIViewController <RCTabBarDelegate>

@property (nonatomic, copy) NSArray<UIViewController *> *viewControllers;
/** 设置的时候会将tabBar添加到RCTabBarController.view中，并将self设置为tabBar的delegate，但还需要手动设置约束 */
@property (nonatomic, strong) RCTabBar *tabBar;
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, weak) id<RCTabBarControllerDelegate> delegate;

/** 修改viewControllers的view的底部约束，默认情况下等于父视图即RCTabBarController.view的下边界。 */
- (void)updateViewsBottomMargin:(CGFloat)bottomMargin;

@end



@protocol RCTabBarControllerDelegate <NSObject>
@optional
- (BOOL)tabBarController:(RCTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(RCTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
