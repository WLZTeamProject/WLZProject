//
//  WLZ_Music_ViewController.m
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Music_ViewController.h"
#import "WLZ_PCH.pch"
#import "WLZ_List_CollectionViewCell.h"
#import "WLZ_Play_CollectionViewCell.h"
#import "WLZ_ Introduce_CollectionViewCell.h"
#import "WLZ_Other_CollectionViewCell.h"
#import "WLZ_List_Model.h"
#import "WLZ_Other_Model.h"
#import "WLZ_OtherO_Model.h"
@interface WLZ_Music_ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, retain) NSMutableArray *userinfoArr;

@property (nonatomic, retain) NSMutableArray *authorinfoArr;
@property (nonatomic, retain) UICollectionView *collectionV;
@property (nonatomic, retain) NSMutableArray *radionameArr;
@property (nonatomic, retain) NSMutableArray *coverimgArr;

@end

@implementation WLZ_Music_ViewController

- (void)dealloc
{
    [_userinfoArr release];
    [_authorinfoArr release];
    [_collectionV release];
    [_radionameArr release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    //创建
    [self creatView];
    [self getData];
}

//创建视图
- (void)creatView
{
    [self creatCollectionView];
    [self creatPlayer];
}

- (void)creatPlayer
{
    UIView *imageV = [UIView new];
    imageV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageV];
    
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@60);
        make.width.equalTo(@(WIDTH));
        
    }];
    
    
    UIButton *PlayB =[UIButton new];
    [PlayB setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    [PlayB addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:PlayB];
    
    UIButton *PlayBefor =[UIButton new];
    [PlayBefor setImage:[UIImage imageNamed:@"shangyiqu"] forState:UIControlStateNormal];
    [PlayBefor addTarget:self action:@selector(beforAction) forControlEvents:UIControlEventValueChanged];
    [imageV addSubview:PlayBefor];
    
    UIButton *PlayNext =[UIButton new];
    [PlayNext setImage:[UIImage imageNamed:@"xiayiqu"] forState:UIControlStateNormal];
    [PlayNext addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventValueChanged];
    [imageV addSubview:PlayNext];
    
    
    
    [PlayBefor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV).with.offset(20);
        make.bottom.equalTo(imageV).with.offset(-20);
        make.left.equalTo(imageV).with.offset(90);
        make.right.equalTo(PlayB).with.offset(-90);
        make.height.mas_equalTo(PlayBefor.mas_width);
    }];
    
    [PlayB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV).with.offset(15);
        make.bottom.equalTo(imageV).with.offset(-15);
        make.width.equalTo(PlayB.mas_height);
        
    }];
    [PlayNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV).with.offset(20);
        make.bottom.equalTo(imageV).with.offset(-20);
        make.left.equalTo(PlayB).with.offset(90);
        make.right.equalTo(imageV).with.offset(-90);
        make.height.mas_equalTo(PlayNext.mas_width);

        
    }];
    

}

//创建collectionView
- (void)creatCollectionView
{
    UICollectionViewFlowLayout *flowL = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowL.minimumInteritemSpacing = 0;
    flowL.minimumLineSpacing = 0;
    flowL.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //    self.view.backgroundColor = [UIColor magentaColor];
    self.collectionV = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowL];
    self.collectionV.delegate = self;
    self.collectionV.dataSource = self;
    self.collectionV.pagingEnabled = YES;
    self.collectionV.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.collectionV];

    [self.collectionV registerClass:[WLZ_List_CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.collectionV registerClass:[WLZ_Play_CollectionViewCell class] forCellWithReuseIdentifier:@"cell1"];
    [self.collectionV registerClass:[WLZ__Introduce_CollectionViewCell class] forCellWithReuseIdentifier:@"cell2"];
    [self.collectionV registerClass:[WLZ_Other_CollectionViewCell class] forCellWithReuseIdentifier:@"cell3"];


}
//个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}
// 注册cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {

        WLZ_List_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor greenColor];
