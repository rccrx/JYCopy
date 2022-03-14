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


/** 如果这个item没有在屏幕显示范围，则会scroll到屏幕内 */
- (void)scrollToSelectedItemIfNeeded;
/** 如果item不在屏幕内，则可能返回nil，还有要注意图片未下载完成的情况 */
- (UIImage *)getSelectedItemCoverImage; // 由于需要用到只有VC才知道的cell类型，所以不将这个方法放在VM
/** 如果item不在屏幕内，则可能返回0，所以在调用这个方法之前先确保item已经在屏幕内，比如在适当时机调用- scrollToSelectedItemIfNeeded */
- (CGRect)getSelectedItemCoverFrame;

@end

NS_ASSUME_NONNULL_END
