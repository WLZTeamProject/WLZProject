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
@property (nonatomic, copy) NSString *item_summary;
@property (nonatomic, copy) NSString *item_catalog;
@property (nonatomic, copy) NSString *item_group;
@property (nonatomic, copy) NSString *item_group_gender;
@property (nonatomic, copy) NSString *item_product;
@property (nonatomic, copy) NSString *item_purpose;

@property (nonatomic, copy) NSString *item_suitable;
@property (nonatomic, retain) NSMutableArray *item_videos;
@property (nonatomic, retain) NSString *url;


@end
