//
//  RCTabBarItem.m
//  RCMain
//
//  Created by crx on 2021/10/15.
//

#import "RCTabBarItem.h"
#import "UILabel+Creation.h"
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
        
//        self.titleLabel = [UILabel labelWithText:title textColor:<#(nonnull UIColor *)#> font:<#(nonnull UIFont *)#> textAlignment:<#(NSTextAlignment)#>]
    }
    return self;
}

- (void)imgButtonClicked:(UIButton *)button {
    
}

@end
