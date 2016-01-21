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
#import "WLZ_Dance_detailCollectionViewCell.h"
#import "WLZ_Dance_contentCollectionViewCell.h"
@interface WLZ_Dance_detailViewController () <UICollectionViewDataSource, UICollectionViewDelegate, WLZ_Dance_detailCollectionViewCellDelegate>

@property (nonatomic, retain) UIView *container;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *totalTimeL;
@property (nonatomic, retain) UIView *sliderView;
@property (nonatomic, retain) UISlider *timeS;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) AVPlayerItem *playerItem;

@property (nonatomic, retain) UIButton *backBut;
@property (nonatomic, retain) UIButton *startBut;
@property (nonatomic, retain) UIButton *screenBut;

@property (nonatomic, retain) UIView *butView;
@property (nonatomic, retain) UIButton *detailBut;
@property (nonatomic, retain) UIButton *relateBut;
@property (nonatomic, retain) UICollectionView *collectionV;

@property (nonatomic, retain) UIView *totalView;

@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) BOOL isRotation;
@property (nonatomic, assign) CGRect originalFrame;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, retain) UIView *titleView;
@property (nonatomic, retain) UILabel *localTimeL;

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


//销毁页面会走
- (void)dealloc
{
    self.collectionV.delegate = nil;
    self.collectionV.dataSource = nil;
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [_player release];
    [_container release];
    [_timeLabel release];
    [_totalTimeL release];
    [_timer release];
    [_timeS release];
    [_playerItem release];
    [_sliderView release];
    [_backBut release];
    [_startBut release];
    [_butView release];
    [_detailBut release];
    [_relateBut release];
    [_collectionV release];
    [_totalView release];
    [_arr release];
    [_titleView release];
    [_localTimeL release];
    [super dealloc];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    self.numtime = 0;
    self.page = 1;
    self.arr = [NSMutableArray array];
    self.originalFrame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height / 3);
    
    [self getrelateData];
    
    [self createPlayerView:self.originalFrame];
    
    [self createunderView];

    
}


//添加播放完成通知
- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}
//通知对象
- (void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成");
}
//移除通知
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//隐藏tabBar
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

