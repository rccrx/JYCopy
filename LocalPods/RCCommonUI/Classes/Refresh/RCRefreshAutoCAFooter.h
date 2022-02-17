//
//  RCRefreshAutoCAFooter.h
//  RCCommonUI
//
//  Created by crx on 2022/2/17.
//

#import "MJRefreshAutoFooter.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCRefreshAutoCAFooter : MJRefreshAutoFooter

/** 请求数据失败的状态，这个状态只能通过点击重新启动刷新，不能通过上拉重启刷新 */
- (void)endRefreshingWithDataFailed;

@end

NS_ASSUME_NONNULL_END
