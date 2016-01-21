//
//  WLZ_Happy_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Happy_CollectionViewCell.h"
#import "WLZ_Happy_TableViewCell.h"
#import "WLZ_Happy_No_TableViewCell.h"
#import "WLZ_PCH.pch"
#import "WLZ_News_Model.h"

@interface WLZ_Happy_CollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) WLZ_Happy_TableViewCell *listCell;

@property (nonatomic, retain) WLZ_Happy_No_TableViewCell *happyCell;

@property (nonatomic, retain) UITableView *tableV;

@property (nonatomic, retain) NSMutableArray *happyArr;

@property (nonatomic, retain) NSMutableArray *koreanArr;

@end

@implementation WLZ_Happy_CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VWIDTH, VHEIGHT - 120 ) style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableV];
    [_tableV release];
    [WLZ_GIFT setGifWithImageName:@"pika2.gif"];
    [self.tableV reloadData];
    [self addHeaderRefresh];
}

- (void)addHeaderRefresh
{
    self.tableV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //获取数据
        
        [self getDataHappy];
    }];
    [self.tableV.mj_header beginRefreshing];
    
    self.tableV.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{

    }];
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.happyArr.count;
    
}

//注册cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLZ_News_Model *model = self.happyArr[indexPath.row];
    
    if (model.pic_path.length != 0) {
        
        
        static NSString *celld = @"celld";
        self.listCell = [tableView dequeueReusableCellWithIdentifier:celld];
        if (nil == self.listCell) {
            self.listCell = [[WLZ_Happy_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celld];
        }
        
        
        
        self.listCell.pic_pathV.image = [UIImage imageNamed:@"kafei"] ;
        [self.listCell.pic_pathV sd_setImageWithURL:[NSURL URLWithString:model.pic_path]];
        self.listCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.listCell.titleLL.text = model.title;
        self.listCell.summaryL.text = model.summary;
        return self.listCell;
    }
    
    
    static NSString *cellstr = @"happy";
    self.happyCell = [tableView dequeueReusableCellWithIdentifier:cellstr];
    if (nil == self.happyCell) {
        self.happyCell = [[WLZ_Happy_No_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstr];
    }
    self.happyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    self.happyCell.titleLL.text = model.title;
    self.happyCell.summaryL.text = model.summary;
    
    return self.happyCell;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLZ_News_Model *model = [self.happyArr objectAtIndex:indexPath.row];
    //代理方法,将model传给VC
    [self.delegate didSelectedHandle:model];
    
}
- (void)getDataHappy
{
    [WLZ_GIFT show];
    self.happyArr = [NSMutableArray array];
    self.koreanArr = [NSMutableArray array];
    
    NSString *url = @"http://bbs.icnkr.com/mobcent/app/web/index.php?r=portal/newslist";
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"application/x-www-form-urlencoded" forKey:@"Content-Type"];
    NSString *body = [NSString stringWithFormat:@"circle=0&pageSize=20&longitude=121.539106&sdkVersion=2.4.0&apphash=8523a74a&latitude=38.882925&moduleId=%ld&page=1&forumKey=ry0uLYvSvEPJkyHJSp", self.num];
    [LQQAFNetTool postNetWithURL:url body:body bodyStyle:LQQRequestNSString headFile:dic responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *listArr = [responseObject objectForKey:@"list"];
        for (NSMutableDictionary *dic in listArr) {
            WLZ_News_Model *model = [WLZ_News_Model baseModelWithDic:dic];
            [self.happyArr addObject:model];
        }
        if (self.happyArr.count != 0) {
            [self.tableV reloadData];
            [self.tableV.mj_header endRefreshing];
            [self.tableV.mj_footer endRefreshing];
            [WLZ_GIFT dismiss];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}


@end
