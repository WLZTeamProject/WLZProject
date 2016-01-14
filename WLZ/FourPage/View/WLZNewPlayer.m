//
//  WLZNewPlayer.m
//  WLZ
//
//  Created by lqq on 16/1/13.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZNewPlayer.h"



@interface WLZNewPlayer ()
//<MBProgressHUDDelegate>



@end

@implementation WLZNewPlayer

- (void)dealloc
{
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [_player release];
    [_playerLayer release];
    [_video_url release];
    [_backImage release];
    [_didTimeLabel release];
    [_totalTimeLabel release];
    [_playButton release];
    [_playProgress release];
    [_playSlider release];
    [_fullScreenButton release];
    [_barView release];
    [_superView release];
    [super dealloc];
}
-(instancetype)initWithFrame:(CGRect)frame videoURL:(NSString *)url
{
    self = [super initWithFrame:frame];
    if (self) {
        self.didPlay = NO;
        self.originalFrame = frame;
        self.hidenBar = NO;
        self.isFullScreen = NO;
        self.video_url = url;
        self.backgroundColor = [UIColor blackColor];
        [self createView:frame];//创建UI视图
        [self createPlayer:self.originalFrame]; //创建layer图层
//        [MBProgressHUD showHUDAddedTo:self animated:YES];//添加菊花
    }
    return self;
}
#pragma 创建player
-(void)createPlayer:(CGRect)frame
{
//    NSString *urlStr = [self.video_url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet symbolCharacterSet]];//编码URL;
    NSString *urlStr = self.video_url;
    NSLog(@"videl_url-----------%@", self.video_url);
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //开辟线程执行AVplayerItem的创建,如不开辟占用主线程,造成界面卡顿现象
//    dispatch_queue_t globalQueue = dispatch_get_global_queue(0, 0);
//    dispatch_async(globalQueue, ^{
        //创建AVplayerItem
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        
        
//        dispatch_async(dispatch_get_main_queue(), ^{
        
            
            if (playerItem) {
                
                if (!_player) {
                    _player = [AVPlayer playerWithPlayerItem:playerItem];
                    if (_player) {
                        //保证AVPlayer对象存在, 然后再为其添加进度观察,以便获取当前播放进度
                        [self addProgressObserver];
                        //给AVplayerItem添加监控(重要)
                        [self addObserverToPlayerItem:playerItem];
                    }
                }
                
            } else {
                
                NSLog(@"无法获取视频资源");
            }
//        });
//    });
    //创建播放图层
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.playerLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [self.layer addSublayer:self.playerLayer];
}


