//
//  WLZ_Happy_TableViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Happy_TableViewCell.h"
#import "WLZ_PCH.pch"

@implementation WLZ_Happy_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    self.pic_pathV = [UIImageView new];
    [self addSubview:self.pic_pathV];
    self.pic_pathV.layer.cornerRadius = 10;
    [self.pic_pathV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.bottom.equalTo(self).with.offset(-10);
        make.left.equalTo(self).with.offset(10);
        make.width.equalTo(self.pic_pathV.mas_height);
    }];
    self.titleLL = [WLZBaseLabel new];
    [self addSubview:self.titleLL];
    self.titleLL.font = [UIFont systemFontOfSize:18];
    [self.titleLL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self.pic_pathV.mas_right).with.offset(10);
        make.height.equalTo(@40);
        make.right.equalTo(self).with.offset(-10);
    }];
    
    self.summaryL = [WLZBaseLabel new];
    [self addSubview:self.summaryL];
//    self.summaryL.backgroundColor = [UIColor magentaColor];
    self.summaryL.font = [UIFont systemFontOfSize:14];
    [self.summaryL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLL.mas_bottom).with.offset(10);
        make.left.equalTo(self.pic_pathV.mas_right).with.offset(10);
        make.height.equalTo(@30);
        make.right.equalTo(self).with.offset(-10);
        
    }];  
}

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


@end
