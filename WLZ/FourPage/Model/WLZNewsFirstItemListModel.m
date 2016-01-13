//
//  WLZNewsFirstItemListModel.m
//  WLZ
//
//  Created by lqq on 16/1/12.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZNewsFirstItemListModel.h"

@implementation WLZNewsFirstItemListModel
- (void)dealloc
{
    [_title release];
    [_isLanmu release];
    [_listUrl release];
    [_moreUrl release];
    [_order release];
    [super dealloc];
}
@end
