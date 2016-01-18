//
//  WLZBaseLabel.m
//  WLZ
//
//  Created by lqq on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseLabel.h"

@implementation WLZBaseLabel
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"day" object:nil];
    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
        self.textColor = [UIColor colorWithRed:0.83 green:0.83 blue:0.83 alpha:1.0];
    } else {
        self.textColor = [UIColor blackColor];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationNightAction) name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationDayAction) name:@"day" object:nil];
    
}
- (void)notificationNightAction
{
    self.textColor = [UIColor colorWithRed:0.861 green:0.861 blue:0.861 alpha:1.0];
}
- (void)notificationDayAction
{
    self.textColor = [UIColor blackColor];
}
@end
