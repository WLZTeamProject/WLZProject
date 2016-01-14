//
//  WLZNewPlayer.h
//  WLZ
//
//  Created by lqq on 16/1/13.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MBProgressHUD.h>
@interface WLZNewPlayer : UIView
- (instancetype)initWithFrame:(CGRect)frame videoURL:(NSString *)url;
- (void)removeNotification;//移除通知
- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem;//移除playeritem的观察者
- (void)stop;
@end
