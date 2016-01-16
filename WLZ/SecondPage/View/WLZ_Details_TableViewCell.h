//
//  WLZ_Details_TableViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLZ_Details_Model.h"
#import "WLZ_PCH.pch"
@interface WLZ_Details_TableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *coverimgImageV;

@property (nonatomic, retain) WLZBaseLabel *titleL;

@property (nonatomic, retain) WLZBaseLabel *musicVisitL;

@property (nonatomic , retain) WLZ_Details_Model *model;


@end
