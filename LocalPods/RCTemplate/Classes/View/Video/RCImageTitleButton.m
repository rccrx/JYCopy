//
//  RCImageTitleButton.m
//  RCTemplate
//
//  Created by crx on 2022/3/2.
//

#import "RCImageTitleButton.h"

@interface RCImageTitleButton ()
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation RCImageTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageButton = [[UIButton alloc] init];
        [self addSubview:self.imageButton];
        [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(self);
            make.width.height.equalTo(@30); // 之后会被修改
        }];
        
        self.titleLabel = [UILabel rut_labelWithText:nil textColor:UIColor.whiteColor font:Font_PFSC_R(10) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@(self.titleLabel.font.lineHeight));
        }];
    }
    return self;
}

+ (instancetype)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    RCImageTitleButton *button = [[RCImageTitleButton alloc] init];
    [button.imageButton setImage:image forState:UIControlStateNormal];
    [button.imageButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button.imageButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(image.size.width));
        make.height.equalTo(@(image.size.height));
    }];
    return button;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

@end
