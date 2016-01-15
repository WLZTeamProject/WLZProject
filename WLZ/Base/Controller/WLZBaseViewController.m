//
//  WLZBaseViewController.m
//  WLZ
//
//  Created by lqq on 16/1/8.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseViewController.h"
#import "AppDelegate.h"
@interface WLZBaseViewController ()

@end

@implementation WLZBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"user"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(userAction)];
}
- (void)userAction
{
    AppDelegate *tempApp = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (tempApp.leftVC.closed) {
        [tempApp.leftVC openLeftView];
    } else {
        [tempApp.leftVC closeLeftView];
    }
    
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
