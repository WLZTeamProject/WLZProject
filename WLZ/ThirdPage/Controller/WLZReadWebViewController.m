//
//  WLZReadWebViewController.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadWebViewController.h"
#import "LQQAFNetTool.h"
#import <MBProgressHUD.h>
#import <MJRefresh.h>
#define DOCURL @"http://api2.pianke.me/article/info"
#import "WLZReadWebFirstLevelModel.h"

#import "WLZReadWebUserInfoModel.h"
#import "WLZReadWebShareInfoModel.h"
#import "WLZReadWebCounterListModel.h"
@interface WLZReadWebViewController () <UIWebViewDelegate>
@property (nonatomic, retain) NSMutableDictionary *bodyDic;
@property (nonatomic, retain) WLZReadWebFirstLevelModel *model;

@property (nonatomic, retain) WLZReadWebUserInfoModel *userModel;
@property (nonatomic, retain) WLZReadWebShareInfoModel *shareInfoModel;
@property (nonatomic, retain) WLZReadWebCounterListModel *counterlistModel;

@property (nonatomic, retain) UIWebView *webView;
@property (nonatomic, retain) MBProgressHUD *hud;
@end

@implementation WLZReadWebViewController
- (void)dealloc
{
    [_counterlistModel release];
    [_shareInfoModel release];
    [_userModel release];
    [_webView release];
    [_hud release];
    [_mId release];
    [_model release];
    [_bodyDic release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubviews];
}
- (void)createSubviews
{
    [self createViews];
    [self createData];
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    self.webView = [[UIWebView alloc] init];
    //webview的页面与html大小一致,不一致是的时候进行缩放, 默认为NO;
//    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    


//    [self createToolBar];
    
}
- (void)createToolBar
{
    NSMutableArray *toolBarItems = [NSMutableArray array];
    UIToolbar *mytoolbar = [[UIToolbar alloc] init];
    [self.view addSubview:mytoolbar];
    
    
    [mytoolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
        
    }];
    
    //占位键:指定宽度
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton.width = 50;
    [toolBarItems addObject:spaceButton];
    //收藏键
    UIButton *collectB = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectB setTitle:@"收藏" forState:UIControlStateNormal];
    [collectB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [collectB addTarget:self action:@selector(toolbarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectButton = [[UIBarButtonItem alloc] initWithCustomView:collectB];
    [toolBarItems addObject:collectButton];
    
    [mytoolbar setItems:toolBarItems animated:YES];
    //字体键
//    [self.navigationController.toolbar setItems:toolBarItems animated:YES];
}
- (void)toolbarAction:(UIButton *)sender
{
    
    
    
}

#pragma 创建视图
- (void)createViews
{

    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:self.model.html baseURL:nil];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //字体大小
     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName(‘body‘)[0].style.webkitTextSizeAdjust=‘200%‘"];
    //字体颜色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor='white'"];
    
    //页面背景色
    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2E2E2E'"];
//    获取title
    [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    
}


#pragma 请求数据
- (void)createData
{
    //contentid=568b3c8d5e774337628b462c&client=2
    self.bodyDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"568b3c8d5e774337628b462c",@"contentid",@"2", @"client", nil];
    [self.bodyDic setObject:self.mId forKey:@"contentid"];
    [LQQAFNetTool postNetWithURL:DOCURL body:self.bodyDic bodyStyle:LQQRequestJSON headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableDictionary *dic = responseObject[@"data"];
        self.model = [WLZReadWebFirstLevelModel baseModelWithDic:dic];
        self.userModel = [WLZReadWebUserInfoModel baseModelWithDic:self.model.userinfo];
        self.shareInfoModel = [WLZReadWebShareInfoModel baseModelWithDic:self.model.shareinfo];
        self.counterlistModel = [WLZReadWebCounterListModel baseModelWithDic:self.model.counterList];
        
        if (self.model) {
            [self.hud removeFromSuperview];
            [self.hud release];
            self.hud = nil;
//            [self.webView reload];
            
            [self createViews];
        }
//        NSLog(@"%@", self.model.html);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
     
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
