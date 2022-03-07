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
#import "RCTemplateRelatedTopic.h"
#import "RCPurchaseInfo.h"
#import <AVFoundation/AVFoundation.h>

#define MarginLeft 15
#define TitleTagToUse 10
#define UseWidth 100
#define UseRight 15
#define TitleTagWidth (ScreenWidth - MarginLeft - TitleTagToUse - UseWidth - UseRight)

@interface RCTemplateVideoTableViewCell ()

@property (nonatomic, strong) UIImageView *coverImageView;
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
        self.contentView.backgroundColor = UIColor.blackColor;
        
        self.coverImageView = [UIImageView rut_imageViewWithContentMode:UIViewContentModeScaleAspectFit backgroundColor:UIColor.blackColor];
        [self.contentView addSubview:self.coverImageView];
        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
        
        self.playerView = [RCPlayerView new];
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
        
        self.useTemplateButton = [UIButton rut_buttonWithImage:nil title:@"剪同款" titleColor:UIColor.whiteColor font:Font_PFSC_M(16) cornerRadius:2 backgroundColor:UIColor.rte_themeColor target:self action:@selector(useTemplateButtonDidClicked:)];
        [self.contentView addSubview:self.useTemplateButton];
        [self.useTemplateButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView).offset(-10);
            make.right.equalTo(self.contentView).offset(-UseRight);
            make.width.equalTo(@(UseWidth));
            make.height.equalTo(@40);
        }];
        
        CGFloat unlockH = 20;
        self.unlockTemplateView = [RCUnlockTemplateView new];
        self.unlockTemplateView.layer.cornerRadius = unlockH * 0.5;
        self.unlockTemplateView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.unlockTemplateView];
        [self.unlockTemplateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(MarginLeft);
            make.height.equalTo(@(unlockH));
            make.bottom.equalTo(self.useTemplateButton.mas_bottom);
            make.width.equalTo(@100); // 这个宽度之后会修改
        }];
        
        self.tagLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_M(14)];
        self.tagLabel.numberOfLines = 2;
        [self.contentView addSubview:self.tagLabel];
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.unlockTemplateView.mas_left);
            make.right.equalTo(self.useTemplateButton.mas_left).offset(-TitleTagToUse);
            make.bottom.equalTo(self.unlockTemplateView.mas_top).offset(-10);
            make.height.equalTo(@20); // 这个高度之后会修改
        }];
        
        self.titleLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_R(14)];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.tagLabel);
            make.bottom.equalTo(self.tagLabel.mas_top);
            make.height.equalTo(@20); // 这个高度之后会修改
        }];
        
        self.nameLabel = [UILabel rut_labelWithTextColor:UIColor.whiteColor font:Font_PFSC_M(16)];
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.titleLabel);
            make.height.equalTo(@(self.nameLabel.font.lineHeight));
            make.centerY.equalTo(self.titleLabel.mas_top).offset(-20);
        }];
        
        self.collegeButton = [UIButton rut_buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_college"] title:@"教你怎么剪" titleColor:UIColor.whiteColor font:Font_PFSC_R(12) cornerRadius:2 backgroundColor:[UIColor rte_colorFCCF14WithAlpha:0.1] target:self action:@selector(collegeButtonDidClicked:)];
        [self.contentView addSubview:self.collegeButton];
        [self.collegeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.width.equalTo(@95);
            make.height.equalTo(@30);
            make.bottom.equalTo(self.nameLabel.mas_centerY).offset(-24);
        }];
    }
    return self;
}

