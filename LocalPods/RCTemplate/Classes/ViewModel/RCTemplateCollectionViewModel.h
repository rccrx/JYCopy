//
//  RCTemplateCollectionViewModel.h
//  RCTemplate
//
//  Created by crx on 2021/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTemplateCollectionViewModel : NSObject

/** 模板集合的id */
@property (nonatomic, copy) NSString *collectionId;

- (void)requestTemplatesInCollection;

@end

NS_ASSUME_NONNULL_END
