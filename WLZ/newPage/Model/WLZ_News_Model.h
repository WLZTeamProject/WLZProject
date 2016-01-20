//
//  WLZ_News_Model.h
//  WLZ
//
//  Created by 왕닝 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseModel.h"

@interface WLZ_News_Model : WLZBaseModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *pic_path;

@property (nonatomic, copy) NSString *sourceWebUrl;

@end
