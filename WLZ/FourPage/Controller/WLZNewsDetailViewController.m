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
@interface WLZNewsDetailViewController ()
@property (nonatomic, retain) WLZNewPlayer *newsPlayer;

@end

@implementation WLZNewsDetailViewController
- (void)dealloc
{
    [_newsPlayer release];
    [_vId release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    NSString *url =[NSString stringWithFormat:@"http://vdn.apps.cntv.cn/api/getHttpVideoInfo.do?pid=%@", self.vId];
    self.newsPlayer = [[WLZNewPlayer alloc] initWithFrame:CGRectMake(0, 0, UIWIDTH, UIWIDTH) videoURL:@"http://video.szzhangchu.com/1448627341251_7499412430.mp4"];
    
    
    
    [self.view addSubview:self.newsPlayer];
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
