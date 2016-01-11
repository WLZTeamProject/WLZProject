//
//  WLZ_Radios_Model.h
//  WLZ
//
//  Created by 왕닝 on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Base_Model.h"

@interface WLZ_Radios_Model : WLZ_Base_Model

@property (nonatomic, copy) NSString *radioid;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *coverimg;

@property (nonatomic, retain) NSMutableDictionary *userinfo;

@property (nonatomic, copy) NSString *desc;

@end
