//
//  RCSearchBar.h
//  RCTemplate
//
//  Created by crx on 2021/11/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class RCSearchTextFiled;

@interface RCSearchBar : UIView

@property (nonatomic, strong) RCSearchTextFiled *searchTextField;
@property (nonatomic, strong) UIButton *cancelButton;

@end

NS_ASSUME_NONNULL_END
