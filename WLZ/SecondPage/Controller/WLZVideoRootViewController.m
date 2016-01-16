//
//  WLZVideoRootViewController.m
//  WLZ
//
//  Created by lqq on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZVideoRootViewController.h"
#import "WLZ_PCH.pch"
#import "WLZ_Movies_TableViewCell.h"
#import "WLZ_Featured_TableViewCell.h"
#import "WLZ_Radios_Model.h"
#import "WLZ_Details_ViewController.h"
#define FIRESTURL @"http://api2.pianke.me/ting/radio"
#define AGEGINURL @"http://api2.pianke.me/ting/radio_list"
@interface WLZVideoRootViewController () <UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate, WLZ_Featured_TableViewCellDelegate>

@property (nonatomic, retain) SDCycleScrollView *scrollView;

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) WLZ_Movies_TableViewCell * moviesCell;

@property (nonatomic, retain) WLZ_Featured_TableViewCell *featuredCell;

@property (nonatomic, retain) NSMutableArray *imgArr;

@property (nonatomic, retain) NSMutableArray *featuredArr;

@property (nonatomic, retain) NSMutableArray *radiosArr;

@property (nonatomic, retain) NSMutableArray *radioidArr;

@property (nonatomic, retain) NSMutableArray *jingxuanArr;

@property (nonatomic, assign) NSInteger index;


@property (nonatomic, retain) NSMutableDictionary *bodyDic;

@end

@implementation WLZVideoRootViewController

- (void)dealloc
{
    [_bodyDic release];
    [_scrollView release];
    [_tableV release];
    [_moviesCell release];
    [_featuredCell release];
    [_imgArr release];
    [_featuredArr release];
    [_radiosArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
   //创建视图
    [self creatView];
    [self addHeaderRefresh];
    [WLZ_GIFT setGifWithImageName:@"pika2.gif"];

    // hahalalala
}

//创建视图
- (void)creatView
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"蠕动"] forBarMetrics:UIBarMetricsDefault];
    //创建TableView
    [self creatTableView];
    //建立轮播图
    [self wheelView];
}

//创建TableView
- (void)creatTableView
{
    self.navigationItem.title = @"电台";
    self.tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:0.800 alpha:1.000];
    [self.view addSubview:self.tableV];
    [_tableV release];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(150);
        
    }];
}

- (void)addHeaderRefresh
{
    self.bodyDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"client",@"9", @"limit", @"0", @"start", @"3.0.6", @"version", nil];
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //获取数据
        [self getData:FIRESTURL body:self.bodyDic];
    }];
    [self.tableV.mj_header beginRefreshing];
    
    self.index = 0;
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.index += 9;
        NSString *str = [NSString stringWithFormat:@"%ld", self.index];
        [self.bodyDic setObject:str forKey:@"start"];
        [self getData:AGEGINURL body:self.bodyDic];
    }];
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return (WIDTH - 40) / 3;
    }
    return 100;
    
}

// 区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

//tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section) {
        return 1;
    } else {
        return self.radiosArr.count;
    }
    return 0;
    
}
//区标题高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

