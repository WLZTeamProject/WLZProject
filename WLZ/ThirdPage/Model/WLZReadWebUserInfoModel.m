//
//  WLZReadWebUserInfoModel.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadWebUserInfoModel.h"

@implementation WLZReadWebUserInfoModel
- (void)dealloc
{
    [_uid release];
    [_uname release];
    [_icon release];
    [_desc release];
    [super dealloc];
}
@end
