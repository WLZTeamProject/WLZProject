//
//  WLZ_Dance_detailCollectionViewCell.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/13.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_detailCollectionViewCell.h"
#import "LQQAFNetTool.h"
#import "WLZ_Dance_ListModel.h"
#import "WLZ_Dance_videoModel.h"
#import "WLZ_Dance_relateTableViewCell.h"

@interface WLZ_Dance_detailCollectionViewCell () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) NSInteger page;



@end

@implementation WLZ_Dance_detailCollectionViewCell

- (void)setTitle:(NSString *)title
{
    if (_title != title) {
        [_title release];
        _title = [title retain];
        [self.tableV reloadData];
    }
}

- (void)setArr:(NSMutableArray *)arr
{
    if (_arr != arr) {
        [_arr release];
        _arr = [arr retain];
        
    }
    [self.tableV reloadData];
}

- (void)dealloc
{
    [_title release];
    [_arr release];
    [_tableV release];
    [super dealloc];
}

//- (void)setArr:(NSMutableArray *)arr
//{
//    if (_arr != arr) {
//        [_arr release];
//        _arr = [arr retain];
//    }
//    [self.tableV reloadData];
//}

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
   
    self.backgroundColor = [UIColor clearColor];
//    self.arr = [NSMutableArray array];
//    self.page = 1;
    
    [self createTableV];
    
    
}

- (void)createTableV
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    self.tableV.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.tableV];
    
    [self.tableV registerClass:[WLZ_Dance_relateTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLZ_Dance_ListModel *wlzlist = [self.arr objectAtIndex:indexPath.row];
    [self.delegate transferValue:wlzlist];
    
    [self.tableV reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UIScreen mainScreen] bounds].size.height / 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"")
    
    if (self.arr != nil) {
        WLZ_Dance_ListModel *zylist = [self.arr objectAtIndex:indexPath.row];
        WLZ_Dance_relateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        [cell.imageV sd_setImageWithURL:[NSURL URLWithString:zylist.item_image] placeholderImage:[UIImage imageNamed:@"kafei"]];
        cell.titleL.text = zylist.item_title;
        cell.catalogL.text = zylist.item_catalog;
        return cell;
    }
    return nil;
    
    
}

- (void)getData
{
    NSString *urlStr = [NSString stringWithFormat:@"http://api3.dance365.com/video/search?word=%@&perpage=10&page=1",self.title];
    ;
    [LQQAFNetTool getNetWithURL:urlStr body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *resultArr = [responseObject objectForKey:@"result"];
        
        
        for (NSMutableDictionary *tempDic in resultArr) {
            WLZ_Dance_ListModel *zylist = [WLZ_Dance_ListModel baseModelWithDic:tempDic];
            [self.arr addObject:zylist];
            zylist.item_videos = [NSMutableArray array];
            NSMutableArray *videoArr = [tempDic objectForKey:@"item_videos"];
            for (NSMutableDictionary *videoDic in videoArr) {
                WLZ_Dance_videoModel *wlzvideo = [WLZ_Dance_videoModel baseModelWithDic:videoDic];
                [zylist.item_videos addObject:wlzvideo];
            }
  
        }
        [self.tableV reloadData];
//        NSLog(@"娃哈哈哈哈哈啊哈哈%ld", self.arr.count);
 
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
    
}

@end
