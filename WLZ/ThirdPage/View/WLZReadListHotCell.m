//
//  WLZReadListHotCell.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadListHotCell.h"
#import <MBProgressHUD.h>
#import "LQQAFNetTool.h"
#import "WLZReadListModel.h"
#import <MJRefresh.h>
#define READURL @"http://api2.pianke.me/read/columns_detail"

#import "WLZReadTableViewCell.h"


@interface WLZReadListHotCell () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSMutableDictionary *dic;
@property (nonatomic, retain) NSMutableArray *docArr;
@property (nonatomic, retain) MBProgressHUD *hud;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) NSInteger start;
@end
@implementation WLZReadListHotCell
- (void)dealloc
{
    [_dic release];
    [_docArr release];
    [_hud release];
    [_tableView release];
    [super dealloc];
}
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
    [self createTableView];
}
- (void)setTypleId:(NSString *)typleId
{
    if (_typleId != typleId) {
        [_typleId release];
        _typleId = [typleId copy];
    }
    [self RefreshData];
//    [self createNewData];
}
- (void)createTableView
{
    self.start = 0;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.contentView addSubview:self.tableView];
    [_tableView release];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(20);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(self.contentView.mas_height).offset(-55);
    }];
    self.hud = [[MBProgressHUD alloc] initWithView:self.contentView];
    [self.contentView addSubview:self.hud];
    [self.hud show:YES];
}
#pragma 上拉下拉刷新数据
- (void)RefreshData
{
 
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self createNewData];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.start += 10;
        [self createNewData];
        
    }];
    
    
}
- (void)createNewData
{
    self.dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"addtime", @"sort", 0, @"start", @"2", @"client", @"1", @"typeid", @"10", @"list", nil];
    [self.dic setObject:self.typleId forKey:@"typeid"];
    [self.dic setObject:self.sort forKey:@"sort"];
    [self.dic setObject:[NSString stringWithFormat:@"%ld", self.start] forKey:@"start"];
    if (self.start == 0) {
       self.docArr = [NSMutableArray array];
    }
    [LQQAFNetTool postNetWithURL:READURL body:self.dic bodyStyle:LQQRequestJSON headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"list"];
        
        for (NSMutableDictionary *tempDic in arr) {
            WLZReadListModel *model = [WLZReadListModel baseModelWithDic:tempDic];
            [self.docArr addObject:model];
        }
        if (self.docArr) {
            [self.tableView reloadData];
            [self.hud removeFromSuperview];
            [self.hud release];
            self.hud = nil;
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.docArr.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    WLZReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (nil == cell) {
        cell = [[WLZReadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    
    WLZReadListModel *model = [self.docArr objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.title;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:model.coverimg] placeholderImage:[UIImage imageNamed:@"kafei"]];
    cell.contentLabel.text = model.content;
    return cell;
}

@end
