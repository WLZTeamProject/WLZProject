//
//  WLZ_Movies_TableViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Movies_TableViewCell.h"
#import "Masonry.h"
#define PAD 10
@implementation WLZ_Movies_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
//    self.backgroundColor = [UIColor yellowColor];
    self.RadiosImageV = [UIImageView new];
    self.RadiosImageV.layer.cornerRadius = 10;
    self.RadiosImageV.image = [UIImage imageNamed:@"kafei"];
//    self.RadiosImageV.backgroundColor = [UIColor blueColor];
    [self addSubview:self.RadiosImageV];
    
    [self.RadiosImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(PAD);
        make.bottom.equalTo(self).with.offset(-PAD);
        make.left.equalTo(@10);
        make.width.equalTo(@80);
    }];
    
    self.titleL = [UILabel new];
//    self.titleL.backgroundColor = [UIColor magentaColor];
    [self addSubview:self.titleL];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(PAD);
        make.left.equalTo(self.RadiosImageV.mas_right).with.offset(PAD);
        make.right.equalTo(self).with.offset(-PAD);
        make.height.equalTo(@30);
        
    }];
    
    self.unameL = [UILabel new];
//    self.unameL.backgroundColor = [UIColor redColor];
    [self addSubview:self.unameL];
    
    [self.unameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom);
        make.left.equalTo(self.RadiosImageV.mas_right).with.offset(PAD);
        make.right.equalTo(self).with.offset(-PAD);
        make.height.equalTo(@25);
        
    }];
    
    self.descL = [UILabel new];
//    self.descL.backgroundColor = [UIColor blueColor];
    [self addSubview:self.descL];
    
    [self.descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.unameL.mas_bottom);
        make.left.equalTo(self.RadiosImageV.mas_right).with.offset(PAD);
        make.right.equalTo(self).with.offset(-PAD);
        make.height.equalTo(@25);
        
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
