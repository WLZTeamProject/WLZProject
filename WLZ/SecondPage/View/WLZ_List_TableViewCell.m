//
//  WLZ_List_TableViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_List_TableViewCell.h"

@implementation WLZ_List_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews
{
    self.titleL = [UILabel new];
//        self.titleL.backgroundColor = [UIColor magentaColor];
    [self addSubview:self.titleL];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self).with.offset(10);
        make.height.equalTo(@30);
        make.width.equalTo(@(VWIDTH - 50));
        
    }];
    
    self.musicVisitL = [UILabel new];
//    self.musicVisitL.backgroundColor = [UIColor redColor];
    [self addSubview:self.musicVisitL];
    [self.musicVisitL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-10);
        make.left.equalTo(self).with.offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@(VWIDTH - 50));
        
    }];
    

    UIImageView *imageV = [UIImageView new];
    [self addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"xiazai"];
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.bottom.equalTo(self).with.offset(- 20);
        make.right.equalTo(self).with.offset(-10);
        make.width.equalTo(imageV.mas_height);
        
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