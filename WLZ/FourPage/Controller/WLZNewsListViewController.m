//
//  WLZNewsListViewController.m
//  WLZ
//
//  Created by lqq on 16/1/13.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZNewsListViewController.h"
#import "WLZNewFirstModel.h"
#import "LQQAFNetTool.h"
#import <MBProgressHUD.h>
#import "WLZNewsHomeCollectionCell.h"
#import <UIImageView+WebCache.h>
#import "WLZNewsDetailViewController.h"
@interface WLZNewsListViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) MBProgressHUD *hub;
@property (nonatomic, retain) UICollectionView *collectView;


@property (nonatomic, retain) NSMutableArray *itemListArr;

@end

@implementation WLZNewsListViewController
- (void)dealloc
{
    [_itemListArr release];
    [_collectView release];
    [_url release];
    [_mytitle release];
    [_hub release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubviews];
    [self createData];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;

}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createSubviews
{
    [self createCollectionView];
    self.navigationItem.title = self.mytitle;
    self.hub = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hub];
    [self.hub show:YES];
    
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
}
- (void)createData
{
    self.itemListArr = [NSMutableArray array];
    [LQQAFNetTool getNetWithURL:self.url body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"itemList"];
        for (NSMutableDictionary *tempDic in arr) {
            WLZNewFirstModel *model = [WLZNewFirstModel baseModelWithDic:tempDic];
            [self.itemListArr addObject:model];
        }
        if (self.itemListArr) {
            [self.collectView reloadData];
            [self.hub removeFromSuperview];
            [self.hub release];
            self.hub = nil;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}
- (void)createCollectionView
{
    UICollectionViewFlowLayout *fwl = [[UICollectionViewFlowLayout alloc] init];
    fwl.itemSize = CGSizeMake((UIWIDTH - 60) / 2, (UIWIDTH - 60) / 2 / 4 * 3);
    fwl.scrollDirection = UICollectionViewScrollDirectionVertical;
    fwl.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    fwl.minimumLineSpacing = 0;
    fwl.minimumInteritemSpacing = 0;
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fwl];
    self.collectView.delegate = self;
    self.collectView.dataSource = self;
    self.collectView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectView];
    [_collectView release];
    [self.collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.view.mas_height);
    }];

    [self.collectView registerClass:[WLZNewsHomeCollectionCell class] forCellWithReuseIdentifier:@"cell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemListArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WLZNewsHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    WLZNewFirstModel *model = [self.itemListArr objectAtIndex:indexPath.row];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"kafei"]];
    if (model.brief.length == 0) {
        cell.briefLabel.backgroundColor = [UIColor clearColor];
    }
    cell.briefLabel.text = model.brief;
    cell.titleLabel.text = model.title;
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLZNewFirstModel *model = [self.itemListArr objectAtIndex:indexPath.row];
    WLZNewsDetailViewController *detailVC = [WLZNewsDetailViewController shareDetailViewController];
    detailVC.vId = model.vid;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
