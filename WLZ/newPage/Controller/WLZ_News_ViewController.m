//
//  WLZ_News_ViewController.m
//  WLZ
//
//  Created by 왕닝 on 16/1/19.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_News_ViewController.h"
#import "WLZ_PCH.pch"
#import "WLZ_Happy_CollectionViewCell.h"
#import "WLZ_Korean_CollectionViewCell.h"
#import "WLZ_News_Details_ViewController.h"
#import "WLZ_News_Model.h"

@interface WLZ_News_ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, WLZReadListHotCellDelegate>

@property (nonatomic, retain) UICollectionView *collectionV;

@property (nonatomic, retain) NSMutableArray *happyArr;

@property (nonatomic, retain) NSMutableArray *koreanArr;

@property (nonatomic, retain) UIButton *koearButton;

@property (nonatomic, retain) UIButton *happyButton;

@end

@implementation WLZ_News_ViewController
- (void)dealloc
{
    [_collectionV release];
    [_happyArr release];
    [_koreanArr release];
    [_koearButton release];
    [_happyButton release];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"night" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"day" object:nil];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self creatView];
    self.navigationItem.title = @"资讯";
}

- (void)creatView
{
    [self creatCollectionView];
    
    
    [self creatButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationNightAction) name:@"night" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationDayAction) name:@"day" object:nil];
}
- (void)notificationNightAction
{
    self.koearButton.backgroundColor = [UIColor colorWithRed:0.439 green:0.439 blue:0.439 alpha:1.0];
    self.happyButton.backgroundColor = [UIColor colorWithRed:0.439 green:0.439 blue:0.439 alpha:1.0];
}
- (void)notificationDayAction
{
    self.koearButton.backgroundColor = [UIColor colorWithRed:0.9897 green:0.9897 blue:0.9897 alpha:1.0];
    self.happyButton.backgroundColor = [UIColor colorWithRed:0.9897 green:0.9897 blue:0.9897 alpha:1.0];
    
}
- (void)creatButton
{
    self.koearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.koearButton.frame = CGRectMake(0, 0, WIDTH / 2, 50);
    self.koearButton.backgroundColor = [UIColor colorWithRed:0.439 green:0.439 blue:0.439 alpha:1.0];
    self.koearButton.selected = YES;
    [self.koearButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.koearButton setTitle:@"韩国" forState:UIControlStateNormal];
    [self.koearButton setTitleColor:[UIColor colorWithWhite:0.800 alpha:1.000] forState:UIControlStateNormal];
    [self.koearButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.view addSubview:self.koearButton];
    
    self.happyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.happyButton.frame = CGRectMake(WIDTH / 2, 0, WIDTH / 2, 50);
    self.happyButton.backgroundColor = [UIColor colorWithRed:0.439 green:0.439 blue:0.439 alpha:1.0];
    self.happyButton.selected = NO;
    [self.happyButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.happyButton setTitle:@"娱乐" forState:UIControlStateNormal];
    [self.happyButton setTitleColor:[UIColor colorWithWhite:0.800 alpha:1.000] forState:UIControlStateNormal];
    [self.happyButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.view addSubview:self.happyButton];
    
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"night"]) {
       self.koearButton.backgroundColor = [UIColor colorWithRed:0.439 green:0.439 blue:0.439 alpha:1.0];
        self.happyButton.backgroundColor = [UIColor colorWithRed:0.439 green:0.439 blue:0.439 alpha:1.0];
    } else {
        self.koearButton.backgroundColor = [UIColor colorWithRed:0.9897 green:0.9897 blue:0.9897 alpha:1.0];
        self.happyButton.backgroundColor = [UIColor colorWithRed:0.9897 green:0.9897 blue:0.9897 alpha:1.0];
    }
}

#pragma 按键随着界面动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / WIDTH;
    if (index != 0) {
        self.koearButton.selected = NO;
        self.happyButton.selected = YES;
    } else {
        self.koearButton.selected = YES;
        self.happyButton.selected = NO;
    }
}
#pragma 界面随着按键动

- (void)buttonAction:(UIButton *)sender
{
    
    if (self.koearButton == sender) {
        
        self.collectionV.contentOffset = CGPointMake(0, 0);
        self.koearButton.selected = YES;
        self.happyButton.selected = NO;
    } else {
        self.collectionV.contentOffset = CGPointMake(UIWIDTH, 0);
        
        self.koearButton.selected = NO;
        self.happyButton.selected = YES;
    }
    [self.koearButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [self.happyButton setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    NSLog(@"%0.2f", self.collectionV.contentOffset.x);
}


- (void)creatCollectionView
{
    UICollectionViewFlowLayout *flowL = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowL.minimumInteritemSpacing = 0;
    flowL.minimumLineSpacing = 0;
    flowL.itemSize = CGSizeMake(UIWIDTH, UIHEIGHT);
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, UIWIDTH, UIHEIGHT) collectionViewLayout:flowL];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.pagingEnabled = YES;
    self.collectionV.bounces = NO;
    self.collectionV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionV];
    [_collectionV release];
    [self.collectionV registerClass:[WLZ_Happy_CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

//个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}
// 注册cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLZ_Happy_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.num = (indexPath.row + 1);
    return cell;
}
- (void)didSelectedHandle:(WLZ_News_Model *)model
{
    WLZ_News_Details_ViewController *webVC = [[WLZ_News_Details_ViewController alloc] init];
    webVC.sourceWebUrl = model.sourceWebUrl;
    [self.navigationController pushViewController:webVC animated:YES];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
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
