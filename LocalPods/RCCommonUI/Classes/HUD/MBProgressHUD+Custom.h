//
//  MBProgressHUD+Custom.h
//  Pods
//
//  Created by crx on 2021/12/10.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (Custom)

+ (instancetype)showLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated;
/** 找到view.subviews中最顶层的且没有完成的LoadingHUD，然后隐藏且返回YES，否则返回NO。 */
+ (BOOL)hideLoadingHUDForView:(UIView *)view animated:(BOOL)animated;

/** 不用调用hidexx方法，duration时间之后会自动消失 */
+ (instancetype)showAutohideTextHUDAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text duration:(NSTimeInterval)duration;
/** 不用调用hidexx方法，1.5s之后会自动消失 */
+ (instancetype)showAutohideTextHUDAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
