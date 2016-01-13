//
//  WLZ_List_CollectionViewCell.m
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_List_CollectionViewCell.h"
#import "WLZ_List_TableViewCell.h"
#import "WLZ_Details_Model.h"
#import "WLZ_Music_ViewController.h"
@interface WLZ_List_CollectionViewCell ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) WLZ_List_TableViewCell *listCell;

@end

@implementation WLZ_List_CollectionViewCell

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
    self.tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self addSubview:self.tableV];
    [_tableV release];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(VHEIGHT - 120));
        make.top.equalTo(self);
        make.width.equalTo(@(VWIDTH));
    }];

}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

//tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 != self.titleML.count) {
    return self.titleML.count;
    }
    return 5;
    
}

//注册cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *celld = @"celld";
    self.listCell = [tableView dequeueReusableCellWithIdentifier:celld];
    if (nil == self.listCell) {
        self.listCell = [[WLZ_List_TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celld];
    }
    WLZ_Details_Model *model = self.titleML[indexPath.row];

    self.listCell.titleL.text = model.title;
    self.listCell.musicVisitL.font = [UIFont systemFontOfSize:11];
    self.listCell.musicVisitL.text = [NSString stringWithFormat:@"%@%@", @"by: ", model.musicVisit];
       return self.listCell;

}

//选中跳转界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    WLZ_Details_Model *model = self.titleML[indexPath.row];
    [WLZ_Music_ViewController sharePlayPageVC].url = model.musicUrl;
    [WLZ_Music_ViewController sharePlayPageVC].titleM = self.titleML;
    [WLZ_Music_ViewController sharePlayPageVC].row = indexPath.row;
    [self.tableV reloadData];
    
    [self buttonAction];

    
}

- (void)buttonAction
{
    [self.delegate changeVCColor];
}

@end
