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


#import "LeftSlideViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)dealloc
{
    [_window release];
    [_leftVC release];
    [_tabBar release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSMutableArray *arr = [NSMutableArray array];//存放VC
//    WLZNewRootViewController *newRootVC = [[WLZNewRootViewController alloc] init];
//    UINavigationController *newNC = [[[UINavigationController alloc] initWithRootViewController:newRootVC] autorelease];
//    newNC.navigationBar.translucent = NO;
//    newNC.navigationBar.tintColor = [UIColor blackColor];
//    newNC.tabBarItem.title = @"新闻";
//    newNC.tabBarItem.image = [UIImage imageNamed:@"tab_news"];
//    [arr addObject:newNC];
//    [newRootVC release];
    
    
    //音频VC
    WLZRadioRootViewController *radioRootVC =[[WLZRadioRootViewController alloc] init];
    UINavigationController *radioNC = [[[UINavigationController alloc] initWithRootViewController:radioRootVC] autorelease];
    radioNC.navigationBar.translucent = NO;
    radioNC.tabBarItem.title = @"视频";
    radioNC.tabBarItem.image = [UIImage imageNamed:@"tab_radio"];
    [arr addObject:radioNC];
    [radioRootVC release];

    
    
    //视频VC
    WLZVideoRootViewController *videoRootVC = [[WLZVideoRootViewController alloc] init];
    UINavigationController *videoNC = [[[UINavigationController alloc] initWithRootViewController:videoRootVC] autorelease];
    videoNC.tabBarItem.title = @"电台";
    videoNC.navigationBar.translucent = NO;
    videoNC.tabBarItem.image = [UIImage imageNamed:@"tab_video"];
    [arr addObject:videoNC];
    [videoRootVC release];
    
    //阅读VC
    WLZReadRootViewController *readRootVC = [[WLZReadRootViewController alloc] init];
    UINavigationController *readNC = [[[UINavigationController alloc] initWithRootViewController:readRootVC] autorelease];
    readNC.navigationBar.translucent = NO;
    readNC.tabBarItem.title = @"阅读";
    readNC.tabBarItem.image = [UIImage imageNamed:@"tab_read"];
    [arr addObject:readNC];
    [readRootVC release];
    

    
    
    self.tabBar = [[UITabBarController alloc] init];
    self.tabBar.tabBar.tintColor = [UIColor colorWithRed:0.502 green:0.0 blue:1.0 alpha:1.0];
    self.tabBar.tabBar.barTintColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.0];
    self.tabBar.viewControllers = arr;
    self.tabBar.tabBar.translucent = NO;
//    self.window.rootViewController = tabBarC;
    
    
    WLZUserRootViewController *userVC = [[WLZUserRootViewController alloc] init];
     self.leftVC = [[LeftSlideViewController alloc] initWithLeftView:userVC andMainView:self.tabBar];
    self.window.rootViewController = self.leftVC;
    [_leftVC release];
    [userVC release];
    
    
    
    return YES;
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
