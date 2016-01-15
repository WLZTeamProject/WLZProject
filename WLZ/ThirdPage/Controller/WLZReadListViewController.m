//
//  WLZReadListViewController.m
//  WLZ
//
//  Created by lqq on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZReadListViewController.h"


#import "WLZReadListHotCell.h"
#import "WLZReadWebViewController.h"
#import "WLZReadListModel.h"
@interface WLZReadListViewController () <UICollectionViewDelegate, UICollectionViewDataSource, WLZReadListHotCellDelegate>
@property (nonatomic, retain) UICollectionView *collectV;
@property (nonatomic, retain) UIButton *hotButton;
@property (nonatomic, retain) UIButton *newsButton;
@end

@implementation WLZReadListViewController
- (void)dealloc
{
    [_hotButton release];
    [_newsButton release];
    [_collectV release];
    [_typle release];
    [_name release];
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"fanhui"] style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    // Do any additional setup after loading the view.
    //创建视图
    [self createSubviews];
   
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createSubviews
{
    self.navigationItem.title = self.name;
    self.tabBarController.tabBar.hidden = YES;//隐藏tabBar
    self.tabBarController.tabBar.translucent = YES;
    //底层collectionView
    [self createCollectionView];
    //按键
    [self createRightButton];
 
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}
#pragma 视图切换按键
- (void)createRightButton
{
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    rightView.backgroundColor = [UIColor clearColor];
    
    self.newsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.newsButton.frame = CGRectMake(0, 0, 30, 30);
    self.newsButton.selected = NO;
    [self.newsButton setImage:[UIImage imageNamed:@"nav_new"] forState:UIControlStateNormal];
    [self.newsButton setImage:[UIImage imageNamed:@"nav_new_1"] forState:UIControlStateSelected];
    [self.newsButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:self.newsButton];
    self.hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.hotButton.frame = CGRectMake(50, 0, 30, 30);
    self.hotButton.selected = YES;
    [self.hotButton setImage:[UIImage imageNamed:@"nav_hot"] forState:UIControlStateNormal];
    [self.hotButton setImage:[UIImage imageNamed:@"nav_hot_1"] forState:UIControlStateSelected];
    [self.hotButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:self.hotButton];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
}
#pragma 界面随着按键动

- (void)buttonAction:(UIButton *)sender
{
    
    if (self.newsButton == sender) {
        
        if (self.newsButton.selected == YES) {
            self.collectV.contentOffset = CGPointMake(0, 0);
        } else {
            self.collectV.contentOffset = CGPointMake(WIDTH, 0);
        }
        self.hotButton.selected = !self.hotButton.selected;
        
        
    } else {
        if (self.hotButton.selected == NO) {
            self.collectV.contentOffset = CGPointMake(0, 0);
        } else {
            self.collectV.contentOffset = CGPointMake(WIDTH, 0);
        }
       
        self.newsButton.selected = !self.newsButton.selected;
    }
    
    
     sender.selected = !sender.selected;
}
#pragma 创建视图
- (void)createCollectionView
{
    UICollectionViewFlowLayout *fwl = [[UICollectionViewFlowLayout alloc] init];
    fwl.itemSize = CGSizeMake(WIDTH, HEIGHT);
    fwl.minimumLineSpacing = 0;
    fwl.minimumInteritemSpacing = 0;
    fwl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectV = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:fwl];
    self.collectV.delegate = self;
    self.collectV.bounces = NO;
    self.collectV.pagingEnabled = YES;
    self.collectV.dataSource = self;
    [self.view addSubview:self.collectV];
    [_collectV release];
    [self.collectV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_offset(WIDTH);
        make.height.mas_equalTo(HEIGHT);
    }];
    
    [self.collectV registerClass:[WLZReadListHotCell class] forCellWithReuseIdentifier:@"new"];
    [self.collectV registerClass:[WLZReadListHotCell class] forCellWithReuseIdentifier:@"hot"];
}
#pragma 按键随着界面动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / WIDTH;
    if (index != 0) {
        self.newsButton.selected = YES;
        self.hotButton.selected = NO;
    } else {
        self.newsButton.selected = NO;
        self.hotButton.selected = YES;
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLZReadListHotCell *newcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"new" forIndexPath:indexPath];
    newcell.delegate = self;
    
    WLZReadListHotCell *hotcell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hot" forIndexPath:indexPath];
    hotcell.delegate = self;
    if (0 == indexPath.row) {
        newcell.sort = @"addtime";
        newcell.typleId = self.typle;
        return newcell;
    } else {
        hotcell.sort = @"hot";
        hotcell.typleId = self.typle;
        return hotcell;
    }
  
}

- (void)didSelectedHandle:(WLZReadListModel *)model
{
    WLZReadWebViewController *webVC = [[WLZReadWebViewController alloc] init];
    webVC.mId = model.mId;
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
