//
//  RCTabBar.h
//  RCMain
//
//  Created by crx on 2021/10/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RCTabBarDelegate;
@protocol RCTabBarItemDelegate;

@interface RCTabBar : UIView

@property (nonatomic, weak) id<RCTabBarDelegate> delegate;
@property (nonatomic, copy) NSArray<UIControl<RCTabBarItemDelegate> *> *items;
/** 第一个item的centerX距离父视图左边距，最后一个item的centerX距离父视图右边距 */
@property (nonatomic, assign) CGFloat itemCenterXLRMargin;
@property (nonatomic, assign) CGFloat itemSpacing;

@end



@protocol RCTabBarDelegate<NSObject>
@optional
- (void)tabBar:(RCTabBar *)tabBar didSelectItem:(UIControl<RCTabBarItemDelegate> *)item;
@end



@protocol RCTabBarItemDelegate <NSObject>



@end

NS_ASSUME_NONNULL_END
