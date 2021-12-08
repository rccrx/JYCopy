//
//  RCTemplateAuthor.h
//  RCTemplate
//
//  Created by crx on 2021/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTemplateAuthor : NSObject

@property (nonatomic, assign) int64_t userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatarURL;

@end

NS_ASSUME_NONNULL_END
