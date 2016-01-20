//
//  WLZ_Dance_SearchModel.h
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseModel.h"

@interface WLZ_Dance_SearchModel : WLZBaseModel
@property (nonatomic, retain) NSMutableArray *searchArr;

+ (instancetype)shareData;

@end
