//
//  RCTabBarButton.h
//  RCMain
//
//  Created by crx on 2021/10/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTabBarButton : UIControl

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
