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
//    self 
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
    
//    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self., self.container.frame.size.width, <#CGFloat height#>)];
    
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.container.frame;
    [self.container.layer addSublayer:playerLayer];
    [self.player play];
}
//初始化播放器
//- (AVPlayer *)player
//{
//    if (!_player) {
//        NSString *str = @"";
//        NSURL *url = [NSURL URLWithString:str];
//        AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
//        _player = [AVPlayer playerWithPlayerItem:playerItem];
////        self.view 
//    }
//}

- (void)removeObserverFromPlayerItem:(AVPlayerItem *)player
{
//    playerItem remo
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
