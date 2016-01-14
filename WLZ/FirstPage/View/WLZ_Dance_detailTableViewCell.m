//
//  WLZ_Dance_detailTableViewCell.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_detailTableViewCell.h"

@implementation WLZ_Dance_detailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews
{
    self.backgroundColor = [UIColor grayColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
