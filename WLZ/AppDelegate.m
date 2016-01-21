//
//  AppDelegate.m
//  WLZ
//
//  Created by lqq on 16/1/8.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "AppDelegate.h"
#import "WLZRadioRootViewController.h"
#import "WLZVideoRootViewController.h"
#import "WLZReadRootViewController.h"
#import "WLZUserRootViewController.h"
#import "WLZNewRootViewController.h"
#import "WLZ_News_ViewController.h"
#import "WLZ_PCH.pch"
#import "WN_Leader_ViewController.h"
#import "LeftSlideViewController.h"
#import "WLZ_PCH.pch"
@interface AppDelegate () <UIScrollViewDelegate>
@property (nonatomic, retain) UINavigationController *radioNC;
@property (nonatomic, retain) UINavigationController *videoNC;
@property (nonatomic, retain) UINavigationController *readNC;
@property (nonatomic, retain) UINavigationController *newsNC;
@property (nonatomic, assign) BOOL isOut;
@end

@implementation AppDelegate
- (void)dealloc
{
    [_radioNC release];
    [_videoNC release];
    [_readNC release];
    [_newsNC release];
    [_window release];
    [_leftVC release];
    [_tabBar release];
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [UMSocialData setAppKey:@"5699b3a5e0f55a1f1c00159d"];
    [UMSocialQQHandler setQQWithAppId:@"1104881132" appKey:@"LTKWFVGSDaN52TOo" url:@"http://www.baidu.com"];
    [UMSocialWechatHandler setWXAppId:@"wx8296f2e05470ba30" appSecret:@"81a048ef1f51e2d83e01455d011cd4ca" url:@"http://www.baidu.com"];
    self.isOut = NO;
    NSString *isFirst = [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirst"];
    
    if (![isFirst isEqualToString:@"4"]) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"4" forKey:@"isFirst"];
        [userDefaults synchronize];
        [self makeLaunchView];//为假表示没有文件，没有进入过主页
    }else{
        [self creatAPP];//为真表示已有文件 曾经进入过主页
    }
    return YES;
}

//引导页面
-(void)makeLaunchView{
    
    WN_Leader_ViewController *leader = [[WN_Leader_ViewController alloc]init];
    self.window.rootViewController = leader;
    
    NSArray *arr = [NSArray arrayWithObjects:@"yindao1",@"yindao2",@"yindao3", nil ,nil];//数组内存放的是我要显示的假引导页面图片
    //通过scrollView 将这些图片添加在上面，从而达到滚动这些图片
    UIScrollView *scr = [[UIScrollView alloc] initWithFrame:self.window.bounds];
    scr.contentSize = CGSizeMake(UIWIDTH, self.window.frame.size.height  * arr.count);
    scr.pagingEnabled = YES;
    scr.tag = 7000;
    scr.delegate = self;
    [leader.view addSubview:scr];
    for (int i = 0; i < arr.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*UIHEIGHT, UIWIDTH, self.window.frame.size.height)];
        img.image = [UIImage imageNamed:arr[i]];
        [scr addSubview:img];
        [img release];
    }
    
    
}
#pragma mark scrollView的代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //这里是在滚动的时候判断 我滚动到哪张图片了，如果滚动到了最后一张图片，那么
    //如果在往下面滑动的话就该进入到主界面了，我这里利用的是偏移量来判断的，当
    //一共五张图片，所以当图片全部滑完后 又像后多滑了30 的时候就做下一个动作
    scrollView.showsHorizontalScrollIndicator = NO;
    if (scrollView.contentOffset.y > 2 * UIHEIGHT + 30) {
        
        self.isOut=YES;//这是我声明的一个全局变量Bool 类型的，初始值为no，当达到我需求的条件时将值改为yes
        
    }
}
//停止滑动
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //判断isout为真 就要进入主界面了
    if (self.isOut) {
        //这里添加了一个动画
        [UIView animateWithDuration:.5 animations:^{
            //            scrollView.alpha=0;//让scrollview 渐变消失
            
        }completion:^(BOOL finished) {
            [scrollView  removeFromSuperview];//将scrollView移除
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"states"];
            [self creatAPP];//进入主界面
            
        } ];
    }
    
}

