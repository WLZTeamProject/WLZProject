//
//  WLZReadListHotCell.h
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseCollectionViewCell.h"

@class WLZReadListModel;
@protocol WLZReadListHotCellDelegate <NSObject>

- (void)didSelectedHandle:(WLZReadListModel *)model;

@end
@interface WLZReadListHotCell : WLZBaseCollectionViewCell
@property (nonatomic, assign) id<WLZReadListHotCellDelegate>delegate;
@property (nonatomic, copy) NSString *typleId;
@property (nonatomic, copy) NSString *sort;
@end
