//
//  RCEditTemplate.h
//  RCTemplate
//
//  Created by crx on 2021/12/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RCTemplateAuthor;

@interface RCEditTemplate : NSObject

@property (nonatomic, copy) NSString *coverURL;
@property (nonatomic, assign) int32_t coverWidth;
@property (nonatomic, assign) int32_t coverHeight;
@property (nonatomic, assign) int64_t usageCount;
@property (nonatomic, assign) int64_t likeCount;
@property (nonatomic, copy) NSString *shortTitle;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) RCTemplateAuthor *author;

@end

NS_ASSUME_NONNULL_END
