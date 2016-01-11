//
//  WLZReadListModel.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadListModel.h"

@implementation WLZReadListModel
- (void)dealloc
{
    [_name release];
    [_title release];
    [_coverimg release];
    [_content release];
    [super dealloc];
}
@end
