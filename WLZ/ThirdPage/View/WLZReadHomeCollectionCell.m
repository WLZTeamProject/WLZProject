//
//  WLZReadHomeCollectionCell.m
//  WLZ
//
//  Created by lqq on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadHomeCollectionCell.h"
#import "WLZBaseLabel.h"
#import <Masonry.h>

@interface WLZBaseCollectionViewCell ()
@end
@implementation WLZReadHomeCollectionCell
- (void)dealloc
{
   
    [_imageV release];
    [_nameLabel release];
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
    
    self.nameLabel = [[WLZBaseLabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.nameLabel.textColor = [UIColor whiteColor];
    self.nameLabel.backgroundColor = [UIColor colorWithRed:0.498 green:0.498 blue:0.498 alpha:1.0];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    [_nameLabel release];
    
}
- (void)layoutSubviews
{
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageV);
        make.right.equalTo(self.imageV);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.imageV);
    }];
}
@end
