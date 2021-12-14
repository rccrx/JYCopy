//
//  MBProgressHUD+Custom.m
//  Pods
//
//  Created by crx on 2021/12/10.
//

#import "MBProgressHUD+Custom.h"
#import "RCLoadingView.h"

@implementation MBProgressHUD (Custom)

+ (instancetype)showLoadingHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    RCLoadingView *loadingView = [RCLoadingView new];
    hud.customView = loadingView;
    hud.margin = 30;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = UIColor.clearColor;
    [view addSubview:hud];
    
    [hud showAnimated:animated];
    return hud;
}

+ (BOOL)hideLoadingHUDForView:(UIView *)view animated:(BOOL)animated {
    return [MBProgressHUD hideHUDForView:view animated:animated];
}

+ (instancetype)showTextHUDAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.label.textColor = UIColor.whiteColor;
    hud.label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.5];
    hud.bezelView.layer.cornerRadius = 3;
    hud.margin = 14;
    [view addSubview:hud];
    
    [hud showAnimated:animated];
    return hud;
}

+ (instancetype)showAutohideTextHUDAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text duration:(NSTimeInterval)duration {
    MBProgressHUD *hud = [self showTextHUDAddedTo:view animated:animated text:text];
    [hud hideAnimated:animated afterDelay:duration];
    return hud;
}

+ (instancetype)showAutohideTextHUDAddedTo:(UIView *)view animated:(BOOL)animated text:(NSString *)text {
    return [self showAutohideTextHUDAddedTo:view animated:animated text:text duration:1.5];
}

@end
