//
//  WLZNewTableViewCell.h
//  WLZ
//
//  Created by lqq on 16/1/12.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLZNewFirstModel;
@protocol WLZNewTableViewCellDelegate <NSObject>

- (void)tableViewCellHandle:(WLZNewFirstModel *)model;

@end
@interface WLZNewTableViewCell : UITableViewCell
@property (nonatomic, assign) id<WLZNewTableViewCellDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *newsArr;
@end
