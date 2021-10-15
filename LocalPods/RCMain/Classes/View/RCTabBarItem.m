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
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
}

@end
