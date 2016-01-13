//
//  WLZ_Dance_videoViewController.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/12.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_videoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WLZ_Dance_ListModel.h"
#import "WLZ_Dance_videoModel.h"
@interface WLZ_Dance_videoViewController ()
@property (nonatomic, retain) UIView *container;
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UIView *backView;
@property (nonatomic, retain) UIButton *backBut;
@property (nonatomic, retain) UILabel *titleL;

@property (nonatomic, retain) UIView *sliderView;
@property (nonatomic, retain) UISlider *timeS;
@property (nonatomic, retain) UIButton *startBut;

@property (nonatomic, retain) NSTimer *timer;




@end

@implementation WLZ_Dance_videoViewController

- (void)dealloc
{
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [_player release];
    [_wlzdance release];
    [_container release];
    [_timeLabel release];
    [_backBut release];
    [_backView release];
    [_titleL release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self screenView];
    
    [self createPlayerView];
    
    
    
}
//横屏
- (void)screenView
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        //选择屏幕旋转样式
        int val = UIInterfaceOrientationLandscapeLeft;
        
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        
    }

}
//竖屏
- (void)erectView
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        //选择屏幕旋转样式
        int val = UIDeviceOrientationPortrait;
        
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
        
    }
    
}
//建立视频
- (void)createPlayerView
{
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
    self.container.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.container];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.container.frame;
    
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.container.layer addSublayer:playerLayer];
    
    [self.player play];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.container addGestureRecognizer:tapGR];
    [tapGR release];
    
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height / 7)];
    self.backView.backgroundColor = [UIColor blackColor];
    [self.backView setAlpha:0.5];
    [self.view addSubview:self.backView];
    
    self.backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBut.frame = CGRectMake(0, 0, self.backView.frame.size.width / 11, self.backView.frame.size.height);
    [self.backBut setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
    [self.backBut addTarget:self action:@selector(backButAction) forControlEvents:UIControlEventTouchUpInside];
    self.backBut.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:self.backBut];
    
    self.titleL = [[UILabel alloc] initWithFrame:CGRectMake(self.backBut.frame.size.width, 0, self.backView.frame.size.width / 11 * 8, self.backView.frame.size.height)];
    self.titleL.backgroundColor = [UIColor clearColor];
    self.titleL.textColor = [UIColor whiteColor];
    self.titleL.text = self.wlzdance.item_title;
    [self.backView addSubview:self.titleL];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.container.frame.size.height / 7 * 6, self.container.frame.size.width, self.container.frame.size.height / 7)];
    self.sliderView.backgroundColor = [UIColor blackColor];
    [self.sliderView setAlpha:0.5];
    [self.view addSubview:self.sliderView];
    
    self.timeS = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.sliderView.frame.size.width, 0)];
    [self.timeS setThumbImage:[UIImage imageNamed:@"roundimage"] forState:UIControlStateNormal];
    [self.sliderView addSubview:self.timeS];
    
    self.startBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startBut.frame = CGRectMake(0, 0, self.sliderView.frame.size.width / 11, self.sliderView.frame.size.height);
    [self.startBut setImage:[UIImage imageNamed:@"stopImage"] forState:UIControlStateNormal];
    [self.startBut addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    self.startBut.backgroundColor = [UIColor clearColor];
    [self.sliderView addSubview:self.startBut];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sliderView.frame.size.width - self.sliderView.frame.size.width / 11 * 2, 0, self.sliderView.frame.size.width / 11 * 2, self.sliderView.frame.size.height)];
    self.timeLabel.text = @"00:00/00:00";
    self.timeLabel.backgroundColor = [UIColor clearColor];
    self.timeLabel.textColor = [UIColor whiteColor];
    [self.sliderView addSubview:self.timeLabel];
    
    
    
}

- (void)tapAction
{
    NSLog(@"#######");
    if (NO == self.sliderView.hidden && NO == self.backView.hidden) {
        [self.sliderView setHidden:YES];
        [self.backView setHidden:YES];
        
    } else if (YES == self.sliderView.hidden && YES == self.backView.hidden) {
        
        [self.sliderView setHidden:NO];
        [self.backView setHidden:NO];
        self.timer  = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
    }
    
}

//过3sview自动消失
- (void)timerAction
{
    [self.sliderView setHidden:YES];
    [self.backView setHidden:YES];
}

//暂停/播放
- (void)playClick
{
    if (0 == self.player.rate) {
        [self.startBut setImage:[UIImage imageNamed:@"stopImage"] forState:UIControlStateNormal];
        [self.player play];
    } else if (1 == self.player.rate) {
        [self.startBut setImage:[UIImage imageNamed:@"startImage"] forState:UIControlStateNormal];
        [self.player pause];
    }
}

//返回
- (void)backButAction
{
    [self.navigationController popViewControllerAnimated:YES];
//    [self.tabBarController.tabBar setHidden:NO];
    [self.player pause];
    [self erectView];
    
}

- (void)addTimeobserver
{
    AVPlayerItem *playerItem = self.player.currentItem;
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat total = CMTimeGetSeconds([playerItem duration]);
        CGFloat current = CMTimeGetSeconds(time);
        NSString *newtime = [self changeTimer:current];
        NSString *totalTime = [self changeTimer:total];
        self.timeLabel.text = [NSString stringWithFormat:@"%@/%@", newtime, totalTime];
        self.timeS.value = current;
        self.timeS.maximumValue = total;
        
    }];
}

- (NSString *)changeTimer:(CGFloat)time
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"mm:ss"];
    NSString *dateStr = [formater stringFromDate:date];
    return dateStr;
    
}

- (void)addobserverToplayerTtem:(AVPlayerItem *)playeritem
{
    [playeritem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [playeritem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem
{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if (status == AVPlayerStatusReadyToPlay) {
            NSLog(@"正在播放......");
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        float startSecond = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSecond + durationSeconds;
        NSLog(@"一共缓存多少秒%0.2f", totalBuffer);
        
    }
}
- (AVPlayer *)player
{
    WLZ_Dance_videoModel *zyvideo = [self.wlzdance.item_videos objectAtIndex:0];
    if (!_player) {
        NSString *str = zyvideo.url;
        NSURL *url = [NSURL URLWithString:str];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        
        [self addobserverToplayerTtem:playerItem];
        [self addTimeobserver];
    }
    return _player;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
