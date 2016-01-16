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
    [_item_group release];
    [_item_group_gender release];
    [_item_suitable release];
    [_item_catalog release];
    [_item_summary release];
    [_item_product release];
    [_item_purpose release];
    [super dealloc];
}
@end
