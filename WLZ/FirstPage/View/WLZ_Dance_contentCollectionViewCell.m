//
//  WLZ_Dance_contentCollectionViewCell.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_contentCollectionViewCell.h"

@implementation WLZ_Dance_contentCollectionViewCell

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
    self.backgroundColor = [UIColor grayColor];
}

@end
