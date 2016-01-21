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

- (void)dealloc
{
    [_titleL release];
    [_model release];
    [_descL release];
    [_unameL release];
    [_RadiosImageV release];
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
    self.RadiosImageV = [UIImageView new];
    self.RadiosImageV.layer.cornerRadius = 10;
    self.RadiosImageV.image = [UIImage imageNamed:@"kafei"];
    [self addSubview:self.RadiosImageV];
    
    [self.RadiosImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(PAD);
        make.bottom.equalTo(self).with.offset(-PAD);
        make.left.equalTo(@10);
        make.width.equalTo(@80);
    }];
    
    self.titleL = [WLZBaseLabel new];
    [self addSubview:self.titleL];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(PAD);
        make.left.equalTo(self.RadiosImageV.mas_right).with.offset(PAD);
        make.right.equalTo(self).with.offset(-PAD);
        make.height.equalTo(@30);
        
    }];
    
    self.unameL = [WLZBaseLabel new];
    [self addSubview:self.unameL];
    
    [self.unameL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL.mas_bottom);
        make.left.equalTo(self.RadiosImageV.mas_right).with.offset(PAD);
        make.right.equalTo(self).with.offset(-PAD);
        make.height.equalTo(@25);
        
    }];
    
    self.descL = [WLZBaseLabel new];
    [self addSubview:self.descL];
    
    [self.descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.unameL.mas_bottom);
        make.left.equalTo(self.RadiosImageV.mas_right).with.offset(PAD);
        make.right.equalTo(self).with.offset(-PAD);
        make.height.equalTo(@25);
        
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationNightAction) name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationDayAction) name:@"day" object:nil];
    
}
- (void)notificationNightAction
{
    self.contentView.backgroundColor = [UIColor blackColor];
}
- (void)notificationDayAction
{
    self.contentView.backgroundColor = [UIColor whiteColor];
}

//- (void)layoutSubviews
//{
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
//        self.contentView.backgroundColor = [UIColor blackColor];
//    } else {
//        self.contentView.backgroundColor = [UIColor whiteColor];
//    }
//}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
