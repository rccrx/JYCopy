//
//  RCTemplateCollectionViewModel.h
//  RCTemplate
//
//  Created by crx on 2021/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RCEditTemplate;

/** 所有readonly属性都支持KVO */
@interface RCTemplateCollectionViewModel : NSObject

/** 模板集合的id */
@property (nonatomic, copy) NSString *collectionId;

@property (nonatomic, copy, readonly) NSArray<RCEditTemplate *> *templates;

- (void)requestFirstPageTemplates;
- (void)loadMoreTemplates;

@end

NS_ASSUME_NONNULL_END
