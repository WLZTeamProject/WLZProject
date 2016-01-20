//
//  WLZ_Dance_searchdetailViewController.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_searchdetailViewController.h"
#import "WLZ_DanceTableViewCell.h"
#import "WLZ_Dance_ListModel.h"
#import "WLZ_Dance_detailViewController.h"
@interface WLZ_Dance_searchdetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, assign) NSInteger page;

@end

@implementation WLZ_Dance_searchdetailViewController

- (void)dealloc
{
    [_str release];
    [_arr release];
    [super dealloc];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arr = [NSMutableArray array];
    self.page = 1;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backImage"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    [self getData];
    [self createTablV];
}

- (void)createTablV
{
    self.tableV = [[UITableView alloc] initWithFrame:self.view.frame];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self getData];
        
    }];
    
    [self.tableV registerClass:[WLZ_DanceTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLZ_Dance_ListModel *zylist = [self.arr objectAtIndex:indexPath.row];
    WLZ_Dance_detailViewController *wlzdetailVC = [[WLZ_Dance_detailViewController alloc] init];
    wlzdetailVC.zyDance = zylist;
    [self.navigationController pushViewController:wlzdetailVC animated:YES];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UIScreen mainScreen] bounds].size.height / 3.0;
}
- (void)getData
{
    NSString *str = [NSString stringWithFormat:@"http://api3.dance365.com/video/search?word=%@&perpage=10&page=%ld", self.str, self.page];
    [LQQAFNetTool getNetWithURL:str body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *resultArr = [responseObject objectForKey:@"result"];
        for (NSMutableDictionary *resultDic in resultArr) {
            WLZ_Dance_ListModel *wlzDance = [WLZ_Dance_ListModel baseModelWithDic:resultDic];
            NSMutableArray *videoArr = [resultDic objectForKey:@"item_videos"];
            for (NSMutableDictionary *newDic in videoArr) {
                NSString *url = [newDic objectForKey:@"url"];
                wlzDance.url = url;
            }
            [self.arr addObject:wlzDance];
        }
        [self.tableV.mj_footer endRefreshing];
        [self.tableV reloadData];
        
//        NSLog(@"叔叔世俗化俗话说%ld", self.arr.count);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arr != nil) {
        WLZ_Dance_ListModel *wlzList = [self.arr objectAtIndex:indexPath.row];
        WLZ_DanceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:wlzList.item_image] placeholderImage:[UIImage imageNamed:@"kafei"]];
        cell.titleL.text = wlzList.item_title;
        NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc] initWithString:cell.titleL.text];
        NSRange range = [cell.titleL.text rangeOfString:self.str];
        [attributed addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        cell.titleL.attributedText = attributed;
        
        cell.personL.text = [NSString stringWithFormat:@"%@人在学",wlzList.item_click];
        
        
        return cell;
    }
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
