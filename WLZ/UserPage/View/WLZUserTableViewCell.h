//
//  WLZUserTableViewCell.h
//  WLZ
//
//  Created by lqq on 16/1/15.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLZBaseLabel.h"

@protocol WLZUserTableViewCellDelegate <NSObject>

- (void)nightSwitchHandle:(UISwitch *)senderSwitch;

@end
@interface WLZUserTableViewCell : UITableViewCell
@property (nonatomic, assign) id<WLZUserTableViewCellDelegate>delegate;
@property (nonatomic, retain) WLZBaseLabel *titleLabel;
@property (nonatomic, retain) UISwitch *nightSwitch;
@end
