//
//  RCTemplateCollectionEmptyView.m
//  RCTemplate
//
//  Created by crx on 2021/12/14.
//

#import "RCTemplateCollectionEmptyView.h"

@interface RCTemplateCollectionEmptyView ()
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation RCTemplateCollectionEmptyView

- (instancetype)init {
    if (self = [super init]) {
        self.textLabel = [UILabel rut_labelWithText:@"没有数据" textColor:UIColor.whiteColor font:Font_PFSC_R(20) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
    }
    return self;
}

@end
