//
//  WLZ_Dance_ListModel.h
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseModel.h"

@interface WLZ_Dance_ListModel : WLZBaseModel
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSString *item_title;
@property (nonatomic, copy) NSString *item_image;
//@property (nonatomic, copy) NSString *item_videos;
//观看人数
@property (nonatomic, retain) NSNumber *item_click;
@end
