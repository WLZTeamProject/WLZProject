//
//  WLZ_Radios_Collection_ViewController.m
//  WLZ
//
//  Created by 왕닝 on 16/1/15.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Radios_Collection_ViewController.h"
#import "LQQCoreDataManager.h"
#import <Masonry.h>
#import "RadiosModel.h"
#import "WLZ_Details_ViewController.h"
@interface WLZ_Radios_Collection_ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) LQQCoreDataManager *dataManager;
@property (nonatomic, retain) NSMutableArray *docArr;

@end

@implementation WLZ_Radios_Collection_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"我的收藏";
    [self createView];

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
}
- (void)leftAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.dataManager = [LQQCoreDataManager sharaCoreDataManager];
    self.docArr = [self.dataManager RadiosSearch];
    for (RadiosModel *model in self.docArr) {
        NSLog(@"%@", model.title);
    }
    if (self.docArr.count == 0) {
        
        WLZBaseLabel *label = [[WLZBaseLabel alloc] init];
        label.text = @"收藏夹空, 快去逛逛吧";
        label.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.tableV.backgroundView = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.view);
            
        }];
//        UIImageView *imageV = [[UIImageView alloc] init];
//        imageV.image = [UIImage imageNamed:@"11"];
//        self.tableV.backgroundView = imageV;
//        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.view);
//            
//        }];
    }
    [self.tableV reloadData];
}

- (void)createView
{
    self.tableV = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    [self.view addSubview:self.tableV];
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        RadiosModel *model = [self.docArr objectAtIndex:indexPath.row];
        [self.dataManager RadiosDelete:model.scenicID];
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
    RadiosModel *model = [self.docArr objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", model.title, @"  的电台"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RadiosModel *model = [self.docArr objectAtIndex:indexPath.row];
    WLZ_Details_ViewController *detailsVC = [[[WLZ_Details_ViewController alloc] init] autorelease];
    detailsVC.scenicID = model.scenicID;
    [self.navigationController pushViewController:detailsVC animated:YES];
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
