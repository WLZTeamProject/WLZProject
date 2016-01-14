//
//  WLZNewsVideoModel.m
//  WLZ
//
//  Created by lqq on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZNewsVideoModel.h"

@implementation WLZNewsVideoModel
- (void)dealloc
{
    [_title release];
    [_hls_url release];
    [_play_channel release];
    [_editer_name release];
    [super dealloc];
}
@end
