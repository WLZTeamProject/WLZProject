//
//  WLZ_Happy_No_TableViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Happy_No_TableViewCell.h"
#import "WLZ_PCH.pch"

@implementation WLZ_Happy_No_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    self.titleLL = [WLZBaseLabel new];
    [self addSubview:self.titleLL];
//    self.titleLL.backgroundColor = [UIColor magentaColor];
    self.titleLL.font = [UIFont systemFontOfSize:18];
    
    self.summaryL = [WLZBaseLabel new];
    [self addSubview:self.summaryL];
    self.summaryL.font = [UIFont systemFontOfSize:14];
//    self.summaryL.backgroundColor = [UIColor magentaColor];

}

- (void)layoutSubviews
{
    [self.titleLL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.height.equalTo(@40);
        make.right.equalTo(self).with.offset(-10);
    }];
    
        [self.summaryL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLL.mas_bottom).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.height.equalTo(@30);
        make.right.equalTo(self).with.offset(-10);
        
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
