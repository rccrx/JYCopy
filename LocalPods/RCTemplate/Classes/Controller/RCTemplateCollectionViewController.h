//
//  RCTemplateCollectionViewController.h
//  RCTemplate
//
//  Created by crx on 2021/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RCTemplateCollectionViewModel;

@interface RCTemplateCollectionViewController : UIViewController

@property (nonatomic, strong, readonly) RCTemplateCollectionViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
