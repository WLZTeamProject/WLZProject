//
//  WLZ_Other_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Other_CollectionViewCell.h"
#import "WLZ_PCH.pch"
#import "WLZ_Other_D_CollectionViewCell.h"
#import "WLZ_Other_Model.h"

@interface WLZ_Other_CollectionViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) UICollectionView *collectionV;

@end

@implementation WLZ_Other_CollectionViewCell

- (void)dealloc
{
    [_mainL release];
    [_mainImageV release];
    [_comfromL release];
    [_imageArr release];
    [_originalL release];
    [_originalImageV release];
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
    UILabel *mainL = [UILabel new];
    mainL.text = @"主播:";
    [self addSubview:mainL];
    
    self.mainImageV = [UIImageView new];
    self.mainImageV.layer.cornerRadius = 20;
    [self addSubview:self.mainImageV];
    
    self.mainL = [WLZBaseLabel new];
    [self addSubview:self.mainL];
    
    UILabel *originalL = [UILabel new];
    originalL.text = @"原文:";
    [self addSubview:originalL];
    
    self.originalImageV = [UIImageView new];
    self.originalImageV.layer.cornerRadius = 20;
    [self addSubview:self.originalImageV];
    
    self.originalL = [WLZBaseLabel new];
    [self addSubview:self.originalL];
    
    UILabel *comfromL = [UILabel new];
    comfromL.text = @"来自电台:";
    [self addSubview:comfromL];
    
    self.comfromL = [WLZBaseLabel new];
    [self addSubview:self.comfromL];
    
    UILabel *otherL = [UILabel new];
    otherL.text = @"主播其他作品";
    otherL.font = [UIFont systemFontOfSize:27];
    [self addSubview:otherL];
    
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
        make.width.equalTo(@300);
    }];
    
    [otherL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(comfromL.mas_bottom).with.offset(20);
        make.left.equalTo(self).with.offset((VWIDTH - 170) / 2);
        make.height.equalTo(@40);
        make.width.equalTo(@170);
        
    }];
    
    UICollectionViewFlowLayout *fwl = [[UICollectionViewFlowLayout alloc] init];
    fwl.itemSize = CGSizeMake(UIWIDTH / 3 - 10, UIWIDTH / 3 - 12);
    fwl.minimumLineSpacing = 3;
    fwl.minimumInteritemSpacing = 3;
    fwl.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fwl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionV];
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(otherL.mas_bottom).with.offset(30);
        make.bottom.equalTo(self.mas_bottom);
        
    }];
    [self.collectionV registerClass:[WLZ_Other_D_CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (0 != self.imageArr.count) {
        return self.imageArr.count;
    }
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLZ_Other_D_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WLZ_Other_Model *model = self.imageArr[indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
    return cell;
}


@end
