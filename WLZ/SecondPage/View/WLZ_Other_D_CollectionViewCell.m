//
//  WLZ_Other_D_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/16.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Other_D_CollectionViewCell.h"

@implementation WLZ_Other_D_CollectionViewCell
- (void)dealloc
{
    [_imageV release];
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
    self.imageV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imageV];
    self.imageV.backgroundColor = [UIColor orangeColor];
    [_imageV release];
    
}
- (void)layoutSubviews
{
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
@end