//建立播放页面
- (void)createPlayerView:(CGRect)originalFrame
{
    self.totalView = [[UIView alloc] initWithFrame:originalFrame];
    self.totalView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.totalView];
    
    self.container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.totalView.frame.size.width, self.totalView.frame.size.height)];
    self.container.backgroundColor = [UIColor clearColor];
    [self.totalView addSubview:self.container];
    [_container release];
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    playerLayer.frame = self.container.frame;
    
    //填充模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    [self.container.layer addSublayer:playerLayer];
    //播放
    [self.player play];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.container addGestureRecognizer:tapGR];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.container.frame.size.height / 6 * 5 + self.container.frame.origin.y, self.container.frame.size.width, self.container.frame.size.height / 6)];
    self.sliderView.backgroundColor = [UIColor blackColor];
    [self.sliderView setAlpha:0.5];
    [self.totalView addSubview:self.sliderView];
    [_sliderView release];
    
    self.timeS = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, self.sliderView.frame.size.width, 10)];
    [self.timeS addTarget:self action:@selector(timeAction) forControlEvents:UIControlEventValueChanged];
    [self.timeS setThumbImage:[UIImage imageNamed:@"roundimage"] forState:UIControlStateNormal];
    [self.sliderView addSubview:self.timeS];
    [_timeS release];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.sliderView.frame.size.width / 6, self.sliderView.frame.size.height - 10)];
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    self.timeLabel.text = @"00:00/";
    [_timeLabel release];
    [self.sliderView addSubview:self.timeLabel];
    
    self.totalTimeL = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.frame.size.width, 10, self.sliderView.frame.size.width / 6, self.sliderView.frame.size.height - 10)];
    self.totalTimeL.textColor = [UIColor whiteColor];
    self.totalTimeL.textAlignment = NSTextAlignmentLeft;
    self.totalTimeL.text = @"00:00";
    [self.sliderView addSubview:self.totalTimeL];
    [_totalTimeL release];
    
    self.startBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startBut.frame = CGRectMake(self.totalTimeL.frame.size.width + self.totalTimeL.frame.origin.x, 10, self.sliderView.frame.size.width / 6, self.sliderView.frame.size.height - 10);
    [self.startBut setImage:[UIImage imageNamed:@"stopImage"] forState:UIControlStateNormal];
    [self.startBut setImage:[UIImage imageNamed:@"startImage"] forState:UIControlStateSelected];
    [self.startBut addTarget:self action:@selector(playClick) forControlEvents:UIControlEventTouchUpInside];
    [self.sliderView addSubview:self.startBut];
    
    
    self.screenBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.screenBut.frame = CGRectMake(self.sliderView.frame.size.width - self.sliderView.frame.size.height, 10, self.sliderView.frame.size.height, self.sliderView.frame.size.height - 10);
    [self.screenBut setImage:[UIImage imageNamed:@"screenImage"] forState:UIControlStateNormal];
    [self.screenBut addTarget:self action:@selector(screenButAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.sliderView addSubview:self.screenBut];
    
    
    
    
    self.backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backBut.frame = CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width / 11, [[UIScreen mainScreen] bounds].size.width / 11);
    [self.backBut setImage:[UIImage imageNamed:@"backImage"] forState:UIControlStateNormal];
    self.backBut.backgroundColor = [UIColor blackColor];
    [self.backBut setAlpha:0.5];
    self.backBut.layer.cornerRadius = self.backBut.frame.size.width / 2;
    [self.backBut addTarget:self action:@selector(backButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBut];
    
    
    
    self.titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.container.frame.size.width, self.container.frame.size.height / 6)];
    self.titleView.backgroundColor = [UIColor blackColor];
    self.titleView.alpha = 0.5;
    [self.totalView addSubview:self.titleView];
    [_titleView release];
    
    UILabel *titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,self.titleView.frame.size.width / 11 * 8, self.titleView.frame.size.height)];
    titleL.text = self.zyDance.item_title;
    titleL.textColor = [UIColor whiteColor];
    [self.titleView addSubview:titleL];
    [titleL release];
    
    self.localTimeL = [[UILabel alloc] initWithFrame:CGRectMake(titleL.frame.size.width + titleL.frame.origin.x, titleL.frame.origin.y, self.titleView.frame.size.width / 11, self.titleView.frame.size.height)];
    self.localTimeL.textColor = [UIColor whiteColor];
    [self.titleView addSubview:self.localTimeL];
    [_localTimeL release];
    [self getcurrentTimer];
    
    [self.titleView setHidden:YES];

}

//获取系统时间
- (void)getcurrentTimer
{
    NSDate *currentTime = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm"];
    NSString *locationStr = [dateformatter stringFromDate:currentTime];
    self.localTimeL.text = locationStr;
    [dateformatter release];
}

