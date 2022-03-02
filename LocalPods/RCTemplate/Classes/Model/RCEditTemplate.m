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
             @"shortTitle": @"short_title",
             @"videoURL": @"video_url",
             @"commentCount": @"interaction.comment_count",
             @"fragmentCount": @"fragment_count",
             @"replicateWorkCount": @"replicate_work_count",
             @"purchaseInfo": @"purchase_info",
             @"relatedTopicList": @"related_topic_list"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"relatedTopicList": @"RCTemplateRelatedTopic"};
}

@end
