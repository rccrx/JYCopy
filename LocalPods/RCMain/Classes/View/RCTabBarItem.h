//
//  RCTabBarItem.h
//  RCMain
//
//  Created by crx on 2021/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTabBarItem : UIView

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage;

@end

NS_ASSUME_NONNULL_END
