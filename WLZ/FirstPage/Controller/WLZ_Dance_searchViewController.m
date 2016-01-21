//
//  WLZ_Dance_searchViewController.m
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/18.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Dance_searchViewController.h"
#import "WLZ_Dance_searchdetailViewController.h"
@interface WLZ_Dance_searchViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, retain) UITableView *tableV;
@property (nonatomic, retain) UITextField *searchField;
@property (nonatomic, retain) UIButton *searchBut;
@property (nonatomic, retain) UIButton *cancelBut;
@property (nonatomic, retain) UIButton *jazzBut;
@property (nonatomic, retain) UIButton *solodanceBut;
@property (nonatomic, retain) UIButton *teachBut;
@property (nonatomic, retain) UIButton *childBut;
@property (nonatomic, retain) NSMutableArray *arr;
@property (nonatomic, retain) UIButton *deleteBut;
 //@property (nonatomic, retain)

@end

@implementation WLZ_Dance_searchViewController

- (void)dealloc
{
    [_tableV release];
    [_searchBut release];
    [_searchField release];
    [_cancelBut release];
    [_jazzBut release];
    [_solodanceBut release];
    [_teachBut release];
    [_childBut release];
    [_arr release];
    [_deleteBut release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//                                 colorWithRed:250 / 255.0 green:255 / 255.0 blue:207 / 255.0 alpha:1.0];

    self.arr = [NSMutableArray array];
    NSMutableArray *newArr = [NSMutableArray array];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"stuData.plist"];
//    [NSKeyedArchiver archiveRootObject:self.arr toFile:filePath];
    newArr = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    for (NSString *str in newArr) {
        [self.arr addObject:str];
    }
    [self createheadView];
    
}

- (void)createheadView
{
    
<<<<<<< HEAD
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, 160)];
//    view.backgroundColor = [UIColor colorWithRed:158 / 255.0 green:208 / 255.0 blue:91 / 255.0 alpha:1.0];
    view.backgroundColor = [UIColor whiteColor];
=======
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height / 10 * 3 + 10)];
    view.backgroundColor = [UIColor colorWithRed:210 / 255.0 green:150 / 255.0 blue:250 / 255.0 alpha:1.0];
