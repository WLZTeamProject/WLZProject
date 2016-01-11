//
//  WLZ_Dance_ListModel.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_ListModel.h"

@implementation WLZ_Dance_ListModel
- (void)dealloc
{
    [_item_click release];
    [_item_id release];
    [_item_title release];
    [_item_image release];
    [super dealloc];
}
@end
