//
//  WLZUserRootViewController.m
//  WLZ
//
//  Created by lqq on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZUserRootViewController.h"
#import <Masonry.h>
#import "WLZUserCollectViewController.h"
#import "AppDelegate.h"
#import "WLZUserTableViewCell.h"
#import "WLZUserLabelTableViewCell.h"
@interface WLZUserRootViewController () <UITableViewDelegate, UITableViewDataSource, WLZUserTableViewCellDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arr;
@end

@implementation WLZUserRootViewController
- (void)dealloc
{
    [_arr release];
    [_tableView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0];
    [self createView];
}
- (void)createView
{
    [self createTableView];
    
}
-(void)createTableView
{
    self.arr = [NSMutableArray arrayWithObjects:@"我的收藏", @"夜间模式", @"清除缓存", nil];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource  = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [_tableView release];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(100);
        make.width.mas_equalTo(UIWIDTH - 100);
        make.height.mas_equalTo(300);
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (1 != indexPath.row) {
        static NSString *cellStr = @"cell";
        WLZUserLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        if (nil == cell) {
            cell = [[WLZUserLabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
        return cell;
    } else {
        static NSString *cellSStr = @"cellS";
        WLZUserTableViewCell *cell = [[WLZUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSStr];
        cell.delegate = self;
        cell.titleLabel.text = [self.arr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)nightSwitchHandle:(UISwitch *)senderSwitch
{
    if (senderSwitch.on) {
        NSLog(@"夜间模式");
    } else {
        NSLog(@"日间模式");
    }
    senderSwitch.on = !senderSwitch.on;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *tempApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSLog(@"%ld", indexPath.row);
    WLZUserCollectViewController * collcetVC = nil;
    switch (indexPath.row) {
        case 0:
            [tempApp.leftVC closeLeftView];
            //跳转到收藏界面
            collcetVC = [[WLZUserCollectViewController alloc] init];
            UINavigationController *navNC = [[[UINavigationController alloc] initWithRootViewController:collcetVC] autorelease];
            navNC.navigationBar.translucent = NO;
            navNC.navigationBar.tintColor = [UIColor blackColor];
            [self presentViewController:navNC animated:YES completion:^{
            }];
            [collcetVC release];
            break;
        case 1:
            NSLog(@"夜间模式");
            break;
        case 2:
            NSLog(@"清除缓存");
            break;
        default:
            break;
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
