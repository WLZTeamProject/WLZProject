//
//  DanceModel+CoreDataProperties.h
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/20.
//  Copyright © 2016年 lwz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DanceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DanceModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *item_id;
@property (nullable, nonatomic, retain) NSString *item_title;
@property (nullable, nonatomic, retain) NSString *item_image;
@property (nullable, nonatomic, retain) NSString *item_videos;
@property (nullable, nonatomic, retain) NSString *item_click;
@property (nullable, nonatomic, retain) NSString *item_summary;
@property (nullable, nonatomic, retain) NSString *item_catalog;
@property (nullable, nonatomic, retain) NSString *item_group;
@property (nullable, nonatomic, retain) NSString *item_group_gender;
@property (nullable, nonatomic, retain) NSString *item_product;
@property (nullable, nonatomic, retain) NSString *item_suitable;
@property (nullable, nonatomic, retain) NSString *url;

@end

NS_ASSUME_NONNULL_END
