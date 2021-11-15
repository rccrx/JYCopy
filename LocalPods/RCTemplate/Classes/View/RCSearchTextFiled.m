//
//  RCSearchTextFiled.m
//  RCTemplate
//
//  Created by crx on 2021/11/14.
//

#import "RCSearchTextFiled.h"

@implementation RCSearchTextFiled
#pragma mark - Life Cycle & Override
- (instancetype)initWithSearchIcon:(UIImage *)searchIcon clearIcon:(UIImage *)clearIcon {
    if (self = [super init]) {
        if (searchIcon) {
            UIImageView *leftView = [UIImageView rut_imageViewWithImage:searchIcon contentMode:UIViewContentModeCenter];
            self.leftView = leftView;
            self.leftViewMode = UITextFieldViewModeAlways;
        }
        
        if (clearIcon) {
            UIButton *rightView = [UIButton rut_buttonWithImage:clearIcon target:self action:@selector(clearButtonDidClicked:)];
            self.rightView = rightView;
            self.rightViewMode = UITextFieldViewModeWhileEditing;
        }
        
        [self addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged]; // 编辑时文字变化会触发这个事件；手动设置text属性时不触发（所以需要设置text的同时手动调用textDidChanged:）
        [self addTarget:self action:@selector(editingDidEnd:) forControlEvents:UIControlEventEditingDidEnd];
        [self addTarget:self action:@selector(editingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    if (CGRectEqualToRect(CGRectZero, self.leftViewRect)) {
        return [super leftViewRectForBounds:bounds];
    } else {
        return self.leftViewRect;
    }
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    if (CGRectEqualToRect(CGRectZero, self.rightViewRect)) {
        return [super rightViewRectForBounds:bounds];
    } else {
        return self.rightViewRect;
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    if (CGRectEqualToRect(CGRectZero, self.textRect)) {
        return [super textRectForBounds:bounds];
    } else {
        CGRect superTextRect = [super textRectForBounds:bounds];
        CGRect rect = self.textRect;
        rect.origin.y = superTextRect.origin.y;
        rect.size.height = superTextRect.size.height;
        return rect;
    }
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    if (CGRectEqualToRect(CGRectZero, self.editingRect)) {
        return [super editingRectForBounds:bounds];
    } else {
        return self.editingRect;
    }
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    if (CGRectEqualToRect(CGRectZero, self.placeholderRect)) {
        return [super placeholderRectForBounds:bounds];
    } else {
        return self.placeholderRect;
    }
}

#pragma mark - Action
- (void)textDidChanged:(UITextField *)tf {
    switch (self.customRightViewMode) {
        case RCTextFieldViewModeWhileHasText:
        {
            if (tf.text.length == 0) {
                self.rightViewMode = UITextFieldViewModeNever;
            } else {
                self.rightViewMode = UITextFieldViewModeAlways;
            }
            break;
        }
        case RCTextFieldViewModeWhileHasTextAndEditing:
        {
            if (tf.text.length == 0 || !tf.editing) {
                self.rightViewMode = UITextFieldViewModeNever;
            } else {
                self.rightViewMode = UITextFieldViewModeAlways;
            }
            break;
        }
        default:
            break;
    }
}

- (void)editingDidEnd:(UITextField *)tf {
    if (self.customRightViewMode == RCTextFieldViewModeWhileHasTextAndEditing) {
        if (tf.text.length == 0 || !tf.editing) {
            self.rightViewMode = UITextFieldViewModeNever;
        } else {
            self.rightViewMode = UITextFieldViewModeAlways;
        }
    }
}

- (void)editingDidBegin:(UITextField *)tf {
    if (self.customRightViewMode == RCTextFieldViewModeWhileHasTextAndEditing) {
        if (tf.text.length == 0 || !tf.editing) {
            self.rightViewMode = UITextFieldViewModeNever;
        } else {
            self.rightViewMode = UITextFieldViewModeAlways;
        }
    }
}

- (void)clearButtonDidClicked:(UIButton *)button {
    self.text = nil;
}

#pragma mark - Setter & Getter
- (void)setText:(NSString *)text {
    [super setText:text];
    [self textDidChanged:self];
}

- (void)setCustomRightViewMode:(RCTextFieldViewMode)customRightViewMode {
    _customRightViewMode = customRightViewMode;
    if (customRightViewMode == RCTextFieldViewModeNone) {
        self.rightViewMode = UITextFieldViewModeWhileEditing;
    } else {
        self.rightViewMode = UITextFieldViewModeNever;
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    if (self.placeholderColor) {
        NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: self.placeholderColor}];
        self.attributedPlaceholder = attStr;
    }
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    if (self.placeholder.length != 0) {
        self.placeholder = self.placeholder;
    }
}

@end