//-------------------------------------通知----------------//
#pragma 添加通知
- (void)addNotification
{
    //添加播放结束时通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}
#pragma 移除所有通知
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma 播放完成通知执行的方法

- (void)playbackFinished:(NSNotification *)notification
{
    
}
//-------------------------------------通知----------------//


- (void)addProgressObserver
{
    UISlider *slider = self.playSlider;//获取当前滚动条
    __block WLZNewPlayer *wlz_player = self;
    
    //设置每秒执行一次
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 10.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        float current = CMTimeGetSeconds(time);//获取当前播放的时间
        if (current) {
            [slider setValue:current animated:YES];
            int currentTime = (int)current;
            int m = currentTime / 60;
            int s = currentTime % 60;
            NSString *strM =nil;
            NSString *strS =nil;
            if (m < 10) {
                strM = [NSString stringWithFormat:@"0%d",m];
            } else {
                strM = [NSString stringWithFormat:@"%d", m];
            }
            
            if (s < 10) {
                strS = [NSString stringWithFormat:@"0%d", s];
            } else {
                strS = [NSString stringWithFormat:@"%d", s];
            }
            
            //设置UILabel视图显示当前播放时长
            wlz_player.didTimeLabel.text = [NSString stringWithFormat:@"%@:%@",strM, strS];
        }
    }];
}
#pragma 给AVplayerItem添加监控
- (void)addObserverToPlayerItem:(AVPlayerItem *)playeritem
{
    //监控状态属性, 注意AVPlayer也有一个status属性, 通过监控它的status可以获得播放状态
    [playeritem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载状态属性
    [playeritem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    
}
- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem
{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
/*
 *  通过KVO监控播放器状态
 *  @param keyPath 监控属性
 *  @param object  监视器
 *  @param change  状态改变
 *  @param context 上下文
 */
//通知所执行的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    AVPlayerItem *playerItem = object;//获取监控对象
    if ([keyPath isEqualToString:@"status"]) {
        //获取status值
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        //暂停状态
        if (status == AVPlayerStatusReadyToPlay) {
            self.totalTime = playerItem.duration;//获取视频总时长
            [self customVideoSlider:playerItem.duration];//设置播放进度最大值
            int totalTime = (int)CMTimeGetSeconds(playerItem.duration);
            int m = totalTime / 60;
            int s = totalTime % 60;
            NSString *strM = nil;
            NSString *strS = nil;
            if (m < 10) {
                strM = [NSString stringWithFormat:@"0%d", m];
            } else {
                strM = [NSString stringWithFormat:@"%d", m];
            }
            if (s < 10) {
                strS = [NSString stringWithFormat:@"0%d", s];
            } else {
                strS = [NSString stringWithFormat:@"%d", s];
            }
            //设置视频时长的UILabel视图显示值
            self.totalTimeLabel.text = [NSString stringWithFormat:@"%@:%@", strM, strS];
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        //播放状态
        [self addNotification];//添加播放完成通知
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        //设置缓存条
        [self.playProgress setProgress:totalBuffer/CMTimeGetSeconds(self.totalTime) animated:YES];
        float currentPlayTime =  CMTimeGetSeconds([self.player currentTime]);//获取当前播放时长
        //设定当缓冲总时长超过播放时长3秒时开始播放视频
        if (totalBuffer - currentPlayTime > 3.0) {
            if (!self.didPlay) {
                [self createPlayer:self.frame];
                [self.player play];
//                [MBProgressHUD hideHUDForView:self animated:YES];
                [self bringSubviewToFront:self.barView];
                [self.playButton setImage:[UIImage imageNamed:@"pause_32"] forState:UIControlStateNormal];
                self.didPlay = YES;
            }
        } else {
            [self.player pause];
//            [MBProgressHUD showHUDAddedTo:self animated:YES];
            self.didPlay = NO;
            [self.playButton setImage:[UIImage imageNamed:@"play_32"] forState:UIControlStateNormal];
        }
        
    }
}
#pragma 播放视图的创建
- (void)createView:(CGRect)frame {
    
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    self.backImage.image = [UIImage imageNamed:@"back_Image.png"];
    self.backImage.backgroundColor = [UIColor purpleColor];
    
    self.barView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-40, frame.size.width, 40)];
    self.barView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    
    self.playProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(50, 15, self.barView.frame.size.width-100, 10)];
    [self.playProgress setProgressTintColor:[UIColor orangeColor]];
    
    self.playSlider = [[UISlider alloc] initWithFrame:CGRectMake(47, 11.2, self.playProgress.frame.size.width+10, 10)];
    [self.playSlider setThumbImage:[UIImage imageNamed:@"ball_16"] forState:UIControlStateNormal];
    
    self.didTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 25, 50, 10)];
    self.didTimeLabel.font = [UIFont systemFontOfSize:14];
    self.totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.barView.frame.size.width-100, 25, 50, 10)];
    self.totalTimeLabel.font = [UIFont systemFontOfSize:14];
    //=================
    UIGraphicsBeginImageContextWithOptions((CGSize){ 2, 2 }, NO, 0.0f);
    UIImage *transparentImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.playSlider setMinimumTrackTintColor:[UIColor blueColor]];
    [self.playSlider setMaximumTrackImage:transparentImage forState:UIControlStateNormal];
    //=================
    [self.playSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playButton.frame = CGRectMake(5, 5, 30, 30);
    [self.playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton setBackgroundColor:[UIColor clearColor]];
    [self.playButton setImage:[UIImage imageNamed:@"play_32.png"] forState:UIControlStateNormal];
    
    self.fullScreenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.fullScreenButton.frame = CGRectMake(self.barView.frame.size.width - 40, 5, 30, 30);
    [self.fullScreenButton addTarget:self action:@selector(fullScreenButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.fullScreenButton setBackgroundColor:[UIColor clearColor]];
    [self.fullScreenButton setImage:[UIImage imageNamed:@"fullScreen_32.png"] forState:UIControlStateNormal];
    
    [self.barView addSubview:self.playButton];
    [self.barView addSubview:self.playProgress];
    [self.barView addSubview:self.playSlider];
    [self.barView addSubview:self.didTimeLabel];
    [self.barView addSubview:self.totalTimeLabel];
    [self.barView addSubview:self.fullScreenButton];
    [self addSubview:self.barView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}
#pragma 点击隐藏控制view
- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    if (self.hidenBar) {
        self.hidenBar = NO;
        [self bringSubviewToFront:self.barView];
    } else {
        self.hidenBar = YES;
    }
    self.barView.hidden = self.hidenBar;
}
#pragma 播放暂停
- (void)playButtonAction:(UIButton *)button
{
    NSLog(@"%f", self.player.rate);
    if(self.player.rate == 0){ //说明是暂停
        [button setImage:[UIImage imageNamed:@"pause_32"] forState:UIControlStateNormal];
        self.backImage.hidden = YES;
        if (self.didPlay) {
            [self.player play];
        }
    }else if(self.player.rate == 1){//正在播放
        [self.player pause];
        [button setImage:[UIImage imageNamed:@"play_32"] forState:UIControlStateNormal];
    }
}

//全屏设置
- (void)fullScreenButtonAction:(UIButton *)button {
    
    if (self.isFullScreen) {
        self.isFullScreen = NO;
        [self.fullScreenButton setImage:[UIImage imageNamed:@"fullScreen_32.png"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.2 animations:^{
            
            self.transform = CGAffineTransformRotate(self.transform, -M_PI_2);
            
            self.frame = self.originalFrame;
            [self.playerLayer removeFromSuperlayer];
            [self createPlayer:self.originalFrame];
            
            self.barView.frame = CGRectMake(0, self.originalFrame.size.height-40, self.originalFrame.size.width, 40);
            [self bringSubviewToFront:self.barView];
            
            self.center = CGPointMake(self.originalFrame.origin.x + self.originalFrame.size.width/2.0, self.originalFrame.origin.y + self.originalFrame.size.height/2.0);
            
            self.backImage.frame = CGRectMake(0, 0, self.originalFrame.size.width, self.originalFrame.size.height);
            self.playProgress.frame = CGRectMake(50, 15, self.barView.frame.size.width-100, 10);
            self.playSlider.frame = CGRectMake(45, 11, self.playProgress.frame.size.width+10, 10);
            self.playButton.frame = CGRectMake(5, 5, 30, 30);
            self.fullScreenButton.frame = CGRectMake(self.barView.frame.size.width - 40, 5, 30, 30);
            
            [self.superView addSubview:self];
        }];
        
    } else {
        self.isFullScreen = YES;
        self.superView = self.superview;
        
        [self.fullScreenButton setImage:[UIImage imageNamed:@"exitFullScreen_32.png"] forState:UIControlStateNormal];
        [self.window addSubview:self];
        [self.window bringSubviewToFront:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.frame = CGRectMake(20, 0, [UIScreen mainScreen].bounds.size.height-20, [UIScreen mainScreen].bounds.size.width);
            [self.playerLayer removeFromSuperlayer];
            
            [self createPlayer:self.frame];
            
            self.barView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.width-40, [UIScreen mainScreen].bounds.size.height-20, 40);
            [self bringSubviewToFront:self.barView];
            self.backImage.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height-20, [UIScreen mainScreen].bounds.size.width);
            
            self.transform = CGAffineTransformRotate(self.transform, M_PI_2);
            self.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, ([UIScreen mainScreen].bounds.size.height+20)/2.0);
            self.playProgress.frame = CGRectMake(50, 15, self.barView.frame.size.width-100, 10);
            self.playSlider.frame = CGRectMake(45, 11, self.playProgress.frame.size.width+10, 10);
            self.playButton.frame = CGRectMake(5, 5, 30, 30);
            self.fullScreenButton.frame = CGRectMake(self.barView.frame.size.width - 40, 5, 30, 30);
            self.totalTimeLabel.frame = CGRectMake(self.barView.frame.size.width-100, 25, 50, 10);
        }];
        
    }
}

//UISlider基本设置
- (void)customVideoSlider:(CMTime)duration {
    
    self.playSlider.maximumValue = CMTimeGetSeconds(duration);
    self.playSlider.minimumValue = 0.0;
}

//拖动进度条到任何位置播放
- (void)sliderAction:(UISlider *)slider {
    
    if (self.player.rate == 0) {
        [self.player seekToTime:CMTimeMake((int)slider.value*10, 10.0)];
        [self.player play];
        [self.playButton setImage:[UIImage imageNamed:@"pause_32.png"] forState:UIControlStateNormal];
    } else if(self.player.rate == 1) {
        [self.player pause];
        [self.player seekToTime:CMTimeMake((int)slider.value*10, 10.0)];
        [self.player play];
        [self.playButton setImage:[UIImage imageNamed:@"pause_32.png"] forState:UIControlStateNormal];
    }
}

- (void)stop
{
    [self.player pause];
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
}










@end
