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
    [_danceLunboArr release];
    [_danceArr release];
    [_tableV release];
    [_urlStr release];
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    WLZ_Dance_detailViewController *wlzDanceVC = [[WLZ_Dance_detailViewController alloc] init];
//    [self.navigationController pushViewController:wlzDanceVC animated:YES];
    [self presentViewController:wlzDanceVC animated:YES completion:^{
        
        
    }];
    [wlzDanceVC release];
    
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
        NSMutableArray *newArr = [WLZ_Dance_ListModel baseModelWithArr:resultArr];
        for (WLZ_Dance_ListModel *wlzList in newArr) {
            [self.danceArr addObject:wlzList];
        }
        //        NSLog(@"呵呵呵呵呵呵呵%@", self.danceArr);
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
