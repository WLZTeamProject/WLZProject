//
//  WLZ_Korean_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Korean_CollectionViewCell.h"

@implementation WLZ_Korean_CollectionViewCell


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
    self.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:0.400 alpha:1.000];
}

@end
