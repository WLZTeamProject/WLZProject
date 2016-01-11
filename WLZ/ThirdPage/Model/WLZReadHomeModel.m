//
//  WLZReadHomeModel.m
//  WLZ
//
//  Created by lqq on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadHomeModel.h"

@implementation WLZReadHomeModel
- (void)dealloc
{
    [_name release];
    [_type release];
    [_enname release];
    [_coverimg release];
    [super dealloc];
}
@end
