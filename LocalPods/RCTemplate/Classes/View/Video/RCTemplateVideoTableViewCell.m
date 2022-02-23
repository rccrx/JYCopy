//
//  RCTemplateVideoTableViewCell.m
//  Pods
//
//  Created by crx on 2022/2/19.
//

#import "RCTemplateVideoTableViewCell.h"

@interface RCTemplateVideoTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation RCTemplateVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_M(16)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.width.equalTo(@100);
            make.height.equalTo(@50);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        
        self.nameLabel.backgroundColor = UIColor.redColor;
    }
    return self;
}

@end
