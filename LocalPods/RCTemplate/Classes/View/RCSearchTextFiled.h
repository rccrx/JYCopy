//
//  RCSearchTextFiled.h
//  RCTemplate
//
//  Created by crx on 2021/11/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RCTextFieldViewMode) {
    RCTextFieldViewModeNone,
    RCTextFieldViewModeWhileHasText,           /**< 有文本时才出现 */
    RCTextFieldViewModeWhileHasTextAndEditing  /**< 有文本且是编辑模式时 */
};

@interface RCSearchTextFiled : UITextField

/** 默认为RCTextFieldViewModeNone，表示使用rightViewMode；设置了这个属性之后，原本的rightViewMode会根据情况自动变化。 */
@property (nonatomic, assign) RCTextFieldViewMode customRightViewMode;
/** leftView的位置，不设置或者CGRectZero则使用默认位置 */
@property (nonatomic, assign) CGRect leftViewRect;
/** rightView的位置，不设置或者CGRectZero则使用默认位置 */
@property (nonatomic, assign) CGRect rightViewRect;
/**
 * 控制非编辑模式时文字的显示位置，
 * 即编辑文字然后退出编辑模式或者一开始设置text时的文字位置，
 * 不设置或者CGRectZero则使用默认位置。
 * 注意：textRect的origin.y和size.height设置会被忽视，而保持[super textRectForBounds:bounds]中获得的rect的y和height。
 */
@property (nonatomic, assign) CGRect textRect;
/** 编辑模式时文字的位置，不设置或者CGRectZero则使用默认位置 */
@property (nonatomic, assign) CGRect editingRect;
/** placeholder的位置，不设置或者CGRectZero则使用默认位置 */
@property (nonatomic, assign) CGRect placeholderRect;
@property (nonatomic, strong) UIColor *placeholderColor;


/**
 * @param searchIcon leftView的图标，默认leftViewMode是UITextFieldViewModeAlways；如果为nil则没有leftView。
 * @param clearIcon rightView的图标，默认rightViewMode是UITextFieldViewModeWhileEditing；如果为nil则没有rightView。
 */
- (instancetype)initWithSearchIcon:(nullable UIImage *)searchIcon clearIcon:(nullable UIImage *)clearIcon;

@end

NS_ASSUME_NONNULL_END
