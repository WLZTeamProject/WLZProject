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
//        self.headImageV.backgroundColor = [UIColor yellowColor];
    
//    self.headImageV.image = [UIImage imageNamed:@"kafei"];
    
    self.headImageV.layer.cornerRadius = (VHEIGHT - 60) / 4;
    [self addSubview:self.headImageV];
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(30);
        make.right.equalTo(self).with.offset(-30);
        make.top.equalTo(self).with.offset(30);
        make.height.equalTo(self.headImageV.mas_width);
        
    }];
    
    self.titleL = [UILabel new];
    self.titleL.textAlignment = NSTextAlignmentCenter;
//    self.titleL.backgroundColor = [UIColor redColor];
    self.titleL.text = @"ddd";
    [self addSubview:self.titleL];
    
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.top.equalTo(self.headImageV.mas_bottom).with.offset(50);
//        make.center.equalTo(self);
        make.left.equalTo(self);
        make.height.equalTo(@50);
        make.width.equalTo(@(VWIDTH));
    }];
    
    self.slider = [UISlider new];
    [self addSubview:self.slider];
    
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleL).with.offset(80);
        make.left.equalTo(@100);
        make.width.equalTo(@(VWIDTH - 200));
        
    }];
    

}

@end
