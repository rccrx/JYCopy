//
//  RCTemplateCollectionViewModel.m
//  RCTemplate
//
//  Created by crx on 2021/12/1.
//

#import "RCTemplateCollectionViewModel.h"
#import "RCEditTemplate.h"
#import "RCTemplateAuthor.h"

@interface RCTemplateCollectionViewModel ()
/*--------------- 重复头文件的readonly属性声明，为了自动添加Setter方法 ---------------*/
@property (nonatomic, copy) NSArray<RCEditTemplate *> *templates;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) RCTemplatesRequestState state;
@end

@implementation RCTemplateCollectionViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.templates = @[];
    }
    return self;
}

- (void)getTemplatesForCurrentCollectionId {
#if 1//测试
    if (![self isNetworkAPIEnabledAndThenSetFakeDataIfNot]) return; // 没有接口时显示测试数据
#endif
    
    self.state = RCTemplatesRequestStateGetTemplatesStarted;
    
    NSDictionary *params = NSDICTIONARY_GTIC_PARAMS_FIRST_LOAD(self.collectionId?:@"", @0, @30);
    [RCHTTPSessionManager.sharedManager POST:kURLGetTemplatesInCollection parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger ret = [responseObject[@"ret"] integerValue];
        if (ret != 0) {
            self.error = [NSError errorWithDomain:RCTemplateCollectionViewModelErrorDomain code:ret userInfo:@{NSLocalizedFailureReasonErrorKey: responseObject[@"errmsg"]?:@"", NSURLErrorKey: task.currentRequest.URL}];
            self.state = RCTemplatesRequestStateGetTemplatesEndedFailed;
            return; // 这个block的return
        }
        
        self.error = nil;
        
        NSDictionary *data = responseObject[@"data"];
        NSArray *itemList = data[@"item_list"];
        NSArray<RCEditTemplate *> *modelArr = [NSArray yy_modelArrayWithClass:RCEditTemplate.class json:itemList];
        self.templates = modelArr;
        
        BOOL hasMore = [data[@"has_more"] boolValue];
        if (hasMore) {
            self.state = RCTemplatesRequestStateGetTemplatesEndedSucceedHasMore;
        } else {
            self.state = RCTemplatesRequestStateGetTemplatesEndedSucceedNoMore;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.error = error;
        self.state = RCTemplatesRequestStateGetTemplatesEndedFailed;
    }];
}

- (void)loadMoreTemplates {
    self.state = RCTemplatesRequestStateLoadMoreTemplatesStarted;
    
    NSDictionary *params = NSDICTIONARY_GTIC_PARAMS_LOAD_MORE(self.collectionId?:@"", @24, @10);
    [RCHTTPSessionManager.sharedManager POST:kURLGetTemplatesInCollection parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger ret = [responseObject[@"ret"] integerValue];
        if (ret != 0) {
            self.error = [NSError errorWithDomain:RCTemplateCollectionViewModelErrorDomain code:ret userInfo:@{NSLocalizedFailureReasonErrorKey: responseObject[@"errmsg"]?:@"", NSURLErrorKey: task.currentRequest.URL}];
            self.state = RCTemplatesRequestStateLoadMoreTemplatesEndedFailed;
            return;
        }
        
        self.error = nil;
        
        NSDictionary *data = responseObject[@"data"];
        NSArray *itemList = data[@"item_list"];
        NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:self.templates.count + itemList.count];
        [tempArr addObjectsFromArray:self.templates];
        for (NSDictionary *dict in itemList) {
            RCEditTemplate *model = [RCEditTemplate yy_modelWithDictionary:dict];
            [tempArr addObject:model];
        }
        self.templates = tempArr;
        
        BOOL hasMore = [data[@"has_more"] boolValue];
        if (hasMore) {
            self.state = RCTemplatesRequestStateLoadMoreTemplatesEndedSucceedHasMore;
        } else {
            self.state = RCTemplatesRequestStateLoadMoreTemplatesEndedSucceedNoMore;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.error = error;
        self.state = RCTemplatesRequestStateLoadMoreTemplatesEndedFailed;
    }];
}


















#pragma mark - 测试数据
/** 返回网络接口是否可用；没有网络接口时，设置假数据。 */
- (BOOL)isNetworkAPIEnabledAndThenSetFakeDataIfNot {
#if __has_include("RCTempFile_Delete.h")
    BOOL isNetworkAPIEnabled = YES;
#else
    BOOL isNetworkAPIEnabled = NO;
    
    self.state = RCTemplatesRequestStateGetTemplatesStarted;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            RCEditTemplate *template = [[RCEditTemplate alloc] init];
            if (arc4random_uniform(2)) {
                template.coverURL = @"https://img1.baidu.com/it/u=1995363239,4274347774&fm=26&fmt=auto";
            } else {
                template.coverURL = @"https://img2.baidu.com/it/u=781607565,66374776&fm=26&fmt=auto";
            }
            template.coverWidth = (arc4random_uniform(100) + 720);
            template.coverHeight = (arc4random_uniform(300) + 960);
            template.usageCount = 22;
            template.likeCount = 6;
            template.shortTitle = [NSString stringWithFormat:@"砸雪球变身: %d", i];
            template.title = @"今日份美好 | 文字可更改#日常碎片#";
            RCTemplateAuthor *author = [RCTemplateAuthor new];
            author.avatarURL = @"https://img2.baidu.com/it/u=3989200917,112452247&fm=26&fmt=auto";
            author.name = @"Ahfjinga（手机摄影）";
            template.author = author;
            [tempArr addObject:template];
        }
        self.templates = tempArr;
        
        int flag = arc4random_uniform(5);
        if (flag == 0) {
            self.state = RCTemplatesRequestStateGetTemplatesEndedFailed;
        } else if (flag == 1) {
            self.state = RCTemplatesRequestStateGetTemplatesEndedSucceedNoMore;
        } else {
            self.state = RCTemplatesRequestStateGetTemplatesEndedSucceedHasMore;
        }
    });
#endif
    return isNetworkAPIEnabled;
}

@end
