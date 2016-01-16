//
//  WLZ_Dance_videoViewController.h
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/12.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
@class WLZ_Dance_ListModel;
@interface WLZ_Dance_videoViewController : WLZBaseViewController
@property (nonatomic, retain) WLZ_Dance_ListModel *wlzdance;
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, assign) CMTime curTime;
@property (nonatomic, assign) NSInteger num;
@end
