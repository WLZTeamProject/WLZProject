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
#import <MBProgressHUD.h>
#import "WLZReadHomeModel.h"
#import "WLZReadHomeCarouselModel.h"
#import "WLZReadHomeCollectionCell.h"
#import <UIImageView+WebCache.h>
#import <SDCycleScrollView.h>
#import "WLZReadHeadCycleView.h"
#import "WLZReadWebViewController.h"
#import "WLZReadListViewController.h"
@interface WLZReadRootViewController () <UICollectionViewDelegate, UICollectionViewDataSource, SDCycleScrollViewDelegate>
@property (nonatomic, retain) WLZBaseCollectionView *collectionV;
@property (nonatomic, retain) NSMutableArray *listArr;
@property (nonatomic, retain) NSMutableArray *carouselArr;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) SDCycleScrollView *cycleSV;
@end

@implementation WLZReadRootViewController
- (void)dealloc
{
    [_hud release];
    [_cycleSV release];
    [_listArr release];
    [_carouselArr release];
    [_collectionV release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubviews];
    [self createData];
    
}
#pragma 创建视图
-(void)createSubviews
{
    [self createCollectionView];
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
}

#pragma 获取数据
- (void)createData
{
    self.listArr = [NSMutableArray array];
    self.carouselArr = [NSMutableArray array];
    [LQQAFNetTool getNetWithURL:READHOMEURL body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *tempListArr = [dic objectForKey:@"list"];
        for (NSMutableDictionary *tempDic in tempListArr) {
            WLZReadHomeModel *model = [WLZReadHomeModel baseModelWithDic:tempDic];
            [self.listArr addObject:model];
        }
        NSMutableArray *tempCarouselArr = [dic objectForKey:@"carousel"];
        for (NSMutableDictionary *tempDic in tempCarouselArr) {
            WLZReadHomeCarouselModel *model = [WLZReadHomeCarouselModel baseModelWithDic:tempDic];
            [self.carouselArr addObject:model];
        }
        if (self.listArr.count != 0) {
            [self.collectionV reloadData];
            [self.hud removeFromSuperview];
            [self.hud release];
            self.hud = nil;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma 创建collectionView
- (void)createCollectionView
{
    self.navigationItem.title = @"阅读";
    UICollectionViewFlowLayout *fwl = [[UICollectionViewFlowLayout alloc] init];
    fwl.itemSize = CGSizeMake(UIWIDTH / 3 - 10, UIWIDTH / 3 - 12);
    fwl.headerReferenceSize = CGSizeMake(UIWIDTH, UIWIDTH / 3 * 2 - 15 - 20);
    fwl.minimumLineSpacing = 3;
    fwl.minimumInteritemSpacing = 3;
    fwl.sectionInset = UIEdgeInsetsMake(0, 8, 0, 8);
    self.collectionV = [[WLZBaseCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fwl];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    [self.view addSubview:self.collectionV];
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        
    }];
    [self.collectionV registerClass:[WLZReadHomeCollectionCell class] forCellWithReuseIdentifier:@"cell"];
#pragma 注册头视图
    [self.collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
}
#pragma 定义collectionView头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //判断是否设置头视图
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        NSMutableArray *arr = [NSMutableArray array];
        for (WLZReadHomeCarouselModel *model in self.carouselArr) {
            [arr addObject:model.img];
        }
        self.cycleSV = [[SDCycleScrollView alloc] init];
        self.cycleSV.delegate = self;
        self.cycleSV.placeholderImage = [UIImage imageNamed:@"kafei"];
        self.cycleSV.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        self.cycleSV.imageURLStringsGroup = arr;
        [view addSubview:self.cycleSV];
        
        
        [self.cycleSV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(UIWIDTH - 16);
            make.height.mas_equalTo(UIWIDTH / 3 * 2 - 40);
            make.top.equalTo(self.collectionV.mas_top);
            make.left.equalTo(self.collectionV.mas_left).offset(8);
        }];
        
        return view;
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLZReadHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    WLZReadHomeModel *model = [self.listArr objectAtIndex:indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"kafei"]];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@%@", model.name, model.enname];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLZReadHomeModel *model = [self.listArr objectAtIndex:indexPath.row];
    WLZReadListViewController *listVC = [[WLZReadListViewController alloc] init];
    listVC.typle = model.type;
    listVC.name = model.name;
    [self.navigationController pushViewController:listVC animated:YES];
    [listVC release];
    
}
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    WLZReadHomeCarouselModel *carouselModel = [self.carouselArr objectAtIndex:index];
    
    WLZReadWebViewController *webVC = [[WLZReadWebViewController alloc] init];
    webVC.mId = [carouselModel.url substringFromIndex:17];
//    NSLog(@"%@", webVC.mId);
    [self.navigationController pushViewController:webVC animated:YES];
    [webVC release];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

}

@end
