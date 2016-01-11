//
//  WLZ_Featured_TableViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Featured_TableViewCell.h"
#import "WLZ_PCH.pch"

@implementation WLZ_Featured_TableViewCell

- (void)dealloc
{
    [_newImageV release];
    [_earlyImageV release];
    [_nightImageV release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubView];
    }
    return self;
}

- (void)creatSubView
{
    self.newImageV = [UIImageView new];
//    self.newImageV.backgroundColor = [UIColor yellowColor];
    self.newImageV.image = [UIImage imageNamed:@"kafei"];
    self.newImageV.layer.cornerRadius = 10;
    [self addSubview:self.newImageV];
    
    self.earlyImageV = [UIImageView new];
//    self.earlyImageV.backgroundColor = [UIColor magentaColor];
    self.earlyImageV.image = [UIImage imageNamed:@"kafei"];
    self.earlyImageV.layer.cornerRadius = 10;
    [self addSubview:self.earlyImageV];
    
    self.nightImageV = [UIImageView new];
//    self.nightImageV.backgroundColor = [UIColor orangeColor];
    self.nightImageV.image = [UIImage imageNamed:@"kafei"];
    self.nightImageV.layer.cornerRadius = 10;
    [self addSubview:self.nightImageV];
    
    [self.newImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self.earlyImageV.mas_left).with.offset(-10);
        make.height.mas_equalTo(self.newImageV.mas_width);
        make.width.mas_equalTo(@[self.earlyImageV, self.nightImageV]);
        
    }];
    
    [self.earlyImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self.newImageV);
        make.width.equalTo(@[self.newImageV, self.nightImageV]);
        
    }];
    
    [self.nightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.equalTo(self.earlyImageV.mas_right).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.mas_equalTo(self.newImageV);
        make.width.mas_equalTo(@[self.newImageV, self.earlyImageV]);
        
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