- (void)setData:(RCEditTemplate *)data {
    _data = data;
    
    // 设置显示数据
    self.coverImageView.image = nil;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:self.data.coverURL]];
    [self showPlayerViewOrCoverImageView:NO];
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:self.data.author.avatarURL]];
    [self.likeButton setTitle:[RCTemplateUtility getTenThousandStringWithNumber:self.data.likeCount]];
    [self.commentButton setTitle:[RCTemplateUtility getTenThousandStringWithNumber:self.data.commentCount]];
    [self.similarButton setTitle:[RCTemplateUtility getTenThousandStringWithNumber:self.data.replicateWorkCount]];
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", self.data.author.name];
    self.titleLabel.text = [NSString stringWithFormat:@"%@ | %@", self.data.shortTitle, self.data.title];
    
    if (self.data.relatedTopicList.count > 0) {
        NSMutableString *text = [[NSMutableString alloc] init];
        for (int i = 0; i < self.data.relatedTopicList.count; i++) {
            RCTemplateRelatedTopic *relTopic = self.data.relatedTopicList[i];
            if (i == 0) {
                [text appendString:relTopic.shortTitle];
            } else {
                [text appendFormat:@" # %@", relTopic.shortTitle];
            }
        }
        self.tagLabel.text = text;
    }
    
    NSString *title1 = [NSString stringWithFormat:@"%@ 片段 %lld 使用量 %@", [RCTemplateUtility getTimeStringWithSeconds:self.data.duration / 1000], self.data.fragmentCount, [RCTemplateUtility getTenThousandStringWithNumber:self.data.usageCount]];
    NSString *title2 = nil;
    if (self.data.purchaseInfo.needPurchase) {
        NSString *amount = nil;
        if (self.data.purchaseInfo.amount % 100 == 0) {
            amount = [NSString stringWithFormat:@"%d", self.data.purchaseInfo.amount / 100];
        } else {
            amount = [NSString stringWithFormat:@"%.2f", self.data.purchaseInfo.amount / 100.0];
        }
        if (self.data.purchaseInfo.needUnlockByAd) {
            title2 = [NSString stringWithFormat:@"%@元/广告解锁", amount];
        } else {
            title2 = [NSString stringWithFormat:@"¥%@ 解锁草稿", amount];
        }
    }
    [self.unlockTemplateView setTitle1:title1 title2:title2];
    
    
    // 修改约束（如果在-setData:中调用“[self layoutIfNeeded];”，在-layoutSubviews中修改约束，会出现奇怪的问题，比如调用多次layoutSubviews、有时tag/title宽度变宽而不是固定的、sizeThatFits计算的高度过高）
    [self.unlockTemplateView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@([self.unlockTemplateView getRecommendedWidth]));
    }];
    
    CGSize tagSize = [self.tagLabel sizeThatFits:CGSizeMake(TitleTagWidth, MAXFLOAT)];
    [self.tagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(tagSize.height));
    }];
    
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(TitleTagWidth, MAXFLOAT)];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(titleSize.height));
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

#pragma mark - Private
/** 传入参数YES则显示PlayerView隐藏CoverImageView，NO则隐藏PlayerView显示CoverImageView */
- (void)showPlayerViewOrCoverImageView:(BOOL)shouldShowPlayerView {
    self.playerView.hidden = !shouldShowPlayerView; // playerView在可以播放之前先隐藏，否则会因为复用问题显示上次视频截图
    self.coverImageView.hidden = shouldShowPlayerView;
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (object != self.playerView.player) {
        return;
    }
    
    if ([keyPath isEqualToString:@"status"]) {
        [MBProgressHUD hideLoadingHUDForView:self.coverImageView animated:NO];
        AVPlayerStatus status = [change[NSKeyValueChangeNewKey] integerValue];
        if (status == AVPlayerStatusReadyToPlay) {
            [self showPlayerViewOrCoverImageView:YES];
            [self.playerView.player play];
        }
    }
}

#pragma mark - Public
- (void)playVideo {
    if (self.playerView.player.rate != 0) {
        return;
    }
    
    [self.playerView.player removeObserver:self forKeyPath:@"status"];
    
    AVPlayer *player = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:self.data.videoURL]];
    player.automaticallyWaitsToMinimizeStalling = NO;
    self.playerView.player = player;
    [self.playerView.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    [MBProgressHUD showLoadingHUDAddedTo:self.coverImageView animated:NO];
}

- (void)pauseVideo {
    [self.playerView.player pause];
}

@end
