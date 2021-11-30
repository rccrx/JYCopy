//
//  RCTemplatePageControl.h
//  RCTemplate
//
//  Created by crx on 2021/11/16.
//

#import <UIKit/UIKit.h>
#import "RCPageControl.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCTemplatePageControl : UIView <RCPageControl>

+ (CGFloat)indicatorWH;
+ (CGFloat)indicatorCenterXSpacing;

@end

NS_ASSUME_NONNULL_END
