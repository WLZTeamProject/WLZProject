//
//  WLZ_Movies_TableViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLZ_Radios_Model.h"
#import "WLZ_PCH.pch"
@interface WLZ_Movies_TableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *RadiosImageV;

@property (nonatomic, retain) WLZBaseLabel *titleL;

@property (nonatomic, retain) WLZBaseLabel *unameL;

@property (nonatomic, retain) WLZBaseLabel *descL;

@property (nonatomic , retain) WLZ_Base_Model *model;

@end
