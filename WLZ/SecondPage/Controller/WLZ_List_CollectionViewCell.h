//
//  WLZ_List_CollectionViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WLZ_List_CollectionViewCell : UICollectionViewCell

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, copy) NSMutableArray *titleML;

@property (nonatomic, copy) NSString *musicVisitML;

@end