//        cell.delegate = self;
        cell.titleML = self.titleM;
        cell.musicVisitML = self.musicVisitM;
        
        return cell;
    }
    if (1 == indexPath.row) {
        
        WLZ_Play_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor blueColor];
        [cell.headImageV sd_setImageWithURL:[NSURL URLWithString:self.coving]];
        cell.headImageV.layer.cornerRadius = (WIDTH - 60) / 2;
        cell.titleL.text = self.titlePlay;
        cell.titleL.font = [UIFont systemFontOfSize:27];
        return cell;
    }
    if (2 == indexPath.row) {
        
        WLZ__Introduce_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        cell.url = self.playInfo;
        return cell;
    }
    if (3 == indexPath.row) {
        
        WLZ_Other_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell3" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor magentaColor];
        if (0 != self.userinfoArr.count) {
            
        WLZ_Other_Model *model = self.userinfoArr[indexPath.section];
        cell.mainL.text = model.uname;
        [cell.mainImageV sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        WLZ_OtherO_Model *model1 = self.authorinfoArr[indexPath.section];
            cell.originalL.text = model1.uname;
            [cell.originalImageV sd_setImageWithURL:[NSURL URLWithString:model1.icon]];
            WLZ_Other_Model *modelR = self.radionameArr[indexPath.section];
            cell.comfromL.text = modelR.radioname;
;
//            NSArray *arr = [NSArray arrayWithObjects:cell.imageOne, cell.imageTwo, cell.imageThree, cell.imageFore, cell.imageFive, cell.imageSix, nil];


            WLZ_Other_Model *modelM = self.coverimgArr[indexPath.section];
//            [cell.imageOne sd_setImageWithURL:[NSURL URLWithString:[self.coverimgArr[0] objectForKey:@"coverimg"]]];
//            [cell.imageTwo sd_setImageWithURL:[NSURL URLWithString:modelM.coverimg]];
//            [cell.imageThree sd_setImageWithURL:[NSURL URLWithString:modelM.coverimg]];
//            [cell.imageFore sd_setImageWithURL:[NSURL URLWithString:modelM.coverimg]];
//            [cell.imageFive sd_setImageWithURL:[NSURL URLWithString:modelM.coverimg]];
//            [cell.imageSix sd_setImageWithURL:[NSURL URLWithString:modelM.coverimg]];
            
            NSLog(@"%@", modelM.coverimg);
        }
        return cell;
    }
//    [self.collectionV reloadData];
    return nil;
}

- (void)playAction
{
//    self.view.backgroundColor = [UIColor redColor];
    NSLog(@"11111111111");
}


//获取数据
- (void)getData
{
    self.userinfoArr = [NSMutableArray array];
    self.authorinfoArr = [NSMutableArray array];
    self.radionameArr = [NSMutableArray array];
    self.coverimgArr = [NSMutableArray array];
    NSString *url = @"http://api2.pianke.me/ting/info";
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"PHPSESSID=9k56q745e4pr1anujo0fis8p10" forKey:@"Cookie"];
    NSString *body = [NSString stringWithFormat:@"auth=&client=1&deviceid=FC88C466-6C29-47E4-B464-AAA1DA196931&tingid=%@&version=3.0.6", self.tingid];
    [LQQAFNetTool postNetWithURL:url body:body bodyStyle:LQQRequestNSString headFile:dic responseStyle:LQQJSON success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableDictionary *dataDic = [responseObject objectForKey:@"data"];
        NSMutableDictionary *userinfoDic = [dataDic objectForKey:@"userinfo"];
        NSMutableDictionary *authorinfoDic = [dataDic objectForKey:@"authorinfo"];
//        NSMutableDictionary *radionameDic = [dataDic objectForKey:@"radioname"];
       WLZ_Other_Model *model = [WLZ_Other_Model baseModelWithDic:userinfoDic];
        WLZ_OtherO_Model *model1 = [WLZ_OtherO_Model baseModelWithDic:authorinfoDic];
        WLZ_Other_Model *modelR = [WLZ_Other_Model baseModelWithDic:dataDic];
        [self.userinfoArr addObject:model];
        [self.authorinfoArr addObject:model1];
        [self.radionameArr addObject:modelR];
        
        NSMutableArray *moretingArr = [dataDic objectForKey:@"moreting"];
        for (NSMutableDictionary *dic in moretingArr) {
            WLZ_Other_Model * modelM = [WLZ_Other_Model baseModelWithDic:dic];
            [self.coverimgArr addObject:modelM];
        }
//        WLZ_Other_Model *modelM = [WLZ_Other_Model baseModelWithArr:moretingArr];
        
        [self.collectionV reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
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
