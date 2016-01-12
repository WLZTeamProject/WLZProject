//
//  WLZReadWebFirstLevelModel.h
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseModel.h"
@interface WLZReadWebFirstLevelModel : WLZBaseModel
@property (nonatomic, copy) NSString *html;
@property (nonatomic, retain) NSMutableDictionary *userinfo;
@property (nonatomic, retain) NSMutableDictionary *counterList;
@property (nonatomic, retain) NSMutableDictionary *shareinfo;
@end
