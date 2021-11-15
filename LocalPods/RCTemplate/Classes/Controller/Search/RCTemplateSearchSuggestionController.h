//
//  RCTemplateSearchSuggestionController.h
//  RCTemplate
//
//  Created by crx on 2021/11/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RCTemplateSearchSuggestionControllerDelegate;

@interface RCTemplateSearchSuggestionController : UIViewController
@property (nonatomic, weak) id<RCTemplateSearchSuggestionControllerDelegate> delegate;
@end



@protocol RCTemplateSearchSuggestionControllerDelegate <NSObject>
@optional
- (void)searchSuggestionController:(RCTemplateSearchSuggestionController *)searchSuggestionController didSelectKeyword:(NSString *)keyword;
@end

NS_ASSUME_NONNULL_END
