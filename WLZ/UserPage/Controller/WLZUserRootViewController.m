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
#import "WLZ_Radios_Collection_ViewController.h"
@interface WLZUserRootViewController () <UITableViewDelegate, UITableViewDataSource, WLZUserTableViewCellDelegate>

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) UIImageView *imageV;
@end

@implementation WLZUserRootViewController
- (void)dealloc
{
    [_imageV release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"day" object:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"night"];
    [_arr release];
    [_tableView release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createView];
}
- (void)createView
{
    self.imageV = [[UIImageView alloc] initWithFrame:self.view.frame];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
        self.imageV.image = [UIImage imageNamed:@"user_bg"];
    } else {
        self.imageV.image = [UIImage imageNamed:@"user_bg_1"];
    }
    self.imageV.userInteractionEnabled = YES;
    [self.view addSubview:self.imageV];
    [self.imageV release];
    [self createTableView];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationNightAction) name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationDayAction) name:@"day" object:nil];
    
}
- (void)notificationNightAction
{
     self.imageV.image = [UIImage imageNamed:@"user_bg"];
    
}
- (void)notificationDayAction
{
    self.imageV.image = [UIImage imageNamed:@"user_bg_1"];
}


-(void)createTableView
{
    self.arr = [NSMutableArray arrayWithObjects:@"阅读收藏", @"电台收藏", @"夜间模式", @"清除缓存", nil];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
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
    if (2 != indexPath.row) {
        static NSString *cellStr = @"cell";
        WLZUserLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
        
        if (nil == cell) {
            cell = [[WLZUserLabelTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        }
        cell.layer.borderWidth = 1;
        cell.layer.cornerRadius = 5;
        cell.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = [self.arr objectAtIndex:indexPath.row];
        return cell;
    } else {
        static NSString *cellSStr = @"cellS";
        WLZUserTableViewCell *cell = [[WLZUserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSStr];
        cell.delegate = self;
        cell.layer.borderWidth = 1;
        cell.layer.cornerRadius = 5;
        cell.nightSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"night"];
         cell.layer.borderColor = [UIColor whiteColor].CGColor;
        cell.titleLabel.text = [self.arr objectAtIndex:indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)nightSwitchHandle:(UISwitch *)senderSwitch
{
    if (senderSwitch.on) {
        NSLog(@"夜间模式");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"night" object:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"night"];
    } else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"night"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"day" object:nil];
        NSLog(@"日间模式");
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *tempApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    WLZUserCollectViewController * collcetVC = nil;
    WLZ_Radios_Collection_ViewController *radiosCollectionVC = nil;
    switch (indexPath.row) {
        case 0:
        {
            [tempApp.leftVC closeLeftView];
            //跳转到收藏界面
            collcetVC = [[WLZUserCollectViewController alloc] init];
            UINavigationController *navNC = [[[UINavigationController alloc] initWithRootViewController:collcetVC] autorelease];
            navNC.navigationBar.translucent = NO;
            [self presentViewController:navNC animated:YES completion:^{
            }];
            [collcetVC release];
        }
            break;
        case 2:
            NSLog(@"夜间模式");
            break;
        case 3:
        {
            NSString *path = [[self class] getCachesDirectory];
            NSLog(@"%.2f", [[self class] folderSizeAtPath:path]);
            NSString *romNumber = [NSString stringWithFormat:@"%.2fM", [[self class] folderSizeAtPath:path]];
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"清除缓存" message:romNumber preferredStyle:UIAlertControllerStyleAlert];
            [alertC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[self class] clearCache:path];
                
            }]];
            [alertC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }]];
            [self presentViewController:alertC animated:YES completion:^{
            }];
        }
            break;
        case 1:
        {
            [tempApp.leftVC closeLeftView];
            //跳转到收藏界面
            radiosCollectionVC = [[WLZ_Radios_Collection_ViewController alloc] init];
            UINavigationController *navNC = [[[UINavigationController alloc] initWithRootViewController:radiosCollectionVC] autorelease];
            navNC.navigationBar.translucent = NO;
            [self presentViewController:navNC animated:YES completion:^{
            }];
            [radiosCollectionVC release];
        }
            break;
        default:
            break;
    }
    
    
}
#pragma mark - 获取沙盒Document的文件目录
+ (NSString *)getDocumentDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Library的文件目录
+ (NSString *)getLibraryDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Library/Caches的文件目录
+ (NSString *)getCachesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒Preference的文件目录
+ (NSString *)getPreferencePanesDirectory{
    return [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) lastObject];
}

#pragma mark - 获取沙盒tmp的文件目录
+ (NSString *)getTmpDirectory{
    return
    NSTemporaryDirectory();
}

////计算单个文件的大小
+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}


//计算目录大小
+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[[self class] fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
//清理缓存文件
+(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
