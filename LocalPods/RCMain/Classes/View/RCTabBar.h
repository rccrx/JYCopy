//
//  RCTabBar.h
//  RCMain
//
//  Created by crx on 2021/10/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RCTabBarDelegate;

@interface RCTabBar : UIView

@property (nonatomic, weak) id<RCTabBarDelegate> delegate;
@property (nonatomic, copy) NSArray<UIControl *> *items;
/** 第一个item的centerX距离父视图左边距，最后一个item的centerX距离父视图右边距 */
@property (nonatomic, assign) CGFloat itemCenterXLRMargin;
@property (nonatomic, assign) CGFloat itemSpacing;
@property (nonatomic, weak) UIControl *selectedItem;

@end



@protocol RCTabBarDelegate<NSObject>

@optional
- (BOOL)tabBar:(RCTabBar *)tabBar shouldSelectItem:(UIControl *)item;
- (void)tabBar:(RCTabBar *)tabBar didSelectItem:(UIControl *)item;

@end

NS_ASSUME_NONNULL_END
