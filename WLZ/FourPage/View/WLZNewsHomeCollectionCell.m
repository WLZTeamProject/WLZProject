//
//  WLZNewsHomeCollectionCell.m
//  WLZ
//
//  Created by lqq on 16/1/13.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZNewsHomeCollectionCell.h"

@implementation WLZNewsHomeCollectionCell

- (void)dealloc
{
    [_imageV release];
    [_briefLabel release];
    [_titleLabel release];
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
    [self createView];
    
    
}
- (void)createView
{
    self.imageV = [[UIImageView alloc] init];
    [self addSubview:self.imageV];
    
    
    self.titleLabel = [[WLZBaseLabel alloc] init];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.titleLabel];
    
    
    self.briefLabel = [[WLZBaseLabel alloc] init];
    self.briefLabel.textColor = [UIColor whiteColor];
    self.briefLabel.backgroundColor = [UIColor colorWithRed:0.7037 green:0.7037 blue:0.7037 alpha:0.507596982758621];
    self.briefLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:self.briefLabel];
    
}
- (void)layoutSubviews
{
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(self.mas_height).offset(-30);
        
    }];
    [self.briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.imageV);
        make.height.mas_equalTo(20);
        
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.imageV.mas_bottom);
        make.height.mas_equalTo(30);
    }];
}

@end
