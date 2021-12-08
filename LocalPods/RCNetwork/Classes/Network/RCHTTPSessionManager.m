//
//  RCHTTPSessionManager.m
//  RCNetwork
//
//  Created by crx on 2021/12/2.
//

#import "RCHTTPSessionManager.h"
#import "RCNetworkURLDefines.h"

@implementation RCHTTPSessionManager

+ (instancetype)sharedManager {
    static RCHTTPSessionManager *manager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        manager = [[RCHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kBaseURL]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return manager;
}

+ (NSDictionary *)commonHeaders {
    NSDictionary *headers = NSDICTIONARY_COMMON_HEADERS;
    return headers;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method URLString:(NSString *)URLString parameters:(id)parameters headers:(NSDictionary<NSString *,NSString *> *)headers uploadProgress:(void (^)(NSProgress * _Nonnull))uploadProgress downloadProgress:(void (^)(NSProgress * _Nonnull))downloadProgress success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    NSMutableDictionary *headersDict = [NSMutableDictionary dictionaryWithDictionary:headers];
    [headersDict addEntriesFromDictionary:[self.class commonHeaders]];
    return [super dataTaskWithHTTPMethod:method URLString:URLString parameters:parameters headers:headersDict.copy uploadProgress:uploadProgress downloadProgress:downloadProgress success:success failure:failure];
}

@end