//注册cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        static NSString *celld = @"celld";
        self.featuredCell = [tableView dequeueReusableCellWithIdentifier:celld];
           self.featuredCell.delegate = self;
        self.featuredCell.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:0.800 alpha:1.000];
        if (nil == self.featuredCell) {
            self.featuredCell = [[WLZ_Featured_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celld];
         
        }
        if (0 != self.featuredArr.count) {
            [self.featuredCell.newImageV sd_setImageWithURL:[NSURL URLWithString:self.featuredArr[0]]];
            [self.featuredCell.earlyImageV sd_setImageWithURL:[NSURL URLWithString:self.featuredArr[1]]];
            [self.featuredCell.nightImageV sd_setImageWithURL:[NSURL URLWithString:self.featuredArr[2]]];
            
        }
        return self.featuredCell;
    }
    
    
    static NSString *celldf = @"celldefinition";
    self.moviesCell = [tableView dequeueReusableCellWithIdentifier:celldf];
    if (nil == self.moviesCell) {
        self.moviesCell = [[WLZ_Movies_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celldf];
    }
    if (0 != self.radiosArr.count) {
    WLZ_Radios_Model *model = self.radiosArr[indexPath.row];
    self.moviesCell.model = [self.radiosArr objectAtIndex:indexPath.row];
        [self.moviesCell.RadiosImageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
        self.moviesCell.backgroundColor = [UIColor colorWithRed:0.400 green:1.000 blue:0.800 alpha:1.000];
        self.moviesCell.titleL.text = model.title;
        self.moviesCell.unameL.text = [NSString stringWithFormat:@"%@%@",@"by:" ,[model.userinfo objectForKey:@"uname"]];
        self.moviesCell.unameL.font = [UIFont systemFontOfSize:11];
        self.moviesCell.descL.text = model.desc;
        self.moviesCell.descL.font = [UIFont systemFontOfSize:11];
    }
    return self.moviesCell;
    
}

- (void)exchange1
{
    WLZ_Details_ViewController *detailsVC = [[[WLZ_Details_ViewController alloc] init] autorelease];
    WLZ_Radios_Model *model = self.jingxuanArr[0];
    detailsVC.title = model.title;

    detailsVC.ScenicID = self.radioidArr[0];
    [self.navigationController pushViewController:detailsVC animated:YES];
}
- (void)exchange2
{
    WLZ_Details_ViewController *detailsVC = [[[WLZ_Details_ViewController alloc] init] autorelease];
    detailsVC.ScenicID = self.radioidArr[1];
    WLZ_Radios_Model *model = self.jingxuanArr[1];
    detailsVC.title = model.title;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
- (void)exchange3
{
    WLZ_Details_ViewController *detailsVC = [[[WLZ_Details_ViewController alloc] init] autorelease];
    detailsVC.ScenicID = self.radioidArr[2];
    WLZ_Radios_Model *model = self.jingxuanArr[2];
    detailsVC.title = model.title;
    [self.navigationController pushViewController:detailsVC animated:YES];
}


//选中跳转界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == indexPath.section)
    {
 
        
    } else {
        WLZ_Details_ViewController *detailsVC = [[[WLZ_Details_ViewController alloc] init] autorelease];
        WLZ_Radios_Model *model = self.radiosArr[indexPath.row];
        detailsVC.ScenicID = model.radioid;
        detailsVC.title = model.title;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
    [self.tableV reloadData];
}

//建立轮播图
- (void)wheelView
{
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3) delegate:self placeholderImage:[UIImage imageNamed:@"kafei"]];
    self.tableV.tableHeaderView = self.scrollView;
    [self.tableV reloadData];
}


//获取数据
- (void)getData:(NSString *)url body:(NSMutableDictionary *)body
{
    [WLZ_GIFT show];
    if ([url isEqualToString:FIRESTURL]) {
        self.imgArr = [NSMutableArray array];
        self.featuredArr = [NSMutableArray array];
        self.radiosArr = [NSMutableArray array];
        self.radioidArr = [NSMutableArray array];
        self.jingxuanArr = [NSMutableArray array];
    }
    [LQQAFNetTool postNetWithURL:url body:body bodyStyle:LQQRequestJSON headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        //轮播图数据解析
        NSArray *carouselArr = [dataDic objectForKey:@"carousel"];
        for (NSDictionary *dic in carouselArr) {
            [self.imgArr addObject:[dic objectForKey:@"img"]] ;
            
        }
        //轮播图赋值
        self.scrollView.imageURLStringsGroup = self.imgArr;
        
        //精选数据解析
        NSArray *hotlistArr = [dataDic objectForKey:@"hotlist"];
        for (NSMutableDictionary *dic in hotlistArr) {
            WLZ_Radios_Model *model = [WLZ_Radios_Model baseModelWithDic:dic];
            [self.jingxuanArr addObject:model];
            [self.featuredArr addObject:[dic objectForKey:@"coverimg"]];
            [self.radioidArr addObject:[dic objectForKey:@"radioid"]];
            
        }
        
        NSMutableArray *listArr = nil;
        if ([url isEqualToString:AGEGINURL]) {
            listArr = [dataDic objectForKey:@"list"];
        } else {
            //全部电台解析数据
            listArr = [dataDic objectForKey:@"alllist"];
        }
       
    
        for (NSMutableDictionary *tempDic in listArr) {
            WLZ_Radios_Model *model = [WLZ_Radios_Model baseModelWithDic:tempDic];
            [self.radiosArr addObject:model];
        }
        if (self.radiosArr.count != 0) {
            [self.tableV.mj_footer endRefreshing];
            [self.tableV.mj_header endRefreshing];
            [WLZ_GIFT dismiss];
            [self.tableV reloadData];
        }
        
        
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
//    [self.tableV.mj_header endRefreshing];
//    [self.tableV.mj_footer endRefreshing];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
