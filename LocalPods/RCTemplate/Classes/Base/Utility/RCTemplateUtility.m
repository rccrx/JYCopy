//
//  RCTemplateUtility.m
//  RCTemplate
//
//  Created by crx on 2022/2/28.
//

#import "RCTemplateUtility.h"

@implementation RCTemplateUtility

+ (NSString *)getTenThousandStringWithNumber:(int64_t)number {
    return number >= 10000 ? [NSString stringWithFormat:@"%.1f万", number / 10000.0] : [NSString stringWithFormat:@"%lld", number];
}

+ (NSString *)getTimeStringWithSeconds:(NSInteger)seconds {
    NSInteger second = seconds % 60;
    NSInteger minute = second / 60;
    return [NSString stringWithFormat:@"%02ld:%02ld", minute, second];
}

@end
