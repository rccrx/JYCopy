//
//  RCPurchaseInfo.m
//  RCTemplate
//
//  Created by crx on 2022/3/2.
//

#import "RCPurchaseInfo.h"

@implementation RCPurchaseInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"needPurchase": @"need_purchase",
             @"needUnlockByAd": @"need_unlock_by_ad"};
}

@end
