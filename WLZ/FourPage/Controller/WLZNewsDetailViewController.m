//
//  WLZNewsDetailViewController.m
//  WLZ
//
//  Created by lqq on 16/1/13.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZNewsDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "WLZNewPlayer.h"
#import "LQQAFNetTool.h"
#import "WLZNewsVideoModel.h"
@interface WLZNewsDetailViewController ()
@property (nonatomic, retain) WLZNewPlayer *newsPlayer;
@property (nonatomic, retain) WLZNewsVideoModel *model;
@end

@implementation WLZNewsDetailViewController
- (void)dealloc
{
    [_model release];
    [_newsPlayer release];
    [_vId release];
    [super dealloc];
}


+ (instancetype)shareDetailViewController
{
    static WLZNewsDetailViewController *detailVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        detailVC = [[WLZNewsDetailViewController alloc] init];
    });
    return detailVC;
}


- (void)setVId:(NSString *)vId
{
    if (_vId != vId) {
        [_vId release];
        _vId = [vId copy];
        NSLog(@"%@", vId);
    }
    [self createData:_vId];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma 创建playerView
- (void)createPlayerView
{
    
    self.newsPlayer = [[WLZNewPlayer alloc] initWithFrame:CGRectMake(0, 0, UIWIDTH, UIWIDTH) videoURL:self.model.hls_url];
    [self.view addSubview:self.newsPlayer];
    [_newsPlayer release];
}
- (void)createData:(NSString *)vid
{
    NSString *url =[NSString stringWithFormat:@"http://vdn.apps.cntv.cn/api/getHttpVideoInfo.do?pid=%@", vid];
    [LQQAFNetTool getNetWithURL:url body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.model = [WLZNewsVideoModel baseModelWithDic:responseObject];
        NSLog(@"%@", self.model.hls_url);
        [self createPlayerView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
