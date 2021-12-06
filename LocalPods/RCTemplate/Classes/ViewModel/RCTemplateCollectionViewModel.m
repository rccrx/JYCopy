//
//  RCTemplateCollectionViewModel.m
//  RCTemplate
//
//  Created by crx on 2021/12/1.
//

#import "RCTemplateCollectionViewModel.h"
#import "RCHTTPSessionManager.h"

@implementation RCTemplateCollectionViewModel

- (void)requestTemplatesInCollection {
//    NSDictionary *params = NSDICTIONARY_GTIC_PARAMS_FIRST_LOAD(NSNUMBER_COLLECTION_ID_1, @0, @30);
    NSDictionary *params = NSDICTIONARY_GTIC_PARAMS_LOAD_MORE(NSNUMBER_COLLECTION_ID_1, @24, @10);
    [[RCHTTPSessionManager sharedManager] POST:kURLGetTemplatesInCollection parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"suss: rsonsp=%@", responseObject);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"falus: error=%@", error);
        }];
}

@end
