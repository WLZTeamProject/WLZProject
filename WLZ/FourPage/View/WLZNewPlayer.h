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

@property (nonatomic, retain) AVPlayer *player;//AVPlayer对象
@property (nonatomic, retain) AVPlayerLayer *playerLayer;//视频播放器的layer图层
@property (nonatomic, copy) NSString *video_url;//接收视频链接

@property (nonatomic, assign) CMTime totalTime;//记录视频总长度
@property (nonatomic, assign) BOOL hidenBar;//视频UI控件是否显示的标识
@property (nonatomic, assign) BOOL didPlay;//缓冲结束立即播放的标识

@property (nonatomic, assign) BOOL isFullScreen;//全屏标识
@property (nonatomic, assign) CGRect originalFrame;//记录播放器原始frame

@property (nonatomic, retain) UIImageView *backImage;//背景图
@property (nonatomic, retain) UILabel *didTimeLabel;//显示已经播放的时长
@property (nonatomic, retain) UILabel *totalTimeLabel;//显示总时长
@property (nonatomic, retain) UIButton *playButton;//播放暂停按钮
@property (nonatomic, retain) UIProgressView *playProgress;//缓存条
@property (nonatomic, retain) UISlider *playSlider;//播放进度条
@property (nonatomic, retain) UIButton *fullScreenButton;//全屏按钮
@property (nonatomic, retain) UIView *barView;//承载控件的View
@property (nonatomic, retain) UIView *superView;//记录下全屏前父视图, 便于退出全屏视频处于正确的位置
- (instancetype)initWithFrame:(CGRect)frame videoURL:(NSString *)url;
- (void)removeNotification;//移除通知
- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem;//移除playeritem的观察者

- (void)stop;
@end
