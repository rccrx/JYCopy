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

+ (instancetype)showTextHUDAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
