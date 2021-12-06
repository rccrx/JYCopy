//
//  RCHTTPSessionManager.h
//  RCNetwork
//
//  Created by crx on 2021/12/2.
//

#import "AFHTTPSessionManager.h"
#import "RCNetworkURLDefines.h"
#import "RCJustForTransformTemp_Delete.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

/** AFHTTPSessionManager除了“- POST:parameters:headers:constructingBodyWithBlock:progress:success:failure:”这个方法，其他GET/POST等网络请求方法都会自动加上这些头部字段 */
+ (NSDictionary *)commonHeaders;

@end

NS_ASSUME_NONNULL_END
