//
//  WLZUserTableViewCell.m
//  WLZ
//
//  Created by lqq on 16/1/15.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZUserTableViewCell.h"

@implementation WLZUserTableViewCell
- (void)dealloc
{
    [_titleLabel release];
    [_nightSwitch release];
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
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel = [[WLZBaseLabel alloc] init];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel release];
    
    self.nightSwitch = [[UISwitch alloc] init];
    [self.contentView addSubview:self.nightSwitch];
    [self.nightSwitch addTarget:self action:@selector(nightSwitchAction:) forControlEvents:UIControlEventValueChanged];
    [_nightSwitch release];
    
}
- (void)nightSwitchAction:(UISwitch *)senderSwitch
{
    [self.delegate nightSwitchHandle:senderSwitch];
}
- (void)layoutSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(UIWIDTH - 200);
    }];
    [self.nightSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right);
        make.width.mas_equalTo(50);
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
