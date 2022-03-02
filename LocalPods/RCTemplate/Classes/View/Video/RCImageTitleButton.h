//
//  RCImageTitleButton.h
//  RCTemplate
//
//  Created by crx on 2022/3/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCImageTitleButton : UIView

+ (instancetype)buttonWithImage:(UIImage *)image target:(id)target action:(SEL)action;

- (void)setTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
