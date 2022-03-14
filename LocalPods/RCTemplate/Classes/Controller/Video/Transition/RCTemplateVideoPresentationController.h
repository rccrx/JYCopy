//
//  RCTemplateVideoPresentationController.h
//  RCTemplate
//
//  Created by crx on 2022/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RCTemplateCollectionViewController;

@interface RCTemplateVideoPresentationController : UIPresentationController

@property (nonatomic, strong) RCTemplateCollectionViewController *sourceController;

@end

NS_ASSUME_NONNULL_END
