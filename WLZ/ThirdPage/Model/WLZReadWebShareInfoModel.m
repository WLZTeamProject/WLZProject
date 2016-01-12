//
//  WLZReadWebShareInfoModel.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadWebShareInfoModel.h"

@implementation WLZReadWebShareInfoModel

- (void)dealloc
{
    [_pic release];
    [_text release];
    [_url release];
    [_title release];
    [super dealloc];
}
@end
