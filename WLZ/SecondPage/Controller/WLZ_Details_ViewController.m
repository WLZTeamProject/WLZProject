//
//  WLZ_Details_ViewController.m
//  WLZ
//
//  Created by 왕닝 on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Details_ViewController.h"
#import "WLZ_PCH.pch"
#import "WLZ_Details_TableViewCell.h"
#import "WLZ_Details_Model.h"
#import "WLZ_Music_ViewController.h"
@interface WLZ_Details_ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) WLZ_Details_TableViewCell *detailsCell;

@property (nonatomic, retain) UIImageView *headerImageV;

@property (nonatomic, retain) NSMutableArray *radioArr;

@end

@implementation WLZ_Details_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor magentaColor];
    //创建TableView
    [self creatTableView];
    [self creatHeaderView];
    [self getData];
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
        
    }];

}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
    
}

// 区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 != self.radioArr.count) {
        return self.radioArr.count;
    }
    return 3;
}
//注册cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *celld = @"celld";
        self.detailsCell = [tableView dequeueReusableCellWithIdentifier:celld];
        if (nil == self.detailsCell) {
            self.detailsCell = [[WLZ_Details_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celld];
        }
    if (0 != self.radioArr.count) {
        WLZ_Details_Model *model = self.radioArr[indexPath.row];
        self.detailsCell.model = [self.radioArr objectAtIndex:indexPath.row];
        [self.detailsCell.coverimgImageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg]];
        self.detailsCell.titleL.text = model.title;
        self.detailsCell.musicVisitL.text = model.musicVisit;
        self.detailsCell.musicVisitL.font = [UIFont systemFontOfSize:11];
    }
    
            return self.detailsCell;
}

//选中跳转界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLZ_Music_ViewController *musicVC = [[[WLZ_Music_ViewController alloc] init] autorelease];
    //传值model
    WLZ_Details_Model *model = self.radioArr[indexPath.row];
    musicVC.coving = model.coverimg;
    musicVC.tingid = model.tingid;
    musicVC.playInfo = [model.playInfo objectForKey:@"webview_url"];
    musicVC.titleM = self.radioArr;
    [self.navigationController pushViewController:musicVC animated:YES];
}

- (void)creatHeaderView
{
    self.headerImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT / 3)];
    self.headerImageV.image = [UIImage imageNamed:@"kafei"];
    [self.tableV setTableHeaderView:self.headerImageV];
//    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.tableV.tableHeaderView);
//        make.width.equalTo(self.view);
//        make.height.equalTo(@50);
//        make.bottom.equalTo(self.tableV.tableHeaderView);
//        
//    }];
//    self.newImageV.image = [UIImage imageNamed:@"kafei"];
//    self.newImageV.layer.cornerRadius = 10;
//    [self addSubview:self.newImageV];
}

- (void)getData
{
    NSString *url = @"http://api2.pianke.me/ting/radio_detail";
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"PHPSESSID=clljgnbjaqsueqdinkv8366sj3" forKey:@"Cookie"];
    NSString *body = [NSString stringWithFormat:@"auth=&client=1&deviceid=FC88C466-6C29-47E4-B464-AAA1DA196931&radioid=%@&version=3.0.6", self.ScenicID];
    [LQQAFNetTool postNetWithURL:url body:body bodyStyle:LQQRequestNSString headFile:dic responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {

        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        //头图片
        NSDictionary *radioInfoDic = [dataDic objectForKey:@"radioInfo"];
        NSString *coverimgStr = [radioInfoDic objectForKey:@"coverimg"];
        [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:coverimgStr]];
        //音乐接口
        NSMutableArray *listlArr = [dataDic objectForKey:@"list"];
        self.radioArr = [WLZ_Details_Model baseModelWithArr:listlArr];

        
        [self.tableV reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
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
