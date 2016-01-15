//
//  WLZUserCollectViewController.m
//  WLZ
//
//  Created by lqq on 16/1/15.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZUserCollectViewController.h"
#import "LQQCoreDataManager.h"
#import <Masonry.h>
#import "DocModel.h"
#import "WLZReadWebViewController.h"
@interface WLZUserCollectViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) LQQCoreDataManager *dataManager;
@property (nonatomic, retain) NSMutableArray *docArr;

@end

@implementation WLZUserCollectViewController
- (void)dealloc
{
    [_docArr release];
    [_dataManager release];
    [_tableV release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的收藏";
    self.dataManager = [LQQCoreDataManager sharaCoreDataManager];
    self.docArr = [self.dataManager readSearch];
    for (DocModel *model in self.docArr) {
        NSLog(@"%@", model.title);
    }
    [self createView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
}
- (void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)createView
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    [_tableV release];
    [self.tableV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:editing];
    [self.tableV setEditing:editing animated:editing];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UITableViewCellEditingStyleDelete == editingStyle) {
        DocModel *model = [self.docArr objectAtIndex:indexPath.row];
        [self.dataManager readDelete:model.mid];
        [self.docArr removeObjectAtIndex:indexPath.row];
    }
    [self.tableV reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.docArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellStr = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    DocModel *model = [self.docArr objectAtIndex:indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocModel *model = [self.docArr objectAtIndex:indexPath.row];
    WLZReadWebViewController *webViewController = [[[WLZReadWebViewController alloc] init] autorelease];
    webViewController.mId = model.mid;
    
    [self.navigationController pushViewController:webViewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
