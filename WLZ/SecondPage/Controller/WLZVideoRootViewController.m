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
@interface WLZVideoRootViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) SDCycleScrollView *scrollView;

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) WLZ_Movies_TableViewCell * moviesCell;

@property (nonatomic, retain) WLZ_Featured_TableViewCell *featuredCell;

@property (nonatomic, retain) NSMutableArray *imgArr;

@property (nonatomic, retain) NSMutableArray *featuredArr;

@property (nonatomic, retain) NSMutableArray *radiosArr;

@end

@implementation WLZVideoRootViewController

- (void)dealloc
{
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
    //获取数据
    [self getData];
    
    // hahalalala
}

//创建视图
- (void)creatView
{
    //创建TableView
    [self creatTableView];
    //建立轮播图
    [self wheelView];
}

//创建TableView
- (void)creatTableView
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
//    self.tableV.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.tableV];
    [_tableV release];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(150);
        
    }];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//    
//}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.section) {
        return (WIDTH - 40) / 3;
        
    } //else
//        if (1 == indexPath.section) {
//            return 200;
//        }
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
    }
    if (0 != self.radiosArr.count) {
        return self.radiosArr.count;
    }
    return 3;
    
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
//
    WLZ_Radios_Model *model = self.radiosArr[indexPath.row];
    self.moviesCell.model = [self.radiosArr objectAtIndex:indexPath.row];
        [self.moviesCell.RadiosImageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
        self.moviesCell.titleL.text = model.title;
        self.moviesCell.unameL.text = [NSString stringWithFormat:@"%@%@",@"by:" ,[model.userinfo objectForKey:@"uname"]];
        self.moviesCell.unameL.font = [UIFont systemFontOfSize:11];
        self.moviesCell.descL.text = model.desc;
        self.moviesCell.descL.font = [UIFont systemFontOfSize:11];
    }
    return self.moviesCell;
    
}

//选中跳转界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (0 == indexPath.section)
    {
        
        
    }
    else
    {
        WLZ_Details_ViewController *detailsVC = [[[WLZ_Details_ViewController alloc] init] autorelease];
//        WLZ_Movies_TableViewCell *cell = (WLZ_Movies_TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        WLZ_Radios_Model *model = self.radiosArr[indexPath.row];
        detailsVC.ScenicID = model.radioid;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
        
        
        
//    {
//        WN_Travel_Details_ViewController *travelDVC = [[WN_Travel_Details_ViewController alloc] init];
//        //        travelDVC.mid = [NSString stringWithFormat:@"%@", self.dArr[indexPath.row]];
//        travelDVC.url = [NSString stringWithFormat:@"%@", self.dArr[indexPath.row]];
//        
//        WN_Travel_Model *model = self.dArr[indexPath.row];
//#warning block传值1 - 定义block,并通过调用secondVC的方法将block地址传递过去
//        __unsafe_unretained WN_Recommend_ViewController *rootVC = self;
//        [travelDVC sendBlock:^(UIColor *myColor) {
//            rootVC.view.backgroundColor = myColor;
//        } str:model.view_url];
//        [self.navigationController pushViewController:travelDVC animated:YES];
//        
//    }
}

//建立轮播图
- (void)wheelView
{
    self.scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 3) delegate:self placeholderImage:[UIImage imageNamed:@"kafei"]];
    
    self.tableV.tableHeaderView = self.scrollView;
    
//    [self.tableV setTableHeaderView:self.scrollView];
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableV);
//        make.height.equalTo(@250);
//        make.width.equalTo(self.view);
        
//    }];
    
    [self.tableV reloadData];
}


//获取数据
- (void)getData
{
    self.imgArr = [NSMutableArray array];
    self.featuredArr = [NSMutableArray array];
    self.radiosArr = [NSMutableArray array];
    NSString *url = @"http://api2.pianke.me/ting/radio";
    [LQQAFNetTool postNetWithURL:url body:nil bodyStyle:LQQRequestJSON headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
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
        for (NSDictionary *dic in hotlistArr) {
            [self.featuredArr addObject:[dic objectForKey:@"coverimg"]];
        }
        
        //全部电台解析数据
        NSMutableArray *alllistArr = [dataDic objectForKey:@"alllist"];
//        for (NSMutableDictionary *dic in alllistArr) {
//            NSMutableArray * d = [WLZ_Base_Model baseModelWithDic:dic];
//        }
        self.radiosArr = [WLZ_Radios_Model baseModelWithArr:alllistArr];
        [self.tableV reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"$$$$$$$$$$$$$");
        
    }];
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
