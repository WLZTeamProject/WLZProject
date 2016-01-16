//
//  WLZUserLabelTableViewCell.m
//  WLZ
//
//  Created by lqq on 16/1/15.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZUserLabelTableViewCell.h"

@implementation WLZUserLabelTableViewCell
- (void)dealloc
{
    [_titleLabel release];
    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createSubviews];
    }
    return  self;
}
- (void)createSubviews
{
    self.backgroundColor =[UIColor clearColor];
    self.titleLabel = [[WLZBaseLabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(UIWIDTH - 100 - 60);
    }];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
