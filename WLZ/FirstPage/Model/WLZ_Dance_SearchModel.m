//
//  WLZ_Dance_SearchModel.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_SearchModel.h"

@implementation WLZ_Dance_SearchModel
- (void)dealloc
{
    [_searchArr release];
    [super dealloc];
}

+ (instancetype)shareData
{
    static WLZ_Dance_SearchModel *newArr = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        newArr = [[WLZ_Dance_SearchModel alloc] init];
    });
    return newArr;
}
@end
