//
//  WLZReadWebUserInfoModel.h
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseModel.h"

@interface WLZReadWebUserInfoModel : WLZBaseModel
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *desc;
@end
