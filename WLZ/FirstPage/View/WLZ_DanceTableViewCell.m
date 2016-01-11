//
//  WLZ_DanceTableViewCell.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_DanceTableViewCell.h"
#define PAD ([[UIScreen mainScreen] bounds].size.height / 18)
#define WPAD ([[UIScreen mainScreen] bounds].size.width / 4)
@implementation WLZ_DanceTableViewCell

- (void)dealloc
{
    [_imageV release];
    [_titleL release];
    [_personL release];
    [_view release];
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
    self.backgroundColor = [UIColor whiteColor];
    self.imageV = [[UIImageView alloc] init];
    self.imageV.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.imageV];
    [_imageV release];
    
    //渐变
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor blackColor];
    [self.view setAlpha:0.4];
    [self.imageV addSubview:self.view];
    [_view release];
    //
    //    self.gradientLayer = [CAGradientLayer layer];
    
    
    //    self.gradientLayer.locations = @[@(0.3f), @(1.0f)];
    
    [self.view.layer addSublayer:self.gradientLayer];
    self.gradientLayer.startPoint = CGPointMake(0, 0);
    self.gradientLayer.endPoint = CGPointMake(0, 1);
    self.gradientLayer.colors = @[(id)[UIColor clearColor].CGColor, (id)[UIColor redColor].CGColor];
    self.titleL = [[UILabel alloc] init];
    self.titleL.backgroundColor = [UIColor clearColor];
    self.titleL.textColor = [UIColor whiteColor];
    [self.view addSubview:self.titleL];
    [_titleL release];
    
    self.personL = [[UILabel alloc] init];
    self.personL.backgroundColor = [UIColor clearColor];
    self.personL.textColor = [UIColor whiteColor];
    //    self.personL.font = [UIFont systemFontOfSize:self.personL.frame.size.height / 2];
    [self.view addSubview:self.personL];
    [_personL release];
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //    NSNumber *nber = ;
    //    CGFloat rightNum = self.imageV.frame.size.width / 4;
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.height.mas_equalTo(self.contentView);
        //        make.width.mas_equalTo(self.contentView);
        make.top.bottom.left.right.equalTo(self.contentView).offset(0);
        
    }];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.imageV.mas_top).offset(PAD * 5);
        make.left.right.equalTo(self.imageV).offset(0);
        make.bottom.equalTo(self.imageV.mas_bottom).offset(0);
        make.width.mas_equalTo(self.imageV);
        
    }];
    
    //    self.gradientLayer.frame = self.view.frame;
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.bottom.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(-WPAD);
        //        make.width.equalTo(self.personL)
    }];
    
    [self.personL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleL.mas_right).offset(0);
        make.right.top.equalTo(self.view).offset(0);
        make.height.mas_equalTo(self.titleL);
        
        
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
