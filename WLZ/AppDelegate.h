//
//  AppDelegate.h
//  WLZ
//
//  Created by lqq on 16/1/8.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LeftSlideViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) LeftSlideViewController *leftVC;
@property (nonatomic, retain) UITabBarController *tabBar;

@end

