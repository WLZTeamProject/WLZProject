//
//  WLZReadRootViewController.m
//  WLZ
//
//  Created by lqq on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadRootViewController.h"
#import "WLZBaseCollectionView.h"
#import "LQQAFNetTool.h"
#import <Masonry.h>
@interface WLZReadRootViewController ()
@property (nonatomic, retain) WLZBaseCollectionView *collectionV;
@end

@implementation WLZReadRootViewController
- (void)dealloc
{
    [_collectionV release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubviews];
    
    
}
#pragma 创建视图
-(void)createSubviews
{
    [self createCollectionView];
    [self createData];
}
#pragma 获取数据
- (void)createData
{
    
    
    
}

#pragma 创建collectionView
- (void)createCollectionView
{
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
