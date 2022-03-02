//
//  RCTemplateCollectionViewCell.m
//  RCTemplate
//
//  Created by crx on 2021/11/29.
//

#import "RCTemplateCollectionViewCell.h"
#import "RCEditTemplate.h"
#import "RCTemplateAuthor.h"

@interface RCTemplateCollectionViewCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation RCTemplateCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = UIColor.rte_backgroundColor;
        
        self.coverImageView = [UIImageView rut_imageViewWithCornerRadius:3 contentMode:UIViewContentModeScaleAspectFit backgroundColor:UIColor.blackColor];
        [self.contentView addSubview:self.coverImageView];
        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.height.equalTo(@50); // 封面的高度之后需要根据图片比例进行修改
        }];
        
        CGFloat tagHeight = 20;
        self.tagLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_R(10) textAlignment:NSTextAlignmentCenter cornerRadius:tagHeight * 0.5 backgroundColor:[UIColor rte_color000000WithAlpha:0.5]];
        [self.contentView addSubview:self.tagLabel];
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.coverImageView.mas_left).offset(8);
            make.width.equalTo(@100); // 宽度之后会根据文字宽度进行修改
            make.height.equalTo(@(tagHeight));
            make.bottom.equalTo(self.coverImageView.mas_bottom).offset(-5);
        }];
        
        self.titleLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_M(14)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.coverImageView);
            make.centerY.equalTo(self.coverImageView.mas_bottom).offset(21);
            make.height.equalTo(@(self.titleLabel.font.lineHeight));
        }];
        
        self.subtitleLabel = [UILabel rut_labelWithTextColor:UIColor.rte_colorCDCDCD font:Font_PFSC_R(12)];
        [self.contentView addSubview:self.subtitleLabel];
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.coverImageView);
            make.centerY.equalTo(self.coverImageView.mas_bottom).offset(42);
            make.height.equalTo(@(self.subtitleLabel.font.lineHeight));
        }];
        
        CGFloat avatarWH = [self.class getAvatarWidthHeight];
        self.avatarImageView = [UIImageView rut_imageViewWithCornerRadius:avatarWH * 0.5 contentMode:UIViewContentModeScaleAspectFill backgroundColor:UIColor.rte_color282828];
        [self.contentView addSubview:self.avatarImageView];
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.coverImageView);
            make.width.height.equalTo(@(avatarWH));
            make.top.equalTo(self.coverImageView.mas_bottom).offset([self.class getAvatarTopToCoverBottom]);
        }];
        
        self.nameLabel = [UILabel rut_labelWithTextColor:UIColor.rte_colorA2A2A2 font:Font_PFSC_R(10)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.avatarImageView.mas_right).offset(6);
            make.right.equalTo(self.coverImageView);
            make.centerY.equalTo(self.avatarImageView);
            make.height.equalTo(@(self.nameLabel.font.lineHeight));
        }];
    }
    return self;
}

- (void)setData:(RCEditTemplate *)data {
    _data = data;
    
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.data.coverURL]];
    CGFloat coverHeight = [self.class getCoverHeightWithData:self.data cellWidth:CGRectGetWidth(self.contentView.frame)];
    [self.coverImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(coverHeight));
    }];
    
    self.tagLabel.text = [NSString stringWithFormat:@"使用量 %@ 赞 %@", [RCTemplateUtility getTenThousandStringWithNumber:self.data.usageCount], [RCTemplateUtility getTenThousandStringWithNumber:self.data.likeCount]];
    CGSize tagSize = [self.tagLabel sizeThatFits:CGSizeMake(MAXFLOAT, CGRectGetHeight(self.tagLabel.frame))];
    [self.tagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(tagSize.width + 14));
    }];
    
    self.titleLabel.text = self.data.shortTitle;
    self.subtitleLabel.text = self.data.title;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.data.author.avatarURL]];
    self.nameLabel.text = self.data.author.name;
}

#pragma mark - Class Methods
+ (CGFloat)getCellHeightWithData:(RCEditTemplate *)data cellWidth:(CGFloat)cellWidth {
    CGFloat coverHeight = [self getCoverHeightWithData:data cellWidth:cellWidth];
    return coverHeight + [self getAvatarTopToCoverBottom] + [self getAvatarWidthHeight];
}

+ (CGFloat)getCoverHeightWithData:(RCEditTemplate *)data cellWidth:(CGFloat)cellWidth {
    CGFloat coverWidth = cellWidth;
    CGFloat coverHeight = coverWidth / data.coverWidth * data.coverHeight * 1.0;
    return coverHeight;
}

+ (CGFloat)getAvatarTopToCoverBottom {
    return 55;
}

+ (CGFloat)getAvatarWidthHeight {
    return 18;
}

@end
