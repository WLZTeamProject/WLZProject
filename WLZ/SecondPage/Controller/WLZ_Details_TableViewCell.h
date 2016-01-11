//
//  WLZ_Details_TableViewCell.h
//  WLZ
//
//  Created by 왕닝 on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLZ_Details_Model.h"

@interface WLZ_Details_TableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *coverimgImageV;

@property (nonatomic, retain) UILabel *titleL;

@property (nonatomic, retain) UILabel *musicVisitL;

@property (nonatomic , retain) WLZ_Details_Model *model;


@end
