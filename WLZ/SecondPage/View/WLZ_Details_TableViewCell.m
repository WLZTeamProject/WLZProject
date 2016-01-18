//
//  WLZ_Details_TableViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Details_TableViewCell.h"

@implementation WLZ_Details_TableViewCell

- (void)dealloc
{
    [_coverimgImageV release];
    [_titleL release];
    [_musicVisitL release];
    [_model release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    self.coverimgImageV = [UIImageView new];
    self.coverimgImageV.layer.cornerRadius = 10;
    self.coverimgImageV.image = [UIImage imageNamed:@"kafei"];
    [self addSubview:self.coverimgImageV];
    
    [self.coverimgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.bottom.equalTo(self).with.offset(-10);
        make.left.equalTo(@10);
        make.width.equalTo(@60);
    }];
    
    self.titleL = [WLZBaseLabel new];
    [self addSubview:self.titleL];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self.coverimgImageV.mas_right).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.equalTo(@30);
        
    }];
    
    self.musicVisitL = [WLZBaseLabel new];
    [self addSubview:self.musicVisitL];
    [self.musicVisitL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-10);
        make.left.equalTo(self.coverimgImageV.mas_right).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.height.equalTo(@20);
        
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
