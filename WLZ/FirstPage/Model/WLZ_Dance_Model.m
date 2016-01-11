//
//  WLZ_Dance_Model.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_Model.h"

@implementation WLZ_Dance_Model
- (void)dealloc
{
    [_Title release];
    [_DanceVideoIcomUrl release];
    [super dealloc];
}
@end
