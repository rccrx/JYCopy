//
//  RCPlayerView.m
//  RCTemplate
//
//  Created by crx on 2022/2/28.
//

#import "RCPlayerView.h"
#import <AVFoundation/AVFoundation.h>

@interface RCPlayerView ()
@property (nonatomic, readonly) AVPlayerLayer *playerLayer;
@end

@implementation RCPlayerView

+ (Class)layerClass {
    return AVPlayerLayer.class;
}

- (AVPlayerLayer *)playerLayer {
    return (AVPlayerLayer *)self.layer;
}

- (void)setPlayer:(AVPlayer *)player {
    self.playerLayer.player = player;
}

- (AVPlayer *)player {
    return self.playerLayer.player;
}

@end
