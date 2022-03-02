//
//  RCUnlockTemplateView.m
//  RCTemplate
//
//  Created by crx on 2022/2/28.
//

#import "RCUnlockTemplateView.h"

#define TitleFont Font_PFSC_R(10)
#define TitleHeight TitleFont.lineHeight
#define MarginHorizontal 8
#define TitleToArrow 5
#define ArrowWidthHeight 12

@interface RCUnlockTemplateView ()
@property (nonatomic, strong) UIButton *arrowButton;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation RCUnlockTemplateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor rte_colorFFFFFFWithAlpha:0.1];
        
        self.arrowButton = [UIButton rut_buttonWithImage:[UIImage rte_imageNamedInTemplateBundle:@"video_arrow_right"] target:self action:@selector(arrowButtonDidClicked:)];
        [self addSubview:self.arrowButton];
        [self.arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-MarginHorizontal);
            make.centerY.equalTo(self);
            make.width.equalTo(@(ArrowWidthHeight));
            make.height.equalTo(@(ArrowWidthHeight));
        }];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = TitleFont;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(@(TitleHeight));
            make.left.equalTo(self).offset(MarginHorizontal);
            make.right.equalTo(self.arrowButton.mas_left).offset(-TitleToArrow);
        }];
    }
    return self;
}

#pragma mark - Public
- (void)setTitle1:(NSString *)title1 title2:(NSString *)title2 {
    NSString *middleStr = @"  |  ";
    NSString *title = [[NSString alloc] initWithFormat:@"%@%@%@", title1, middleStr, title2];
    NSUInteger frontPartLength = title1.length + middleStr.length;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:title];
    [attrStr addAttributes:@{NSForegroundColorAttributeName: UIColor.rte_colorCDCDCD} range:NSMakeRange(0, frontPartLength)];
    [attrStr addAttributes:@{NSForegroundColorAttributeName: UIColor.whiteColor} range:NSMakeRange(frontPartLength, title.length - frontPartLength)];
    self.titleLabel.attributedText = attrStr;
}

- (CGFloat)getRecommendedWidth {
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, TitleHeight)];
    return MarginHorizontal + size.width + TitleToArrow + ArrowWidthHeight + MarginHorizontal;
}

#pragma mark - Action
- (void)arrowButtonDidClicked:(UIButton *)button {
    
}

@end
