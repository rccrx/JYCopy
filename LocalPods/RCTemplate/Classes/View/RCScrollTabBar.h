//
//  RCScrollTabBar.h
//  LookinServer
//
//  Created by crx on 2021/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RCScrollTabBarDelegate;

@interface RCScrollTabBar : UIView

@property (nonatomic, weak) id<RCScrollTabBarDelegate> delegate;
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;
@property (nonatomic, assign, readonly) NSUInteger tabCount;

/** barHeight用来设置item的位置 */
- (void)setItemTitles:(NSArray<NSString *> *)titles barHeight:(CGFloat)barHeight;
- (void)setSelectedIndex:(NSUInteger)selectedIndex animated:(BOOL)animated;

@end



@protocol RCScrollTabBarDelegate<NSObject>
@optional
- (void)scrollTabBar:(RCScrollTabBar *)scrollTabBar didSelectItem:(NSUInteger)selectedIndex;
@end

NS_ASSUME_NONNULL_END
