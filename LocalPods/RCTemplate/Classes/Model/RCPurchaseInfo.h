//
//  RCPurchaseInfo.h
//  RCTemplate
//
//  Created by crx on 2022/3/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCPurchaseInfo : NSObject

@property (nonatomic, assign) int32_t amount;
@property (nonatomic, assign) BOOL needPurchase;
@property (nonatomic, assign) BOOL needUnlockByAd;

@end

NS_ASSUME_NONNULL_END
