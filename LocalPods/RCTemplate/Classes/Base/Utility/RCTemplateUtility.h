//
//  RCTemplateUtility.h
//  RCTemplate
//
//  Created by crx on 2022/2/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCTemplateUtility : NSObject

/** 比如当number=9876时是9876，当number大于10000比如98765时是9.8万，保留一位小数，单位为“万” */
+ (NSString *)getTenThousandStringWithNumber:(int64_t)number;
/** 比如8转换成“00:08”，65转换成“01:05” */
+ (NSString *)getTimeStringWithSeconds:(NSInteger)seconds;

@end

NS_ASSUME_NONNULL_END
