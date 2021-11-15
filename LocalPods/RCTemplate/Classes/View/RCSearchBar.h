//
//  RCSearchBar.h
//  RCTemplate
//
//  Created by crx on 2021/11/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RCSearchTextField;

@interface RCSearchBar : UIView

/** 设置的时候会将searchTextField添加到RCSearchBar中，但还需要手动设置约束 */
@property (nonatomic, strong) RCSearchTextField *searchTextField;
/** 设置的时候会将cancelButton添加到RCSearchBar中，但还需要手动设置约束 */
@property (nonatomic, strong) UIButton *cancelButton;

@end

NS_ASSUME_NONNULL_END
