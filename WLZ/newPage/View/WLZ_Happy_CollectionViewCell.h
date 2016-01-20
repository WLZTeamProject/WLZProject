//
//  WLZ_Happy_CollectionViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLZ_News_Model;
@protocol WLZReadListHotCellDelegate <NSObject>

- (void)didSelectedHandle:(WLZ_News_Model *)model;

@end

@interface WLZ_Happy_CollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) id<WLZReadListHotCellDelegate>delegate;

@property (nonatomic, retain) NSMutableArray *detArr;

@property (nonatomic, retain) WLZ_News_Model *model;

@property (nonatomic, assign) NSInteger num;
@end
