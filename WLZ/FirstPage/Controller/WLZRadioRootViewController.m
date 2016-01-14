//
//  WLZRadioRootViewController.m
//  WLZ
//
//  Created by lqq on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZRadioRootViewController.h"
#import "LQQAFNetTool.h"
#import "WLZ_Dance_Model.h"
#import "WLZ_Dance_ListModel.h"
#import "WLZ_DanceTableViewCell.h"
#import "MJRefresh.h"
#import "WLZ_Dance_detailViewController.h"
#import "WLZ_Dance_videoModel.h"
@interface WLZRadioRootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) NSMutableArray *danceLunboArr;
@property (nonatomic, retain) NSMutableArray *danceArr;
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, assign) NSInteger page;

@end

@implementation WLZRadioRootViewController

- (void)setDanceArr:(NSMutableArray *)danceArr
{
    if (_danceArr != danceArr) {
        [_danceArr release];
        _danceArr = [danceArr retain];
        [self.tableV reloadData];
    }
    
}

- (void)dealloc
{
    self.tableV.delegate = nil;
    self.tableV.dataSource = nil;
    [_danceLunboArr release];
    [_danceArr release];
    [_tableV release];
    [_urlStr release];
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    self.view.backgroundColor = color;
    self.danceArr = [NSMutableArray array];
    self.page = 1;
    [self createTableV];
    
    [self getData];
    [self getTableVData];
    
}

- (void)createTableV
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableV.delegate  = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    self.tableV.rowHeight = [[UIScreen mainScreen] bounds].size.height / 3.0;
    //设置上拉刷新
    self.tableV.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    
//    if (self.danceArr.count != 0) {
        [self.tableV registerClass:[WLZ_DanceTableViewCell class] forCellReuseIdentifier:@"cell"];
//    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLZ_Dance_ListModel *wlzdance = [self.danceArr objectAtIndex:indexPath.row];
    WLZ_Dance_detailViewController *wlzDanceVC = [[WLZ_Dance_detailViewController alloc] init];
    [self.navigationController pushViewController:wlzDanceVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.tabBar setHidden:YES];
    wlzDanceVC.zyDance = wlzdance;
    [wlzDanceVC release];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

//上拉刷新
- (void)refreshAction
{
    self.page++;
    [self getTableVData];
    [self.tableV reloadData];
    //    [self createTableV];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [[UIScreen mainScreen] bounds].size.height / 3.0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (0 != self.danceArr.count) {
    return self.danceArr.count;
//    }
//    return 2;

//    NSLog(@"%ld", self.danceArr.count);
//    if (self.danceArr == nil) {
//        return 0;
//    } else {
//        return self.danceArr.count;
//    }
    return self.danceArr.count;
    
    

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.danceArr.count != 0) {
        WLZ_Dance_ListModel *wlzlist = [self.danceArr objectAtIndex:indexPath.row];
        static NSString *cellStr = @"cell";
        WLZ_DanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        cell.titleL.text = wlzlist.item_title;
        cell.personL.text = [NSString stringWithFormat:@"%@人在学",wlzlist.item_click];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:wlzlist.item_image]];
        return cell;
    }
//    else {
//        static NSString *cellStr = @"cell2";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
//        if (nil == cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
//        }
//        return cell;
//    }
   
    return 0;
}

//获取tableView数据
- (void)getTableVData
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api3.dance365.com/video/type?&page=%ld&perpage=10&type=normal&word=", self.page];
    [LQQAFNetTool getNetWithURL:urlStr body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *resultArr = [responseObject objectForKey:@"result"];
        for (NSMutableDictionary *tempDic in resultArr) {
            WLZ_Dance_ListModel *wlzdance = [WLZ_Dance_ListModel baseModelWithDic:tempDic];
            wlzdance.item_videos = [NSMutableArray array];
            NSMutableArray *arr = [tempDic objectForKey:@"item_videos"];
            for (NSMutableDictionary *newDic in arr) {
                WLZ_Dance_videoModel *zyvideo = [WLZ_Dance_videoModel baseModelWithDic:newDic];
                [wlzdance.item_videos addObject:zyvideo];
            }
            [self.danceArr addObject:wlzdance];
       
        }
        [self.tableV reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

//获取轮播图数据
- (void)getData
{
    NSString *str = @"http://v.dance365.com/api.php?type=top&dancetype=";
    [LQQAFNetTool getNetWithURL:str body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *commonArr = [responseObject objectForKey:@"common"];
        self.danceLunboArr = [WLZ_Dance_Model baseModelWithArr:commonArr];
        [self.tableV reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
