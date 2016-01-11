//
//  WLZBaseCollectionView.m
//  WLZ
//
//  Created by lqq on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseCollectionView.h"

@implementation WLZBaseCollectionView



- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self =[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self createSubviews];
    }
    return self;
}
- (void)createSubviews
{
    self.backgroundColor = [UIColor whiteColor];
}
@end
