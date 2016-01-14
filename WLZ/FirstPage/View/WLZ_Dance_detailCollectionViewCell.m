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
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) UITableView *tableV;

@end

@implementation WLZ_Dance_detailCollectionViewCell

- (void)dealloc
{
    [_title release];
    [_arr release];
    [_tableV release];
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
    self.backgroundColor = [UIColor blueColor];
    self.arr = [NSMutableArray array];
    [self getData];
    
    [self createTableV];
    
    
}

- (void)createTableV
{
    self.tableV = [[UITableView alloc] initWithFrame:self.frame];
    self.tableV.dataSource = self;
    self.tableV.delegate = self;
    [self addSubview:self.tableV];
    
    [self.tableV registerClass:[WLZ_Dance_relateTableViewCell class] forCellReuseIdentifier:@"cell"];

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat num = ([[UIScreen mainScreen] bounds].size.height / 2.0 - [[UIScreen mainScreen] bounds].size.height / 3.0 ) / 2 + [[UIScreen mainScreen] bounds].size.height / 3.0;
    return num / 2.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.arr != nil) {
//        WLZ_Dance_ListModel *zylist = [self.arr objectAtIndex:indexPath.row];
        WLZ_Dance_relateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        return cell;
    }
    return nil;
    
}

- (void)getData
{
    NSString *urlStr = @"http://api3.dance365.com/video/search?word=%E6%AC%A7%E7%BE%8E%E7%88%B5%E5%A3%AB%E8%88%9E,%E7%BC%96%E8%88%9E%E4%BD%9C%E5%93%81,%E8%88%9E%E8%B9%88%E4%BD%9C%E5%93%81&perpage=10&page=1";
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
        
        NSLog(@"娃哈哈哈哈哈啊哈哈%ld", self.arr.count);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
    
    
}

@end
