//
//  RCTemplateCollectionRequestErrorView.m
//  RCTemplate
//
//  Created by crx on 2021/12/14.
//

#import "RCTemplateCollectionRequestErrorView.h"

@interface RCTemplateCollectionRequestErrorView ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation RCTemplateCollectionRequestErrorView

- (instancetype)init {
    if (self = [super init]) {
        self.textLabel = [UILabel rut_labelWithText:@"网络错误，请点击重试" textColor:UIColor.redColor font:Font_PFSC_R(20) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textLabelDidTapped:)];
        self.textLabel.userInteractionEnabled = YES;
        [self.textLabel addGestureRecognizer:tap];
    }
    return self;
}

- (void)textLabelDidTapped:(UITapGestureRecognizer *)tap {
    self.tapAction?self.tapAction():nil;
}

@end
