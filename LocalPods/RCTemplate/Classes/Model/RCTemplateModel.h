//
//  RCTemplateModel.h
//  RCTemplate
//
//  Created by crx on 2021/11/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTemplateModel : NSObject

@property (nonatomic, copy) NSString *coverURL;
@property (nonatomic, assign) CGFloat coverRatio;
@property (nonatomic, assign) NSInteger usageCount;
@property (nonatomic, assign) NSInteger likeCount;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *avatarURL;
@property (nonatomic, copy) NSString *nickname;

@end

NS_ASSUME_NONNULL_END
