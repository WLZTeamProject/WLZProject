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

#import "LeftSlideViewController.h"
@interface AppDelegate ()
@property (nonatomic, retain) UINavigationController *radioNC;
@property (nonatomic, retain) UINavigationController *videoNC;
@property (nonatomic, retain) UINavigationController *readNC;
@property (nonatomic, retain) UINavigationController *newsNC;
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
    NSMutableArray *arr = [NSMutableArray array];//存放VC
//    WLZNewRootViewController *newRootVC = [[WLZNewRootViewController alloc] init];
//    UINavigationController *newNC = [[[UINavigationController alloc] initWithRootViewController:newRootVC] autorelease];
//    newNC.navigationBar.translucent = NO;
//    newNC.navigationBar.tintColor = [UIColor blackColor];
//    newNC.tabBarItem.title = @"新闻";
//    newNC.tabBarItem.image = [UIImage imageNamed:@"tab_news"];
//    [arr addObject:newNC];
//    [newRootVC release];
    //资讯
    WLZ_News_ViewController *newsVC = [[WLZ_News_ViewController alloc] init];
    UINavigationController *newsNC = [[[UINavigationController alloc] initWithRootViewController:newsVC] autorelease];
    newsNC.navigationBar.translucent = NO;
        newsNC.navigationBar.tintColor = [UIColor blackColor];
        newsNC.tabBarItem.title = @"资讯";
        newsNC.tabBarItem.image = [UIImage imageNamed:@"tab_news"];
        [arr addObject:newsNC];
        [newsVC release];
    
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
    return YES;
}
- (void)notificationNightAction
{
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