- (void)creatAPP
{
    //如果第一次进入没有文件，我们就创建这个文件
    NSFileManager *manager=[NSFileManager defaultManager];
    //判断 我是否创建了文件，如果没创建 就创建这个文件（这种情况就运行一次，也就是第一次启动程序的时候）
    if (![manager fileExistsAtPath:[NSHomeDirectory() stringByAppendingString:@"aa.txt"]]) {
        [manager createFileAtPath:[NSHomeDirectory() stringByAppendingString:@"aa.txt"] contents:nil attributes:nil];
    }
    

    
    
    
    
    
    NSMutableArray *arr = [NSMutableArray array];//存放VC
    //阅读VC
    WLZReadRootViewController *readRootVC = [[WLZReadRootViewController alloc] init];
    self.readNC = [[[UINavigationController alloc] initWithRootViewController:readRootVC] autorelease];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
        self.readNC.navigationBar.tintColor = [UIColor whiteColor];
        self.readNC.navigationBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];    } else {
            self.readNC.navigationBar.tintColor = [UIColor blackColor];
            self.readNC.navigationBar.barTintColor = [UIColor whiteColor];
        }
    self.readNC.navigationBar.translucent = NO;
    self.readNC.tabBarItem.title = @"阅读";
    self.readNC.tabBarItem.image = [UIImage imageNamed:@"tab_read"];
    [arr addObject:self.readNC];
    [readRootVC release];
    //音频VC
    WLZRadioRootViewController *radioRootVC =[[WLZRadioRootViewController alloc] init];
    self.radioNC = [[[UINavigationController alloc] initWithRootViewController:radioRootVC] autorelease];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
        self.radioNC.navigationBar.tintColor = [UIColor whiteColor];
        self.radioNC.navigationBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
       
    } else {
        self.radioNC.navigationBar.tintColor = [UIColor blackColor];
        self.radioNC.navigationBar.barTintColor = [UIColor whiteColor];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    self.radioNC.navigationBar.translucent = NO;
    self.radioNC.tabBarItem.title = @"视频";
    self.radioNC.tabBarItem.image = [UIImage imageNamed:@"tab_radio"];
    [arr addObject:self.radioNC];
    [radioRootVC release];

    
    
    //视频VC
    WLZVideoRootViewController *videoRootVC = [[WLZVideoRootViewController alloc] init];
    self.videoNC = [[[UINavigationController alloc] initWithRootViewController:videoRootVC] autorelease];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
        self.videoNC.navigationBar.tintColor = [UIColor whiteColor];
        self.videoNC.navigationBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];    } else {
        self.videoNC.navigationBar.tintColor = [UIColor blackColor];
        self.videoNC.navigationBar.barTintColor = [UIColor whiteColor];
    }
    self.videoNC.tabBarItem.title = @"电台";
    self.videoNC.navigationBar.translucent = NO;
    self.videoNC.tabBarItem.image = [UIImage imageNamed:@"tab_video"];
    [arr addObject:self.videoNC];
    [videoRootVC release];
    

    //资讯
    WLZ_News_ViewController *newsVC = [[WLZ_News_ViewController alloc] init];
    self.newsNC = [[[UINavigationController alloc] initWithRootViewController:newsVC] autorelease];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
        self.newsNC.navigationBar.tintColor = [UIColor whiteColor];
        self.newsNC.navigationBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    } else {
        self.newsNC.navigationBar.tintColor = [UIColor blackColor];
        self.newsNC.navigationBar.barTintColor = [UIColor whiteColor];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    self.newsNC.navigationBar.translucent = NO;
    self.newsNC.navigationBar.tintColor = [UIColor blackColor];
    self.newsNC.tabBarItem.title = @"资讯";
    self.newsNC.tabBarItem.image = [UIImage imageNamed:@"tab_news"];
    [arr addObject:self.newsNC];
    [newsVC release];
    

    
    
    self.tabBar = [[UITabBarController alloc] init];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
        self.tabBar.tabBar.tintColor = [UIColor colorWithRed:0.502 green:0.0 blue:1.0 alpha:1.0];
        self.tabBar.tabBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];
    } else {
        self.tabBar.tabBar.tintColor = [UIColor colorWithRed:0.502 green:0.0 blue:1.0 alpha:1.0];
        self.tabBar.tabBar.barTintColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    }
    self.tabBar.viewControllers = arr;
    self.tabBar.tabBar.translucent = NO;
    
    
    WLZUserRootViewController *userVC = [[WLZUserRootViewController alloc] init];
     self.leftVC = [[LeftSlideViewController alloc] initWithLeftView:userVC andMainView:self.tabBar];
    self.window.rootViewController = self.leftVC;
    [_leftVC release];
    [userVC release];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationNightAction) name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter ] addObserver:self selector:@selector(notificationDayAction) name:@"day" object:nil];
    
}
- (void)notificationNightAction
{
    self.newsNC.navigationBar.tintColor = [UIColor whiteColor];
    self.newsNC.navigationBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];
    
    self.radioNC.navigationBar.tintColor = [UIColor whiteColor];
    self.radioNC.navigationBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];
    
    
    self.videoNC.navigationBar.tintColor = [UIColor whiteColor];
    self.videoNC.navigationBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];
    
    self.readNC.navigationBar.tintColor = [UIColor whiteColor];
    self.readNC.navigationBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];
    
    
    self.tabBar.tabBar.tintColor = [UIColor colorWithRed:0.502 green:0.0 blue:1.0 alpha:1.0];
    self.tabBar.tabBar.barTintColor = [UIColor colorWithRed:0.2166 green:0.2155 blue:0.2176 alpha:1.0];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    

}
- (void)notificationDayAction
{
    self.newsNC.navigationBar.tintColor = [UIColor blackColor];
    self.newsNC.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.radioNC.navigationBar.tintColor = [UIColor blackColor];
    self.radioNC.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    self.videoNC.navigationBar.tintColor = [UIColor blackColor];
    self.videoNC.navigationBar.barTintColor = [UIColor whiteColor];
    
    
    self.readNC.navigationBar.tintColor = [UIColor blackColor];
    self.readNC.navigationBar.barTintColor = [UIColor whiteColor];
    self.tabBar.tabBar.tintColor = [UIColor colorWithRed:0.502 green:0.0 blue:1.0 alpha:1.0];
    self.tabBar.tabBar.barTintColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    

}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.

}


@end
