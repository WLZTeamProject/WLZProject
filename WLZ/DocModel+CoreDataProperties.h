//
//  DocModel+CoreDataProperties.h
//  WLZ
//
//  Created by lqq on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DocModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DocModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *mid;
@property (nullable, nonatomic, retain) NSString *html;

@end

NS_ASSUME_NONNULL_END
