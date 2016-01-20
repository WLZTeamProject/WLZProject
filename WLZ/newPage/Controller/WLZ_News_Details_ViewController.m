//
//  WLZ_News_Details_ViewController.m
//  WLZ
//
//  Created by 왕닝 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_News_Details_ViewController.h"
#import "WLZ_News_Model.h"
#import "WLZ_PCH.pch"

@interface WLZ_News_Details_ViewController ()

@property (nonatomic, retain) UIWebView *webView;

@end

@implementation WLZ_News_Details_ViewController
- (void)dealloc
{
    [_webView release];
    [_sourceWebUrl release];
    [super dealloc];
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];

    self.view.backgroundColor = [UIColor orangeColor];
    UIWebView *webV = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 60)];
    webV.dataDetectorTypes = UIDataDetectorTypeAll;
    NSURL *url = [NSURL URLWithString:self.sourceWebUrl];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webV loadRequest:request];
    [self.view addSubview:webV];
    [webV release];
}
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
