//
//  WLZReadHeadCycleView.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadHeadCycleView.h"
#import <SDCycleScrollView.h>
#import <Masonry.h>
#import "WLZReadHomeCarouselModel.h"
@interface WLZReadHeadCycleView  () <SDCycleScrollViewDelegate>

@property (nonatomic, retain) SDCycleScrollView *cycleView;
@end


@implementation WLZReadHeadCycleView

- (void)dealloc
{
    [_picArr release];
    [_cycleView release];
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
    self.backgroundColor =[UIColor yellowColor];
    NSMutableArray *arr = [NSMutableArray array];
    for (WLZReadHomeCarouselModel *model in self.picArr) {
        [arr addObject:model.img];
    }
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:arr];
    self.cycleView.delegate = self;
    [self addSubview:self.cycleView];
    
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.width.mas_equalTo(UIWIDTH);
        make.height.mas_equalTo(UIWIDTH / 3 * 2);
    }];
    
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    
    
}
@end
