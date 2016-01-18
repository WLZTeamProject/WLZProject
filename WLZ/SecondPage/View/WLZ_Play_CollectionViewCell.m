//
//  WLZ_Play_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Play_CollectionViewCell.h"
#import "WLZ_PCH.pch"
@implementation WLZ_Play_CollectionViewCell

- (void)dealloc
{
    [_headImageV release];
    [_titleL release];
    [_slider release];
    [_link release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews
{
    self.headImageV = [UIImageView new];
    self.headImageV.layer.cornerRadius = (VHEIGHT - 60) / 4;
    self.headImageV.layer.masksToBounds = YES;


    [self addSubview:self.headImageV];
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(30);
        make.right.equalTo(self).with.offset(-30);
        make.top.equalTo(self).with.offset(30);
        make.height.equalTo(self.headImageV.mas_width);
        
    }];
    
    self.titleL = [WLZBaseLabel new];
    self.titleL.textAlignment = NSTextAlignmentCenter;
    self.titleL.text = @"ddd";
    [self addSubview:self.titleL];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.equalTo(self.headImageV.mas_bottom).with.offset(50);
        make.left.equalTo(self);
        make.height.equalTo(@50);
        make.width.equalTo(@(VWIDTH));
    }];
    
    self.slider = [UISlider new];
//    self.slider.value = 0.3;
    [self.slider addTarget:self action:@selector(volAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.slider];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL).with.offset(80);
        make.left.equalTo(@100);
        make.width.equalTo(@(VWIDTH - 200));
        
    }];
    

}
- (void)volAction:(UISlider *)sender
{
    [self.delegate exchangeVol:self.slider.value];
    
    
}

@end
