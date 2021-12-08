//
//  RCTemplateAuthor.m
//  RCTemplate
//
//  Created by crx on 2021/12/8.
//

#import "RCTemplateAuthor.h"

@implementation RCTemplateAuthor

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"userId": @"uid",
             @"avatarURL": @"avatar_url"};
}

@end
