//
//  RCTemplateCollectionViewModel.m
//  RCTemplate
//
//  Created by crx on 2021/12/1.
//

#import "RCTemplateCollectionViewModel.h"
#import "RCEditTemplate.h"

@interface RCTemplateCollectionViewModel ()
/*--------------- 重复头文件的readonly属性声明，为了自动添加Setter方法 ---------------*/
@property (nonatomic, copy) NSArray<RCEditTemplate *> *templates;
@end

@implementation RCTemplateCollectionViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.templates = @[];
    }
    return self;
}

- (void)requestFirstPageTemplates {
    if (![self isNetworkAPIEnabledAndThenSetFakeDataIfNot]) return; // 没有接口时显示测试数据
    
    NSDictionary *params = NSDICTIONARY_GTIC_PARAMS_FIRST_LOAD(self.collectionId?:@"", @0, @30);
    [RCHTTPSessionManager.sharedManager POST:kURLGetTemplatesInCollection parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"suss: rsonsp=%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"falus: error=%@", error);
    }];
}

- (void)loadMoreTemplates {
    NSDictionary *params = NSDICTIONARY_GTIC_PARAMS_LOAD_MORE(self.collectionId?:@"", @24, @10);
    [RCHTTPSessionManager.sharedManager POST:kURLGetTemplatesInCollection parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"loamorsuss: rsonsp=%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"loamorfalus: error=%@", error);
    }];
}


















#pragma mark - 测试数据
/** 返回网络接口是否可用；没有网络接口时，设置假数据。 */
- (BOOL)isNetworkAPIEnabledAndThenSetFakeDataIfNot {
#if __has_include("RCTempFile_Delete.h")
    BOOL isNetworkAPIEnabled = YES;
#else
    BOOL isNetworkAPIEnabled = NO;
    
    NSMutableArray *tempArr = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        RCEditTemplate *template = [[RCEditTemplate alloc] init];
        if (arc4random_uniform(2)) {
            template.coverURL = @"https://img1.baidu.com/it/u=1995363239,4274347774&fm=26&fmt=auto";
        } else {
            template.coverURL = @"https://img2.baidu.com/it/u=781607565,66374776&fm=26&fmt=auto";
        }
        template.coverRatio = (arc4random_uniform(120) + 50) / 100.0;
        template.usageCount = 22;
        template.likeCount = 6;
        template.title = [NSString stringWithFormat:@"砸雪球变身: %d", i];
        template.subtitle = @"今日份美好 | 文字可更改#日常碎片#";
        template.avatarURL = @"https://img2.baidu.com/it/u=3989200917,112452247&fm=26&fmt=auto";
        template.nickname = @"Ahfjinga（手机摄影）";
        [tempArr addObject:template];
    }
    self.templates = tempArr;
#endif
    return isNetworkAPIEnabled;
}

@end
