//
//  WLZ_Other_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Other_CollectionViewCell.h"
#import "WLZ_PCH.pch"
@implementation WLZ_Other_CollectionViewCell

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
    UILabel *mainL = [UILabel new];
    mainL.text = @"主播:";
//    mainL.backgroundColor = [UIColor blueColor];
    [self addSubview:mainL];
    
    self.mainImageV = [UIImageView new];
//    self.mainImageV.backgroundColor = [UIColor orangeColor];
    self.mainImageV.layer.cornerRadius = 20;
    [self addSubview:self.mainImageV];
    
    self.mainL = [UILabel new];
//    self.mainL.backgroundColor = [UIColor blueColor];
    [self addSubview:self.mainL];
    
    UILabel *originalL = [UILabel new];
    originalL.text = @"原文:";
//    originalL.backgroundColor = [UIColor blueColor];
    [self addSubview:originalL];
    
    self.originalImageV = [UIImageView new];
//    self.originalImageV.backgroundColor = [UIColor orangeColor];
    self.originalImageV.layer.cornerRadius = 20;
    [self addSubview:self.originalImageV];
    
    self.originalL = [UILabel new];
//    self.originalL.backgroundColor = [UIColor blueColor];
    [self addSubview:self.originalL];
    
    UILabel *comfromL = [UILabel new];
    comfromL.text = @"来自电台:";
//    comfromL.backgroundColor = [UIColor blueColor];
    [self addSubview:comfromL];
    
    self.comfromL = [UILabel new];
//    self.comfromL.backgroundColor = [UIColor blueColor];
    [self addSubview:self.comfromL];
    
    UILabel *otherL = [UILabel new];
    otherL.text = @"主播其他作品";
    otherL.font = [UIFont systemFontOfSize:27];
    otherL.backgroundColor = [UIColor blueColor];
    [self addSubview:otherL];
    
    self.imageOne = [UIImageView new];
    self.imageOne.layer.cornerRadius = 10;
    self.imageOne.backgroundColor = [UIColor redColor];
    [self addSubview:self.imageOne];
    
    self.imageTwo = [UIImageView new];
    self.imageTwo.layer.cornerRadius = 10;
    self.imageTwo.backgroundColor = [UIColor greenColor];
    [self addSubview:self.imageTwo];
    
    self.imageThree = [UIImageView new];
    self.imageThree.layer.cornerRadius = 10;
    self.imageThree.backgroundColor = [UIColor blueColor];
    [self addSubview:self.imageThree];
    
    self.imageFore = [UIImageView new];
    self.imageFore.layer.cornerRadius = 10;
    self.imageFore.backgroundColor = [UIColor redColor];
    [self addSubview:self.imageFore];
    
    self.imageFive = [UIImageView new];
    self.imageFive.layer.cornerRadius = 10;
    self.imageFive.backgroundColor = [UIColor greenColor];
    [self addSubview:self.imageFive];
    
    self.imageSix = [UIImageView new];
    self.imageSix.layer.cornerRadius = 10;
    self.imageSix.backgroundColor = [UIColor blueColor];
    [self addSubview:self.imageSix];
    
    [mainL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(30);
        make.left.equalTo(self).with.offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
        
    }];
    
    [self.mainImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.left.equalTo(mainL.mas_right).with.offset(20);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        
    }];
    
    [self.mainL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(30);
        make.left.equalTo(self.mainImageV.mas_right).with.offset(20);
        make.height.equalTo(@20);
        make.width.equalTo(@200);
        
    }];
    
    [originalL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainL.mas_bottom).with.offset(30);
        make.left.equalTo(self).with.offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
        
    }];
    
    [self.originalImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainImageV.mas_bottom).with.offset(10);
        make.left.equalTo(originalL.mas_right).with.offset(20);
        make.height.equalTo(@40);
        make.width.equalTo(@40);
        
    }];
    
    [self.originalL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainL.mas_bottom).with.offset(30);
        make.left.equalTo(self.originalImageV.mas_right).with.offset(20);
        make.height.equalTo(@20);
        make.width.equalTo(@200);
        
    }];
    
    [comfromL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(originalL.mas_bottom).with.offset(30);
        make.left.equalTo(self).with.offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@80);
        
    }];
    
    [self.comfromL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(originalL.mas_bottom).with.offset(30);
        make.left.equalTo(comfromL.mas_right).with.offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    
    [otherL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(comfromL.mas_bottom).with.offset(20);
        make.left.equalTo(self).with.offset((VWIDTH - 170) / 2);
        make.height.equalTo(@40);
        make.width.equalTo(@170);
        
    }];
    
    [self.imageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(otherL.mas_bottom).with.offset(20);
        make.left.equalTo(self).with.offset(20);
        make.right.equalTo(self.imageTwo.mas_left).with.offset(-10);
        make.height.mas_equalTo(self.imageOne.mas_width);
        make.width.mas_equalTo(@[self.imageTwo, self.imageThree]);

        
    }];
    
    [self.imageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(otherL.mas_bottom).with.offset(20);
//        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(self.imageOne);
        make.width.equalTo(@[self.imageOne, self.imageThree]);
        
    }];

    [self.imageThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(otherL.mas_bottom).with.offset(20);
//        make.centerY.mas_equalTo(self);
        make.left.equalTo(self.imageTwo.mas_right).with.offset(10);
        make.right.equalTo(self).with.offset(-20);
        make.height.mas_equalTo(self.imageOne);
        make.width.mas_equalTo(@[self.imageOne, self.imageThree]);
        
    }];
    
    [self.imageFore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageOne.mas_bottom).with.offset(20);
        make.left.equalTo(self).with.offset(20);
        make.right.equalTo(self.imageFive.mas_left).with.offset(-10);
        make.height.mas_equalTo(self.imageFore.mas_width);
        make.width.mas_equalTo(@[self.imageFive, self.imageSix]);
        
        
    }];
    
    [self.imageFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageTwo.mas_bottom).with.offset(20);
        make.height.mas_equalTo(self.imageFore);
        make.width.equalTo(@[self.imageFore, self.imageSix]);
        
    }];
    
    [self.imageSix mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageThree.mas_bottom).with.offset(20);
        make.left.equalTo(self.imageFive.mas_right).with.offset(10);
        make.right.equalTo(self).with.offset(-20);
        make.height.mas_equalTo(self.imageFore);
        make.width.mas_equalTo(@[self.imageFore, self.imageSix]);
        
    }];


}

@end
