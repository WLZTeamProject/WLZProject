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
    self.userInteractionEnabled = YES;
//    self.contentView.userInteractionEnabled = NO;
    self.newImageV = [UIImageView new];
    self.newImageV.layer.cornerRadius = 10;
    self.newImageV.tag = 1000;
    self.newImageV.image = [UIImage imageNamed:@"kafei"];
    [self addSubview:self.newImageV];
    
    self.earlyImageV = [UIImageView new];
    self.earlyImageV.layer.cornerRadius = 10;
    self.earlyImageV.tag = 1001;
    self.earlyImageV.image = [UIImage imageNamed:@"kafei"];
    [self addSubview:self.earlyImageV];
    
    self.nightImageV = [UIImageView new];
    self.nightImageV.layer.cornerRadius = 10;
    self.nightImageV.tag = 1002;
    self.nightImageV.image = [UIImage imageNamed:@"kafei"];
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
    
    //轻拍手势
    UITapGestureRecognizer *tapGR1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction1:)];
    //为某一视图添加手势
    self.newImageV.userInteractionEnabled = YES;
    [self.newImageV addGestureRecognizer:tapGR1];
    [tapGR1 release];
    
    //轻拍手势
    UITapGestureRecognizer *tapGR2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction2:)];
    //为某一视图添加手势
    self.earlyImageV.userInteractionEnabled = YES;

    [self.earlyImageV addGestureRecognizer:tapGR2];
    [tapGR2 release];
    
    //轻拍手势
    UITapGestureRecognizer *tapGR3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction3:)];
    //为某一视图添加手势
    self.nightImageV.userInteractionEnabled = YES;
    [self.nightImageV addGestureRecognizer:tapGR3];
    [tapGR3 release];
    

}
- (void)tapAction1:(UITapGestureRecognizer *)sender
{
    [self.delegate exchange1];
}
- (void)tapAction2:(UITapGestureRecognizer *)sender
{
    [self.delegate exchange2];
    
}
- (void)tapAction3:(UITapGestureRecognizer *)sender
{
    [self.delegate exchange3];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
        self.contentView.backgroundColor = [UIColor blackColor];
    } else {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
