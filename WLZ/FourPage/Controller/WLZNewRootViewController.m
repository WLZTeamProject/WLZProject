//
//  WLZNewRootViewController.m
//  WLZ
//
//  Created by lqq on 16/1/12.
//  Copyright © 2016年 lwz. All rights reserved.
//
#define NEWSHOMEURL @"http://cbox.cntv.cn/json2015/fenleierjiye/xinwen/shouye/index.json"
#import "WLZNewRootViewController.h"
#import "LQQAFNetTool.h"
#import "WLZNewFirstModel.h"
#import "WLZNewsFirstItemListModel.h"
#import <MBProgressHUD.h>
#import <Masonry.h>
#import <SDCycleScrollView.h>

#import "WLZNewTableViewCell.h"
#import "WLZNewsListViewController.h"
#import "WLZNewsDetailViewController.h"
@interface WLZNewRootViewController () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, WLZNewTableViewCellDelegate>


#pragma 一级数据解析
@property (nonatomic, retain) NSMutableArray *itemListArr;
@property (nonatomic, retain) NSMutableArray *bigImgArr;

#pragma 二级数据解析
@property (nonatomic, retain) NSMutableArray *secondItemListArr;
@property (nonatomic, retain) NSMutableDictionary *itemDic;//用于存储最终的数据


@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) SDCycleScrollView *cycleView;

@property (nonatomic, retain) MBProgressHUD *hud;

@end

@implementation WLZNewRootViewController
- (void)dealloc
{
    [_hud release];
    [_cycleView release];
    [_itemDic release];
    [_secondItemListArr release];
    [_bigImgArr release];
    [_itemListArr release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubviews];
    [self createData];
    
    
}
#pragma 创建视图
- (void)createSubviews
{
    self.navigationItem.title = @"新闻";
    [self createTableView];
    
}
#pragma 获取数据
- (void)createData
{
    [self createFirstData];
    
}
#pragma 获取一级数据数据
- (void)createFirstData
{
    self.bigImgArr = [NSMutableArray array];
    self.itemListArr = [NSMutableArray array];
    [LQQAFNetTool getNetWithURL:NEWSHOMEURL body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        
        NSMutableArray *tempBigImgArr = [dic objectForKey:@"bigImg"];
        NSMutableArray *tempItemListArr = [dic objectForKey:@"itemList"];
        for (NSMutableDictionary *tempDic in tempBigImgArr) {
            WLZNewFirstModel *firstModel = [WLZNewFirstModel baseModelWithDic:tempDic];
            [self.bigImgArr addObject:firstModel];
        }
        
        for (NSMutableDictionary *tempDic in tempItemListArr) {
            WLZNewsFirstItemListModel *itemListModel = [WLZNewsFirstItemListModel baseModelWithDic:tempDic];
            [self.itemListArr addObject:itemListModel];
        }
        
        if (self.itemListArr.count != 0) {
            //请求二级数据
            [self createFirstToSecond];
            
            
            //停止加载框
            [self.hud removeFromSuperview];
            [self.hud release];
            self.hud = nil;
            
            
            //给轮播图赋值
            NSMutableArray *urlArr = [NSMutableArray array];
            NSMutableArray *titleArr = [NSMutableArray array];
            
            for (WLZNewFirstModel *model in self.bigImgArr) {
                [urlArr addObject:model.imgUrl];
                [titleArr addObject:model.title];
            }
            self.cycleView.imageURLStringsGroup = urlArr;
            self.cycleView.titlesGroup = titleArr;
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {

    }];
}

#pragma 通过一级数据获取二级数据
- (void)createFirstToSecond
{
    self.itemDic = [NSMutableDictionary dictionary];
    for (WLZNewsFirstItemListModel *model in self.itemListArr) {
        //屏蔽掉下面的内容
        if ([model.order isEqualToString:@"2"]|| [model.order isEqualToString:@"1"]) {
           [self createSecondData:model];
        }
        
    }
}

#pragma 获取二级数据
- (void)createSecondData:(WLZNewsFirstItemListModel *)model
{
    
    [LQQAFNetTool getNetWithURL:model.listUrl body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"itemList"];
        self.secondItemListArr = [NSMutableArray array];
        for (NSMutableDictionary *tempDic in arr) {
            WLZNewFirstModel *model = [WLZNewFirstModel baseModelWithDic:tempDic];
            [self.secondItemListArr addObject:model];
        }
        [self.itemDic setObject:self.secondItemListArr forKey:model.order];
        self.secondItemListArr = nil;
        if (self.itemDic.count != 0) {
            [self.tableV reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
}
#pragma 创建tableView视图
- (void)createTableView
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];

    self.tableV.delegate =self;
    self.tableV.dataSource =self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIWIDTH, UIWIDTH / 3 *2)];
    self.tableV.tableHeaderView = headerView;
  
    [self.view addSubview:self.tableV];
    [_tableV release];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(UIHEIGHT - 120);
    }];
   [self createHeaderView:headerView];
    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.hud];
    [self.hud show:YES];
    
    
}
#pragma 创建透视图,轮播图
- (void)createHeaderView:(UIView *)view
{
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    [view addSubview:self.cycleView];
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableV);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(UIWIDTH / 3 * 2);
    }];
}
#pragma 轮播图点击调用方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    
    NSLog(@"你点击了第%ld张图片", index);
}

#pragma 自定义Header,即自定义区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WLZNewsFirstItemListModel *model = [self.itemListArr objectAtIndex:section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, UIWIDTH, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, UIWIDTH / 2, 40)];
    headerLabel.text = model.title;
    [view addSubview:headerLabel];
    //当moreUrl为空得时候,不显示更多按钮
    if (![model.moreUrl isEqualToString:@""]) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(UIWIDTH - 60, 5, 30, 30);
        [button setImage:[UIImage imageNamed:@"more_2"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10000 + section;
        [view addSubview:button];
    }
    return view;
}
#pragma 更多内容
- (void)buttonAction:(UIButton *)sender
{
    WLZNewsListViewController *listVC = [[WLZNewsListViewController alloc] init];
    WLZNewsFirstItemListModel *model = [self.itemListArr objectAtIndex:sender.tag - 10000];
    listVC.url = model.moreUrl;
    listVC.mytitle = model.title;
    [self.navigationController pushViewController:listVC animated:YES];
    [listVC release];
}
#pragma 区标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

#pragma 分区个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.itemDic.count;
    
}
#pragma 动态设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [NSString stringWithFormat:@"%ld", indexPath.section + 1];
    NSMutableArray *arr = [self.itemDic objectForKey:key];
    return arr.count * (UIWIDTH - 60) / 2 / 4 * 3 / 2;
    
}
#pragma 每个区只有一行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellStr = @"cell";
    //不使用重用池
    WLZNewTableViewCell *cell = [[WLZNewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    cell.delegate = self;
    NSString *key = [NSString stringWithFormat:@"%ld", indexPath.section + 1];
    cell.newsArr = [self.itemDic objectForKey:key];
    return cell;
}
#pragma 主页每个项的代理实现方法
- (void)tableViewCellHandle:(WLZNewFirstModel *)model
{
    
    if ([model.vtype isEqualToString:@"1"]) {
        WLZNewsDetailViewController *detailVC = [[WLZNewsDetailViewController alloc] init];
//        detailVC.vId = model.vid;
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
