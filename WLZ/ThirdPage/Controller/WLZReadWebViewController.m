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
@property (nonatomic, retain) UIToolbar *mytoolbar;


@property (nonatomic, assign) NSInteger indexSize;
@end

@implementation WLZReadWebViewController
- (void)dealloc
{
    [_mytoolbar release];
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
    self.indexSize = 100;
    
    
}
#pragma 状态栏的style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)createSubviews
{
    [self createViews];
    [self createData];
    
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    //重置滑动返回手势
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

    //创建toolBar
    [self createToolBar];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.translucent = YES;
    //设置navBar背景色和字体颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.298 green:0.298 blue:0.298 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma 创建toolbar
- (void)createToolBar
{
    NSMutableArray *toolBarItems = [NSMutableArray array];
    
    self.mytoolbar = [[UIToolbar alloc] init];
    self.mytoolbar.barTintColor = [UIColor blackColor];
    [self.view addSubview:self.mytoolbar];
    [self.mytoolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
        
    }];
    //占位键:指定宽度
    UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceButton.width = UIWIDTH / 9;
    [toolBarItems addObject:spaceButton];
    //收藏键
    UIButton *collectB = [UIButton buttonWithType:UIButtonTypeCustom];
    collectB.frame = CGRectMake(0, 0, 40, 40);
    collectB.selected = NO;
    [collectB setImage:[UIImage imageNamed:@"tool_collect"] forState:UIControlStateNormal];
    [collectB setImage:[UIImage imageNamed:@"tool_collect_red"] forState:UIControlStateSelected];
    collectB.tag = 10000;
    [collectB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [collectB addTarget:self action:@selector(toolbarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectButton = [[UIBarButtonItem alloc] initWithCustomView:collectB];
    [toolBarItems addObject:collectButton];
    
    
    //夜间模式
    UIButton *nightB = [UIButton buttonWithType:UIButtonTypeCustom];
    nightB.frame = CGRectMake(0, 0, 40, 40);
    nightB.selected = NO;
    [nightB setImage:[UIImage imageNamed:@"tool_day"] forState:UIControlStateNormal];
    [nightB setImage:[UIImage imageNamed:@"tool_night-1"] forState:UIControlStateSelected];
    nightB.tag = 10001;
    [nightB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [nightB addTarget:self action:@selector(toolbarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nightButton = [[UIBarButtonItem alloc] initWithCustomView:nightB];

    //占位按键
    [toolBarItems addObject:spaceButton];
    [toolBarItems addObject:nightButton];

    //字体
    UIButton *fontaddB = [UIButton buttonWithType:UIButtonTypeCustom];
    fontaddB.frame = CGRectMake(0, 0, 40, 40);
    fontaddB.selected = NO;
    [fontaddB setImage:[UIImage imageNamed:@"tool_top"] forState:UIControlStateNormal];
    fontaddB.tag = 10002;
    [fontaddB setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [fontaddB addTarget:self action:@selector(toolbarAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *fontButton = [[UIBarButtonItem alloc] initWithCustomView:fontaddB];
    //占位按键
    [toolBarItems addObject:spaceButton];
    [toolBarItems addObject:fontButton];
    
    [self.mytoolbar setItems:toolBarItems animated:YES];
    [self.view bringSubviewToFront:self.mytoolbar];
}
- (void)toolbarAction:(UIButton *)sender
{
    if (10000 == sender.tag) {
        if (NO == sender.selected) {
            NSLog(@"收藏");
        } else {
            NSLog(@"取消");
        }
        sender.selected = !sender.selected;
    }
    if (10001 == sender.tag) {
        if (NO == sender.selected) {
            NSLog(@"夜间");
            [self changeWebToNight];
        } else {
            [self changeWebToDay];
            NSLog(@"日间");
        }
        sender.selected = !sender.selected;
    }
    //字体增大
    if (10002 == sender.tag) {
        NSLog(@"返回顶部");
        self.webView.scrollView.contentOffset = CGPointMake(0, 0);
    }
    
}

#pragma 创建视图
- (void)createViews
{
    self.webView = [[UIWebView alloc] init];
    //webview的页面与html大小一致,不一致是的时候进行缩放, 默认为NO;
    //    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(UIHEIGHT - 50);
    }];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"· · ·" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    
    
}
#pragma 分享
- (void)rightAction
{
    NSLog(@"分享");
    
}

#pragma 协议方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //禁止用户选择
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect=‘none‘"];
    //禁止长按弹出
      [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout=‘none‘"];
    //更改网页中图片的大小以适应窗口
    [self changeWebImage];
    
    

    //将toolBar移动最前面
    [self.view bringSubviewToFront:self.mytoolbar];
}
#pragma 修改图片的大小
- (void)changeWebImage
{
    [self.webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth = 300.0;" // UIWebView中显示的图片宽度
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}
#pragma 夜间模式
- (void)changeWebToNight
{
    //字体颜色
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor='white'"];
    
    //页面背景色
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2E2E2E'"];
}
#pragma 日间模式
- (void)changeWebToDay
{
    //字体颜色
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor='black'"];
    
    //页面背景色
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#F4F4F4'"];
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
            [self.webView loadHTMLString:self.model.html baseURL:nil];
            self.navigationItem.title = self.shareInfoModel.title;
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
    
     
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