//详情but
- (void)detailButAction
{
//    self.collectionV.contentOffset = CGPointMake(0, [[UIScreen mainScreen] bounds].size.height - self.totalView.frame.size.height);
    self.collectionV.contentOffset = CGPointMake(0, 0);
    [self.detailBut setTitleColor:[UIColor colorWithRed:79 / 255.0 green:0 blue:40 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.relateBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
//相关but
- (void)relateButAction
{
    
//    self.collectionV.contentOffset = CGPointMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - self.totalView.frame.size.height);
    self.collectionV.contentOffset = CGPointMake(UIWIDTH, 0);
    [self.detailBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.relateBut setTitleColor:[UIColor colorWithRed:79 / 255.0 green:0 blue:40 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    
}

//滑动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (0 == self.collectionV.contentOffset.x) {
        [self.detailBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.relateBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else if (1 == self.collectionV.contentOffset.x / [[UIScreen mainScreen] bounds].size.width) {
        
        [self.detailBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.relateBut setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
    }
    
}

- (AVPlayerItem *)getPlayItem:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    return playerItem;
}



//隐藏view
- (void)tapAction
{
    if (_isRotation) {
        if (YES == self.sliderView.hidden  ) {
            [self.sliderView setHidden:NO];
             [self.titleView setHidden:NO];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
        } else if (NO == self.sliderView.hidden ) {
            [self.sliderView setHidden:YES];
            [self.titleView setHidden:YES];
        }
    } else {
        if (YES == self.sliderView.hidden) {
            [self.sliderView setHidden:NO];
           
            self.timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
        } else if (NO == self.sliderView.hidden ) {
            [self.sliderView setHidden:YES];
            
        }
    }
}

- (void)timerAction
{
    [self.sliderView setHidden:YES];
    [self.titleView setHidden:YES];
}

//横屏方法
- (void)screenButAction
{
    if (_isRotation) {
        self.isRotation = NO;
        [UIView animateWithDuration:0.2 animations:^{
            [self.totalView removeFromSuperview];
            self.totalView.transform = CGAffineTransformRotate(self.container.transform, -M_PI_2);
            [self createPlayerView:self.originalFrame];
            self.totalView.center = CGPointMake(self.originalFrame.origin.x + self.originalFrame.size.width / 2.0, self.originalFrame.origin.y + self.originalFrame.size.height / 2);
            self.backBut.hidden = NO;
            
        }];
    } else {
        
        self.isRotation = YES;
        [self.totalView removeFromSuperview];
        [UIView animateWithDuration:0.2 animations:^{
            
            CGRect FullFrame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
            [self createPlayerView:FullFrame];
            
            self.totalView.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2.0, [[UIScreen mainScreen] bounds].size.height / 2.0);
            self.totalView.transform = CGAffineTransformRotate(self.container.transform, M_PI_2);
            self.backBut.hidden = YES;
            self.titleView.hidden = NO;
        }];
    }
}


- (void)playClick
{
    //暂停时
    if (self.player.rate == 0) {
        self.startBut.selected = NO;
        [self.player play];
    } else if (self.player.rate == 1) {
        self.startBut.selected = YES;
        [self.player pause];
    }
}

//返回主界面
- (void)backButAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:NO];
    [self.player pause];
}

//进度条
- (void)timeAction
{
    if (0 == self.player.rate) {
        [self.player seekToTime:CMTimeMake((int)self.timeS.value * 10, 10.0)];
        [self.player play];
        self.startBut.selected = NO;
    } else if (1 == self.player.rate) {
        [self.player pause];
        [self.player seekToTime:CMTimeMake((int)self.timeS.value * 10, 10.0)];
        [self.player play];
    }
}

- (void)customVideozSlider:(CMTime)duration
{
    self.timeS.maximumValue = CMTimeGetSeconds(duration);
    self.timeS.minimumValue = 0.0;
}

//添加进度条
- (void)addTimeobserver
{
    AVPlayerItem *playerItem = self.player.currentItem;
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        if (self.numtime != 0) {
        [self.player seekToTime:CMTimeMake(self.numtime, 10.0)];
        }
        CGFloat total = CMTimeGetSeconds([playerItem duration]);
        CGFloat current = CMTimeGetSeconds(time);
        NSString *newtime = [self changeTimer:current];
        NSString *totaltime = [self changeTimer:total];
        self.timeLabel.text = [NSString stringWithFormat:@"%@/",  newtime];
        self.totalTimeL.text = [NSString stringWithFormat:@"%@", totaltime];
        [self.timeS setValue:current animated:YES];
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
//            NSLog(@"正在播放........");
            [self customVideozSlider:playerItem.duration];
        }
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
//        NSArray *array = playerItem.loadedTimeRanges;
//        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
//        float startSecond = CMTimeGetSeconds(timeRange.start);
//        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
//        NSTimeInterval totalBuffer = startSecond + durationSeconds;
//        NSLog(@"一共缓存多少秒%0.2f", totalBuffer);
    }
    
}

//初始化播放器
- (AVPlayer *)player
{
//    WLZ_Dance_videoModel *wlzvideo = [self.zyDance.item_videos objectAtIndex:0];
    if (!_player) {
        AVPlayerItem *playerItem = [self getPlayItem:self.zyDance.url];
        _player = [AVPlayer playerWithPlayerItem:playerItem];
        
        [self addobserverToplayerItem:playerItem];
        [self addTimeobserver];
        
    }
    
    return _player;
}



