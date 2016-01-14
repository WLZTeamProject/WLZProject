//
//  WLZ_Dance_relateTableViewCell.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_relateTableViewCell.h"
#import <Masonry.h>
@implementation WLZ_Dance_relateTableViewCell

- (void)dealloc
{
    [_imageV release];
    [_catalogL release];
    [_clickL release];
    [_titleL release];
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
    self.backgroundColor = [UIColor clearColor];
    self.imageV = [[UIImageView alloc] init];
//    self.imageV.backgroundColor = [UIColor magentaColor];
    [self.contentView addSubview:self.imageV];
    self.titleL = [[UILabel alloc] init];
    self.titleL.numberOfLines = 0;
    
//    self.titleL.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.titleL];
    self.catalogL = [[UILabel alloc] init];
//    self.catalogL.backgroundColor = [UIColor purpleColor];
    [self.contentView addSubview:self.catalogL];

}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.titleL.mas_left).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
        
        
    }];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.equalTo(self.imageV.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.width.mas_equalTo(self.imageV.mas_width);
        make.bottom.equalTo(self.catalogL.mas_top).offset(0);
        
    }];
    
    [self.catalogL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.titleL.mas_bottom).offset(0);
        make.left.equalTo(self.imageV.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(self.titleL.mas_height);
        
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
