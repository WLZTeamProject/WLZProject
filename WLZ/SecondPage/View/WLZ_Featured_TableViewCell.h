//
//  WLZ_Featured_TableViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WLZ_Featured_TableViewCellDelegate <NSObject>

- (void)exchange1;
- (void)exchange2;
- (void)exchange3;


@end

@interface WLZ_Featured_TableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *newImageV;

@property (nonatomic, retain) UIImageView *earlyImageV;

@property (nonatomic, retain) UIImageView *nightImageV;

@property (nonatomic, assign) id<WLZ_Featured_TableViewCellDelegate> delegate;

@end