- (void)createunderView
{
    self.butView = [[UIView alloc] initWithFrame:CGRectMake(0, self.container.frame.origin.y + self.container.frame.size.height, self.container.frame.size.width, ([[UIScreen mainScreen] bounds].size.height / 2 -  [[UIScreen mainScreen] bounds].size.height / 3) / 2)];
    self.butView.backgroundColor = [UIColor blackColor];

    self.butView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];

    [self.view addSubview:self.butView];
    
    self.detailBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.detailBut.frame = CGRectMake(0, 0, self.butView.frame.size.width / 2, self.butView.frame.size.height);
    [self.detailBut setTitle:@"详情" forState:UIControlStateNormal];
    [self.detailBut setTitleColor:[UIColor colorWithRed:79 / 255.0 green:0 blue:40 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    self.detailBut.backgroundColor = [UIColor blackColor];
    [self.detailBut addTarget:self action:@selector(detailButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.butView addSubview:self.detailBut];
    
    self.relateBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.relateBut.frame = CGRectMake(self.detailBut.frame.size.width, 0, self.butView.frame.size.width / 2, self.butView.frame.size.height);
    self.relateBut.backgroundColor = [UIColor blackColor];
    [self.relateBut setTitle:@"相关" forState:UIControlStateNormal];
    [self.relateBut addTarget:self action:@selector(relateButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.butView addSubview:self.relateBut];
    
    
    UICollectionViewFlowLayout *flowL = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowL.minimumLineSpacing = 0;
    flowL.minimumInteritemSpacing = 0;
    flowL.itemSize = CGSizeMake(self.view.frame.size.width, [[UIScreen mainScreen] bounds].size.height - self.totalView.frame.size.height);
    flowL.headerReferenceSize = CGSizeMake(0, 0);
    
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.butView.frame.size.height + self.butView.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - self.totalView.frame.size.height) collectionViewLayout:flowL];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [UIColor clearColor];
    self.collectionV.pagingEnabled = YES;
    [self.view addSubview:self.collectionV];
    
    [self.collectionV registerClass:[WLZ_Dance_detailCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionV registerClass:[WLZ_Dance_contentCollectionViewCell class] forCellWithReuseIdentifier:@"cell2"];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (0 == indexPath.row) {
        WLZ_Dance_contentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.titleL.numberOfLines = 0;
        cell.titleL.text = self.zyDance.item_title;
        cell.catalogL.text = self.zyDance.item_catalog;
        cell.productL.text = self.zyDance.item_product;
        cell.purposeL.text = self.zyDance.item_purpose;
        cell.suitableL.text = self.zyDance.item_suitable;
        cell.groupL.text = self.zyDance.item_group;
        cell.genderL.text = self.zyDance.item_group_gender;
        cell.summaryL.text = self.zyDance.item_summary;
        return cell;
    }
    if (1 == indexPath.row) {
        WLZ_Dance_detailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.page ++;
            [self getrelateData];
            
        }];
        cell.arr = self.arr;
        cell.delegate = self;
        return cell;
    }
    return nil;

    
}

//点击 协议 方法
- (void)transferValue:(WLZ_Dance_ListModel *)wlzdance
{
    [self removeObserverFromPlayerItem:self.player.currentItem];
    AVPlayerItem *playerItem = [self getPlayItem:wlzdance.url];
    [self addobserverToplayerItem:playerItem];
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    self.zyDance = wlzdance;
    
    [self.arr removeAllObjects];
    [self getrelateData];
}

- (void)getrelateData
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api3.dance365.com/video/search?word=%@&perpage=10&page=%ld",self.zyDance.item_title, self.page];
    ;
    [LQQAFNetTool getNetWithURL:urlStr body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *resultArr = [responseObject objectForKey:@"result"];
        
        
        for (NSMutableDictionary *tempDic in resultArr) {
            WLZ_Dance_ListModel *zylist = [WLZ_Dance_ListModel baseModelWithDic:tempDic];
            [self.arr addObject:zylist];
            NSMutableArray *videoArr = [tempDic objectForKey:@"item_videos"];
            for (NSMutableDictionary *videoDic in videoArr) {
                NSString *url = [videoDic objectForKey:@"url"];
                zylist.url = url;
            }
            
        }
        
        [self.collectionV reloadData];
//        [self reloadCellTabel];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];

}
- (void)viewWillAppear:(BOOL)animated
{
    //进入视频播放界面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"videoPlay" object:nil];
}
- (void)viewDidDisappear:(BOOL)animated
{
    //退出视频界面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"videoStop" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
