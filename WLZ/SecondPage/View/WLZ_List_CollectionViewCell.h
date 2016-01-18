//
//  WLZ_List_CollectionViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RootViewDelegate <NSObject>

- (void)changeVCColor;

@end

@interface WLZ_List_CollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<RootViewDelegate> delegate;

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *titleML;

@property (nonatomic, copy) NSString *musicVisitML;

@end
