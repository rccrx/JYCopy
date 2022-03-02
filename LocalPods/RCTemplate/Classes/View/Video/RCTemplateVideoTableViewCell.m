//
//  RCTemplateVideoTableViewCell.m
//  Pods
//
//  Created by crx on 2022/2/19.
//

#import "RCTemplateVideoTableViewCell.h"
#import "RCPlayerView.h"
#import "RCUnlockTemplateView.h"
#import "RCEditTemplate.h"
#import "RCTemplateAuthor.h"
#import "RCImageTitleButton.h"

@interface RCTemplateVideoTableViewCell ()

@property (nonatomic, strong) RCPlayerView *playerView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) RCImageTitleButton *likeButton;
@property (nonatomic, strong) RCImageTitleButton *commentButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) RCImageTitleButton *similarButton;
@property (nonatomic, strong) UIButton *collegeButton;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) RCUnlockTemplateView *unlockTemplateView;
@property (nonatomic, strong) UIButton *useTemplateButton;

@end

@implementation RCTemplateVideoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.playerView = [RCPlayerView new];
        self.playerView.backgroundColor = UIColor.blackColor;
        [self.contentView addSubview:self.playerView];
        [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
        
        CGFloat avatarWH = 40;
        self.avatarImageView = [UIImageView rut_imageViewWithCornerRadius:avatarWH * 0.5 contentMode:UIViewContentModeScaleAspectFill backgroundColor:UIColor.grayColor borderWidth:2 borderColor:UIColor.whiteColor.CGColor];
        [self.contentView addSubview:self.avatarImageView];
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@(avatarWH));
            make.right.equalTo(self.contentView).offset(-15);
            make.bottom.equalTo(self.contentView).offset(-425);
        }];
        
        self.addButton = [UIButton rut_buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_add"] target:self action:@selector(addButtonDidClicked:)];
        [self.contentView addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.avatarImageView.mas_centerX);
            make.centerY.equalTo(self.avatarImageView.mas_bottom);
            make.width.height.equalTo(@20);
        }];
        
        self.likeButton = [RCImageTitleButton buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_like"] target:self action:@selector(likeButtonDidClicked:)];
        [self.contentView addSubview:self.likeButton];
        [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@70);
            make.height.equalTo(@50);
            make.centerX.equalTo(self.avatarImageView);
            make.top.equalTo(self.avatarImageView.mas_bottom).offset(45);
        }];
        
        self.commentButton = [RCImageTitleButton buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_comment"] target:self action:@selector(commentButtonDidClicked:)];
        [self.contentView addSubview:self.commentButton];
        [self.commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.likeButton.mas_width);
            make.height.equalTo(self.likeButton.mas_height);
            make.right.equalTo(self.likeButton.mas_right);
            make.top.equalTo(self.likeButton.mas_bottom).offset(40);
        }];
        
        self.shareButton = [UIButton rut_buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_share"] target:self action:@selector(shareButtonDidClicked:)];
        [self.contentView addSubview:self.shareButton];
        [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.equalTo(@40);
            make.centerX.equalTo(self.commentButton);
            make.top.equalTo(self.commentButton.mas_bottom).offset(20);
        }];
        
        self.similarButton = [RCImageTitleButton buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_similar"] target:self action:@selector(similarButtonDidClicked:)];
        [self.contentView addSubview:self.similarButton];
        [self.similarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.likeButton.mas_width);
            make.height.equalTo(self.likeButton.mas_height);
            make.right.equalTo(self.likeButton.mas_right);
            make.top.equalTo(self.shareButton.mas_bottom).offset(20);
        }];
        
        self.useTemplateButton = [UIButton rut_buttonWithImage:nil title:@"剪同款" titleColor:UIColor.whiteColor font:Font_PFSC_M(18) cornerRadius:2 backgroundColor:UIColor.rte_themeColor target:self action:@selector(useTemplateButtonDidClicked:)];
        [self.contentView addSubview:self.useTemplateButton];
        [self.useTemplateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-10);
            make.right.equalTo(self.contentView).offset(-15);
            make.width.equalTo(@100);
            make.height.equalTo(@40);
        }];
        
        CGFloat unlockH = 20;
        self.unlockTemplateView = [RCUnlockTemplateView new];
        self.unlockTemplateView.layer.cornerRadius = unlockH * 0.5;
        self.unlockTemplateView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.unlockTemplateView];
        [self.unlockTemplateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.height.equalTo(@(unlockH));
            make.bottom.equalTo(self.useTemplateButton.mas_bottom);
            make.width.equalTo(@100); // 这个宽度之后会修改
        }];
        
        self.tagLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_M(16)];
        [self.contentView addSubview:self.tagLabel];
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.unlockTemplateView.mas_left);
            make.right.equalTo(self.useTemplateButton.mas_left).offset(-10);
            make.bottom.equalTo(self.unlockTemplateView.mas_top).offset(-10);
            make.height.equalTo(@16); // 这个高度之后会修改
        }];
        
        self.titleLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_R(15)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.tagLabel);
            make.bottom.equalTo(self.tagLabel.mas_top).offset(0); // 这个偏移量之后会修改
            make.height.equalTo(@15); // 这个高度之后会修改
        }];
        
        self.nameLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_M(17)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.height.equalTo(@(self.nameLabel.font.lineHeight));
            make.centerY.equalTo(self.titleLabel.mas_top).offset(-20);
        }];
        
        self.collegeButton = [UIButton rut_buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_college"] title:@"教你怎么剪" titleColor:UIColor.whiteColor font:Font_PFSC_R(12)  cornerRadius:2 backgroundColor:[UIColor rte_colorFCCF14WithAlpha:0.1] target:self action:@selector(collegeButtonDidClicked:)];
        [self.contentView addSubview:self.collegeButton];
        [self.collegeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.width.equalTo(@95);
            make.height.equalTo(@30);
            make.bottom.equalTo(self.nameLabel.mas_centerY).offset(-13);
        }];
    }
    return self;
}

- (void)setData:(RCEditTemplate *)data {
    _data = data;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.data.author.avatarURL]];
    [self.likeButton setTitle:[RCTemplateUtility getTenThousandStringWithNumber:self.data.likeCount]];
    [self.commentButton setTitle:[RCTemplateUtility getTenThousandStringWithNumber:self.data.likeCount]];
    [self.similarButton setTitle:[RCTemplateUtility getTenThousandStringWithNumber:self.data.usageCount]];
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", self.data.author.name];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ | %@", self.data.shortTitle, self.data.title];
    self.tagLabel.text = self.titleLabel.text;
    [self.unlockTemplateView setTitle1:@"00:10 片段 2 使用量 1" title2:@"¥3 解锁草稿"];
    
    
    [self.unlockTemplateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([self.unlockTemplateView getRecommendedWidth]));
    }];
}

#pragma mark - Action
- (void)addButtonDidClicked:(UIButton *)button {
    
}

- (void)likeButtonDidClicked:(UIButton *)button {
    
}

- (void)commentButtonDidClicked:(UIButton *)button {
    
}

- (void)shareButtonDidClicked:(UIButton *)button {
    
}

- (void)similarButtonDidClicked:(UIButton *)button {
    
}

- (void)useTemplateButtonDidClicked:(UIButton *)button {
    
}

- (void)collegeButtonDidClicked:(UIButton *)button {
    
}

@end
