//
//  WLZReadWebFirstLevelModel.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadWebFirstLevelModel.h"
#import "WLZReadWebUserInfoModel.h"
#import "WLZReadWebShareInfoModel.h"
#import "WLZReadWebCounterListModel.h"
@implementation WLZReadWebFirstLevelModel

- (void)dealloc
{
    [_html release];
    [_shareinfo release];
    [_userinfo release];
    [_counterList release];
    [super dealloc];
}
@end
