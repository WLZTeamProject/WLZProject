//
//  WLZNewFirstModel.m
//  WLZ
//
//  Created by lqq on 16/1/12.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZNewFirstModel.h"

@implementation WLZNewFirstModel
- (void)dealloc
{
    [_title release];
    [_brief release];
    [_vtype release];
    [_order release];
    [_vid release];
    [_bigImgUrl release];
    [_imgUrl release];
    [super dealloc];
}
@end
