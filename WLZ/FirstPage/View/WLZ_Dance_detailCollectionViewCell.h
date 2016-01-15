//
//  WLZ_Dance_detailCollectionViewCell.h
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/13.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WLZ_Dance_ListModel;
@protocol WLZ_Dance_detailCollectionViewCellDelegate <NSObject>

- (void)transferValue:(WLZ_Dance_ListModel *)wlzdance;
@end

@interface WLZ_Dance_detailCollectionViewCell : UICollectionViewCell
@property (nonatomic, retain) id <WLZ_Dance_detailCollectionViewCellDelegate> delegate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSMutableArray *arr;
- (void)setArr:(NSMutableArray *)arr;
- (void)setTitle:(NSString *)title;
@end
