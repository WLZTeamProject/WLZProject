//
//  WLZ_Dance_detailViewController.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_detailViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface WLZ_Dance_detailViewController ()
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, retain) UIView *container;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UIView *sliderView;
@property (nonatomic, retain) UISlider *timeS;
@end

@implementation WLZ_Dance_detailViewController

//转到系统播放
//NSURL *videoURL = [NSURL URLWithString:self.movieString];
//AVPlayer *player = [AVPlayer playerWithURL:videoURL];
//AVPlayerViewController *playerViewController = [AVPlayerViewController new];
//// 转换坐标使得全屏
//CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI / 2);
//playerViewController.view.transform = transform;
//提醒音频关掉
//[[NSNotificationCenter defaultCenter] postNotificationName:@"stopStart" object:nil];
//[self presentViewController:playerViewController animated:YES completion:nil];
//playerViewController.player = player;
//[player play];
//[playerViewController release];

- (void)dealloc
{
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [_player release];
    [_container release];
    [_timeLabel release];
    [super dealloc];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    [self createPlayerView];
    
    
    
}
- (void)createPlayerView
{
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 50, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height / 3)];
    [self.view addSubview:self.container];
    [_container release];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.container.frame.size.height / 6 * 5, self.container.frame.size.width, self.container.frame.size.height / 6)];
    self.sliderView.backgroundColor = [UIColor grayColor];
    [_sliderView release];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.sliderView.frame.size.width / 5, self.sliderView.frame.size.height)];
    self.timeLabel.text = @"00:00";
    [_timeLabel release];
    [self.sliderView addSubview:self.timeLabel];

    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.container.frame;
    [self.container.layer addSublayer:playerLayer];
    [self.player play];
    [_player release];
    
}

- (void)addTimeobserver
{
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat current = CMTimeGetSeconds(time);
        self.timeLabel.text = [self changeTimer:current];
        
        
    }];
    
}

- (NSString *)changeTimer:(CGFloat)time
{
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"mm:ss"];
    NSString *dataStr = [formater stringFromDate:date];
    return dataStr;
}
//kvo
- (void)addobserverToplayerItem:(AVPlayerItem *)playeritem
{
    //监控状态属性
    [playeritem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
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
            NSLog(@"正在播放........");
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

//初始化播放器
- (AVPlayer *)player
{
    if (!_player) {
        NSString *str = @"";
        NSURL *url = [NSURL URLWithString:str];
        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        [self addobserverToplayerItem:playerItem];
        [self addTimeobserver];
    }
    return _player;
}



//- (void)

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
