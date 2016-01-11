//
//  WLZRadioRootViewController.m
//  WLZ
//
//  Created by lqq on 16/1/9.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZRadioRootViewController.h"
#import "LQQAFNetTool.h"
@interface WLZRadioRootViewController ()

@end

@implementation WLZRadioRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    

}

- (void)getData
{
    NSString *str = @"http://v.dance365.com/api.php?type=top&dancetype=";
    [LQQAFNetTool getNetWithURL:str body:nil headFile:nil responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









@end
