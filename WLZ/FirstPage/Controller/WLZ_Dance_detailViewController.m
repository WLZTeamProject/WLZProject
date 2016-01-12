//
//  WLZ_Dance_detailViewController.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_detailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WLZ_Dance_videoModel.h"
#import "WLZ_Dance_ListModel.h"
@interface WLZ_Dance_detailViewController ()
@property (nonatomic, retain) AVPlayer *player;
@property (nonatomic, retain) UIView *container;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *totalTimeL;
@property (nonatomic, retain) UIView *sliderView;
@property (nonatomic, retain) UISlider *timeS;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) AVPlayerItem *playerItem;
@property (nonatomic, retain) IBOutlet UIProgressView *progress;
@property (nonatomic, retain) UIButton *backBut;
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
    [_totalTimeL release];
    [_timer release];
    [_timeS release];
    [_playerItem release];
    [_sliderView release];
    [_progress release];
    [_backBut release];
    [super dealloc];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createPlayerView];
    
    
    
}
- (void)createPlayerView
{
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height / 3)];
    self.container.backgroundColor = [UIColor magentaColor];
    [self.view addSubview:self.container];
    [_container release];
    
    
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.container.bounds;
    [self.container.layer addSublayer:playerLayer];
    //播放
    [self.player play];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.container.frame.size.height / 6 * 5 + self.container.frame.origin.y, self.container.frame.size.width, self.container.frame.size.height / 6)];
    self.sliderView.backgroundColor = [UIColor grayColor];
//    [self.sliderView setAlpha:0.5];
    [self.view addSubview:self.sliderView];
    [_sliderView release];
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.sliderView.frame.size.width / 5, self.sliderView.frame.size.height)];
    self.timeLabel.text = @"00:00";
    [_timeLabel release];
    [self.sliderView addSubview:self.timeLabel];
    
    self.timeS = [[UISlider alloc] initWithFrame:CGRectMake(self.timeLabel.frame.size.width, 0, self.sliderView.frame.size.width / 5 * 3, self.sliderView.frame.size.height)];
    [self.timeS addTarget:self action:@selector(timeAction) forControlEvents:UIControlEventValueChanged];
    [self.sliderView addSubview:self.timeS];
    [_timeS release];
    
    
    
    self.totalTimeL = [[UILabel alloc] initWithFrame:CGRectMake(self.timeS.frame.size.width + self.timeS.frame.origin.x, 0, self.sliderView.frame.size.width / 5, self.sliderView.frame.size.height)];
    self.totalTimeL.text = @"00:00";
    self.totalTimeL.textAlignment = NSTextAlignmentRight;
//    self.totalTimeL.backgroundColor = [UIColor blueColor];
    [self.sliderView addSubview:self.totalTimeL];
    [_totalTimeL release];
    
    self.backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBut.frame = CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width / 11, [[UIScreen mainScreen] bounds].size.width / 11);
    [self.backBut setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
    self.backBut.backgroundColor = [UIColor blackColor];
    [self.backBut setAlpha:0.5];
    self.backBut.layer.cornerRadius = self.backBut.frame.size.width / 2;
    [self.backBut addTarget:self action:@selector(backButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBut];
    
    
    

    
}

- (void)backButAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.player pause];
//    [self removeN];
}
//进度条
- (void)timeAction
{
    
}


- (void)addTimeobserver
{
    AVPlayerItem *playerItem = self.player.currentItem;
    UIProgressView *progress = self.progress;
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        CGFloat total = CMTimeGetSeconds([playerItem duration]);
        CGFloat current = CMTimeGetSeconds(time);
        self.timeS.value = current;
        self.timeLabel.text = [self changeTimer:current];
        self.totalTimeL.text = [self changeTimer:total];
        self.timeS.maximumValue = total;
        if (current) {
            [progress setProgress:(current / total) animated:YES];
        }
        
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
    WLZ_Dance_videoModel *wlzvideo = [self.zyDance.item_videos objectAtIndex:0];
    if (!_player) {
        NSString *str = wlzvideo.url;
        NSURL *url = [NSURL URLWithString:str];
        self.playerItem = [AVPlayerItem playerItemWithURL:url];
        _player = [AVPlayer playerWithPlayerItem:self.playerItem];

        [self addobserverToplayerItem:self.playerItem];
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