>>>>>>> 31099704bd4f99ab4a35cfa2e90579693403f371
    [self.view addSubview:view];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    headView.backgroundColor = [UIColor blackColor];
    [view addSubview:headView];
    
    self.searchBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchBut.frame = CGRectMake(10, 5, [[UIScreen mainScreen] bounds].size.width / 7 , headView.frame.size.height - 10);
    self.searchBut.backgroundColor = [UIColor whiteColor];
    [self.searchBut setImage:[UIImage imageNamed:@"search2"] forState:UIControlStateNormal];
    [self.searchBut addTarget:self action:@selector(searchButAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.searchBut];
    
    self.searchField = [[UITextField alloc] initWithFrame:CGRectMake(self.searchBut.frame.size.width + self.searchBut.frame.origin.x, self.searchBut.frame.origin.y, self.searchBut.frame.size.width * 5 - 30, self.searchBut.frame.size.height)];
    self.searchField.clearButtonMode = UITextFieldViewModeAlways;
    self.searchField.placeholder = @"搜索";
    self.searchField.delegate = self;
    self.searchField.backgroundColor = [UIColor whiteColor];
    [headView addSubview:self.searchField];
    
    self.cancelBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBut.frame = CGRectMake(self.searchField.frame.size.width + self.searchField.frame.origin.x + 10, self.searchField.frame.origin.y, self.searchBut.frame.size.width, self.searchBut.frame.size.height);
    self.cancelBut.backgroundColor = [UIColor blackColor];
    [self.cancelBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelBut.alpha = 0.5;
    
  
    
    [self.cancelBut setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBut addTarget:self action:@selector(cancelButAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:self.cancelBut];
    
    
    UILabel *hotLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, headView.frame.size.height, [[UIScreen mainScreen] bounds].size.width, headView.frame.size.height / 2)];
//    hotLabel.backgroundColor = [UIColor blueColor];
    hotLabel.text = @"热门搜索";
    [view addSubview:hotLabel];
    
    
    self.jazzBut = [[UIButton alloc] initWithFrame:CGRectMake(20, hotLabel.frame.size.height + hotLabel.frame.origin.y, self.searchBut.frame.size.width, hotLabel.frame.size.height)];
    self.jazzBut.backgroundColor = [UIColor blackColor];
    [self.jazzBut setTitle:@"爵士" forState:UIControlStateNormal];
    self.jazzBut.tag = 10000;
    [self.jazzBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.jazzBut.layer.cornerRadius = hotLabel.frame.size.height / 2;
    [view addSubview:self.jazzBut];
    
    
    self.childBut = [[UIButton alloc] initWithFrame:CGRectMake(self.jazzBut.frame.size.width + self.jazzBut.frame.origin.x + 10, self.jazzBut.frame.origin.y, self.jazzBut.frame.size.width * 2, self.jazzBut.frame.size.height)];
    self.childBut.backgroundColor = [UIColor blackColor];
    self.childBut.layer.cornerRadius = hotLabel.frame.size.height / 2;
    self.childBut.tag = 10001;
    [self.childBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.childBut setTitle:@"儿童舞蹈" forState:UIControlStateNormal];
    [view addSubview:self.childBut];
    
    self.solodanceBut = [[UIButton alloc] initWithFrame:CGRectMake(self.childBut.frame.size.width + self.childBut.frame.origin.x + 10, self.jazzBut.frame.origin.y, self.jazzBut.frame.size.width, self.jazzBut.frame.size.height)];
    self.solodanceBut.backgroundColor = [UIColor blackColor];
    self.solodanceBut.layer.cornerRadius = hotLabel.frame.size.height / 2;
    self.solodanceBut.tag = 10002;
    [self.solodanceBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.solodanceBut setTitle:@"独舞" forState:UIControlStateNormal];
    [view addSubview:self.solodanceBut];
    
    self.teachBut = [[UIButton alloc] initWithFrame:CGRectMake(self.jazzBut.frame.origin.x, self.jazzBut.frame.origin.y + self.jazzBut.frame.size.height + 10, self.jazzBut.frame.size.width * 2, self.jazzBut.frame.size.height)];
    self.teachBut.backgroundColor = [UIColor blackColor];
    self.teachBut.layer.cornerRadius = hotLabel.frame.size.height / 2;
    self.teachBut.tag = 10003;
    [self.teachBut addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.teachBut setTitle:@"舞蹈教学" forState:UIControlStateNormal];
    [view addSubview:self.teachBut];
    
    UILabel *historyL = [[UILabel alloc] initWithFrame:CGRectMake(10, self.teachBut.frame.size.height + self.teachBut.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, hotLabel.frame.size.height)];
    historyL.text = @"搜索历史";
    [view addSubview:historyL];
    
    self.deleteBut = [UIButton buttonWithType:UIButtonTypeCustom];
    self.deleteBut.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - hotLabel.frame.size.height, [[UIScreen mainScreen] bounds].size.width, hotLabel.frame.size.height);
    self.deleteBut.backgroundColor = [UIColor blackColor];
//    [UIColor colorWithRed:201 / 255.0 green:0 blue:201 / 255.0 alpha:1.0];
    [self.deleteBut setTitle:@"清除所有搜索内容" forState:UIControlStateNormal];
    [self.deleteBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.deleteBut addTarget:self action:@selector(deleteButAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.deleteBut];
    
    self.tableV = [[UITableView alloc] initWithFrame:CGRectMake(0, view.frame.size.height + view.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - view.frame.size.height - self.deleteBut.frame.size.height - 20) style:UITableViewStylePlain];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableV];
    [_tableV release];
    
    [self.tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
   
    
    
    
}

//清除所有搜索
- (void)deleteButAction
{
    [self.arr removeAllObjects];
    [self.tableV reloadData];
    
}

- (void)buttonAction:(UIButton *)sender
{
    WLZ_Dance_searchdetailViewController *wlzDanceVC = [[WLZ_Dance_searchdetailViewController alloc] init];
    if (sender.tag == 10000) {
        wlzDanceVC.str = @"爵士";
    } else if (sender.tag == 10001) {
        wlzDanceVC.str = @"儿童舞蹈";
    } else if (sender.tag == 10002) {
        wlzDanceVC.str = @"独舞";
    } else if (sender.tag == 10003) {
        wlzDanceVC.str = @"舞蹈教学";
    }
    NSInteger num = 0;
    for (NSString *str in self.arr) {
        if ([wlzDanceVC.str isEqualToString:str]) {
            num = 1;
        }
    }
    if (0 == num) {
        [self.arr addObject:wlzDanceVC.str];
        [self.tableV reloadData];
    }

   
    UINavigationController *wlzDanceNC = [[UINavigationController alloc] initWithRootViewController:wlzDanceVC];
    [self presentViewController:wlzDanceNC animated:YES completion:^{
        
        
    }];
}

//隐藏tabBar
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)searchButAction
{
    NSInteger num = 0;
    if (self.searchField.text != nil) {
        for (NSString *str in self.arr) {
            if ([self.searchField.text isEqualToString:str]) {
                num = 1;
            }
        }
        if (0 == num) {
            
            [self.arr addObject:self.searchField.text];
            [self.tableV reloadData];
            
        }
        
    }
    WLZ_Dance_searchdetailViewController *wlzdetailVC = [[WLZ_Dance_searchdetailViewController alloc] init];
    wlzdetailVC.str = self.searchField.text;
    UINavigationController *wlzdetailNC = [[UINavigationController alloc] initWithRootViewController:wlzdetailVC];
   [self presentViewController:wlzdetailNC animated:YES completion:^{
       
       
   }];

}

- (void)cancelButAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.tabBarController.tabBar setHidden:NO];
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [path stringByAppendingPathComponent:@"stuData.plist"];
    [NSKeyedArchiver archiveRootObject:self.arr toFile:filePath];
}


//回收键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [self.arr objectAtIndex:indexPath.row];
    WLZ_Dance_searchdetailViewController *wlzdetailVC = [[WLZ_Dance_searchdetailViewController alloc] init];
    wlzdetailVC.str = str;
    UINavigationController *wlzdetailNC = [[UINavigationController alloc] initWithRootViewController:wlzdetailVC];
    [self presentViewController:wlzdetailNC animated:YES completion:^{
        
        
    }];

}

//删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
        [self.arr removeObjectAtIndex:indexPath.row];
        [self.tableV reloadData];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableV setEditing:editing animated:animated];
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [self.arr objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = str;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
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
