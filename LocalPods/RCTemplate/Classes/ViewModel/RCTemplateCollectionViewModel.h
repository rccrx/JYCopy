//
//  RCTemplateCollectionViewModel.h
//  RCTemplate
//
//  Created by crx on 2021/12/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define RCTemplateCollectionViewModelErrorDomain @"RCTemplateCollectionViewModelErrorDomain"

typedef NS_ENUM(NSInteger, RCTemplatesRequestState) {
    RCTemplatesRequestStateNone = 0,
    RCTemplatesRequestStateGetTemplatesStarted,
    RCTemplatesRequestStateGetTemplatesEndedSucceedHasMore,
    RCTemplatesRequestStateGetTemplatesEndedSucceedNoMore,
    RCTemplatesRequestStateGetTemplatesEndedFailed,
    RCTemplatesRequestStateLoadMoreTemplatesStarted,
    RCTemplatesRequestStateLoadMoreTemplatesEndedSucceedHasMore,
    RCTemplatesRequestStateLoadMoreTemplatesEndedSucceedNoMore,
    RCTemplatesRequestStateLoadMoreTemplatesEndedFailed
};

@class RCEditTemplate;


/** 所有readonly属性都支持KVO */
@interface RCTemplateCollectionViewModel : NSObject

/** 模板集合的id */
@property (nonatomic, copy) NSString *collectionId;

@property (nonatomic, copy, readonly) NSArray<RCEditTemplate *> *templates;
@property (nonatomic, strong, readonly) NSError *error;
/** state的更新在templates、error的更新之后 */
@property (nonatomic, assign, readonly) RCTemplatesRequestState state;

- (void)getTemplatesForCurrentCollectionId;
- (void)loadMoreTemplates;

- (void)recordSelectedIndex:(NSUInteger)index;
- (NSUInteger)getLastRecordedSelectedIndex;

@end

NS_ASSUME_NONNULL_END
