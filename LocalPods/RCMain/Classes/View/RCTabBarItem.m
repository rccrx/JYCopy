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

- (instancetype)initWithTitle:(NSString *)title image:(nonnull UIImage *)image selectedImage:(nonnull UIImage *)selectedImage {
    if (self = [super init]) {
        
        self.imgButton = [UIButton rut_buttonWithImage:image selectedImage:selectedImage target:self action:@selector(imgButtonClicked:)];
        [self addSubview:self.imgButton];
        [self.imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@30);
            make.centerX.equalTo(self);
            make.top.equalTo(self);
        }];
        
        self.titleLabel = [UILabel rut_labelWithText:title textColor:UIColor.rma_color818181 font:FontPFSCR(11) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.height.equalTo(@(self.titleLabel.font.lineHeight));
            make.bottom.equalTo(self);
        }];
        
        self.lineView = [UIView rut_viewWithBackgroundColor:UIColor.rma_themeColor cornerRadius:2];
        [self addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@2);
            make.bottom.equalTo(self).offset(-5);
            make.width.equalTo(@22);
            make.centerX.equalTo(self);
        }];
    }
    return self;
}

- (void)imgButtonClicked:(UIButton *)button {
    
}

@end
