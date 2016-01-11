//
//  WLZReadTableViewCell.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadTableViewCell.h"
@interface WLZReadTableViewCell ()

@end
@implementation WLZReadTableViewCell
- (void)dealloc
{
   
    [_imageV release];
    [_nameLabel release];
    [_contentLabel release];
    [super dealloc];
}

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
    self.nameLabel = [[WLZBaseLabel alloc] init];
    self.nameLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.contentView addSubview:self.nameLabel];
    [_nameLabel release];
    
    self.imageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageV];
    [_imageV release];
    
    self.contentLabel = [[WLZBaseLabel alloc] init];
    self.contentLabel.numberOfLines = 3;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.contentLabel];
    [_contentLabel release];
    
}
//height 100;
- (void)layoutSubviews
{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(30);
    }];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom);
        make.left.equalTo(self.contentView).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(60);
        
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageV);
        make.left.equalTo(self.imageV.mas_right).offset(5);
        make.right.equalTo(self.contentView).offset(-10);
        make.height.equalTo(self.imageV);
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
