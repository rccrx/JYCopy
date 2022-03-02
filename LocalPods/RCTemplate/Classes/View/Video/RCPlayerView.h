//
//  RCPlayerView.h
//  RCTemplate
//
//  Created by crx on 2022/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AVPlayer;

@interface RCPlayerView : UIView

@property (nonatomic, strong) AVPlayer *player;

@end

NS_ASSUME_NONNULL_END
