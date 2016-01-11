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
    
    

}

@end
