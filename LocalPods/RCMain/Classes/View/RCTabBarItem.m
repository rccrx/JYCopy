//
//  RCTabBarItem.m
//  RCMain
//
//  Created by crx on 2021/10/15.
//

#import "RCTabBarItem.h"

@interface RCTabBarItem ()

@property (nonatomic, strong) UIButton *imgButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation RCTabBarItem

- (instancetype)initWithTitle:(NSString *)title image:(nonnull UIImage *)image selectedImage:(nonnull UIImage *)selectedImage size:(CGSize)size {
    if (self = [super init]) {
        self.bounds = CGRectMake(0, 0, size.width, size.height);
        
        self.imgButton = [UIButton rut_buttonWithImage:image selectedImage:selectedImage target:self action:@selector(imgButtonClicked:)];
        [self addSubview:self.imgButton];
        [self.imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.centerX.equalTo(self);
            make.top.equalTo(self);
        }];
        
        self.titleLabel = [UILabel rut_labelWithText:title textColor:UIColor.rma_color8C8C8C font:Font_PFSC_R(11) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@(self.titleLabel.font.lineHeight));
            make.bottom.equalTo(self);
        }];
        
        self.lineView = [UIView rut_viewWithBackgroundColor:UIColor.rma_themeColor cornerRadius:1];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@2);
            make.bottom.equalTo(self).offset(-5);
            make.width.equalTo(@22);
            make.centerX.equalTo(self);
        }];
        
        self.selected = NO;
    }
    return self;
}

- (void)imgButtonClicked:(UIButton *)button {
    self.selected = !self.selected;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.imgButton.selected = selected;
    self.titleLabel.hidden = selected;
    self.lineView.hidden = !selected;
}

@end
