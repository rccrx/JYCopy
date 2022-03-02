//
//  RCUnlockTemplateView.h
//  RCTemplate
//
//  Created by crx on 2022/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCUnlockTemplateView : UIView

/** 最终的title是“title1  |  title2”，且title1和title2的文字颜色不一样 */
- (void)setTitle1:(NSString *)title1 title2:(NSString *)title2;

/** 设置完title之后调用，会计算文字宽度再加上按钮宽度和边距 */
- (CGFloat)getRecommendedWidth;

@end

NS_ASSUME_NONNULL_END
