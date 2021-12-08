//
//  RCEditTemplate.m
//  RCTemplate
//
//  Created by crx on 2021/12/7.
//

#import "RCEditTemplate.h"

@implementation RCEditTemplate

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"coverURL": @"cover_url",
             @"coverWidth": @"cover_width",
             @"coverHeight": @"cover_height",
             @"usageCount": @"usage_amount",
             @"likeCount": @"like_count",
             @"shortTitle": @"short_title"};
}

@end
