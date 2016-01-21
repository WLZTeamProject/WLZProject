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
#import "WLZ_Details_Model.h"
@interface WLZ_Music_ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, RootViewDelegate>



@property (nonatomic, retain) NSMutableArray *userinfoArr;

@property (nonatomic, retain) NSMutableArray *authorinfoArr;
@property (nonatomic, retain) UICollectionView *collectionV;
@property (nonatomic, retain) NSMutableArray *radionameArr;
@property (nonatomic, retain) NSMutableArray *coverimgArr;

@end

@implementation WLZ_Music_ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"videoPlay" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"videoStop" object:nil];
    [_titleM release];
    [_musicVisitM release];
    [_playInfo release];
    [_url release];
    [_titlePlay release];
    [_tingid release];
    [_model1 release];
    [_userinfoArr release];
    [_authorinfoArr release];
    [_collectionV release];
    [_radionameArr release];
    [super dealloc];
}
#pragma 播放器单例
+ (instancetype)sharePlayPageVC
{
    static WLZ_Music_ViewController *playPVC = nil;
    
    static dispatch_once_t one;
    dispatch_once(&one, ^{
        if (nil == playPVC) {
            playPVC = [WLZ_Music_ViewController new];
        }
    });
    
    return playPVC;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
    [self.collectionV reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //创建
    [self creatView];
    [self getData];
    self.row = self.rowBegin;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    if ((STKAudioPlayerStatePlaying == self.player.state) || (STKAudioPlayerStatePaused == self.player.state))
    {
        [self changeVCColor];
    }
    else
    {
        [self playAction];
    }
    [self.collectionV reloadData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRadioPauseAction) name:@"videoPlay" object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationRadioResumeAction) name:@"videoStop" object:nil];
 
}
- (void)notificationRadioPauseAction
{
    [self.player pause];
}
-(void)notificationRadioResumeAction
{
    [self.player resume];
}
- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.navigationBarHidden = NO;
    
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
    imageV.userInteractionEnabled = YES;
    [self.view addSubview:imageV];
    
    
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.height.equalTo(@60);
        make.width.equalTo(@(WIDTH));
        
    }];
    
    
    self.playB =[UIButton new];
    [self.playB setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    [self.playB setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [self.playB addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:self.playB];
    
    UIButton *PlayBefor =[UIButton new];
    [PlayBefor setImage:[UIImage imageNamed:@"shangyiqu"] forState:UIControlStateNormal];
    [PlayBefor addTarget:self action:@selector(beforAction) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:PlayBefor];
    
    UIButton *PlayNext =[UIButton new];
    [PlayNext setImage:[UIImage imageNamed:@"xiayiqu"] forState:UIControlStateNormal];
    [PlayNext addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [imageV addSubview:PlayNext];
    
    STKAudioPlayerOptions playerOptions = {YES, YES, {50, 100, 200, 400, 800, 1600, 2600, 16000}};
    self.player = [[[STKAudioPlayer alloc] initWithOptions:playerOptions] autorelease];
    
    [PlayBefor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV).with.offset(20);
        make.bottom.equalTo(imageV).with.offset(-20);
        make.left.equalTo(imageV.mas_left).with.offset(70);
//        make.right.equalTo(self.playB);
        make.height.mas_equalTo(PlayBefor.mas_width);
    }];
    
    [self.playB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV).with.offset(15);
        make.bottom.equalTo(imageV).with.offset(-15);
        make.width.equalTo(@30);
        make.left.equalTo(PlayBefor).with.offset((WIDTH / 2 - 90));
        
    }];
    [PlayNext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageV).with.offset(20);
        make.bottom.equalTo(imageV).with.offset(-20);
        make.left.equalTo(self.playB).with.offset((WIDTH / 2 - 70));
        make.right.equalTo(imageV.mas_right).with.offset(-70);
        make.height.mas_equalTo(@20);

        
    }];
    

}

//创建collectionView
- (void)creatCollectionView
{
    UICollectionViewFlowLayout *flowL = [[[UICollectionViewFlowLayout alloc] init] autorelease];
    flowL.minimumInteritemSpacing = 0;
    flowL.minimumLineSpacing = 0;
    flowL.itemSize = CGSizeMake(UIWIDTH, UIHEIGHT);
    flowL.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIWIDTH, UIHEIGHT) collectionViewLayout:flowL];
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
    if (1 == indexPath.row) {
        WLZ_List_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.delegate = self;
        cell.titleML = self.titleM;
        cell.musicVisitML = self.musicVisitM;
        return cell;
    }
    if (0 == indexPath.row) {
        
        WLZ_Play_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
//        cell.delegate = self;
        WLZ_Details_Model *model = self.titleM[self.row];
        [cell.headImageV sd_setImageWithURL:[NSURL URLWithString:[model.playInfo objectForKey:@"imgUrl"]]];
        cell.headImageV.layer.cornerRadius = (WIDTH - 60) / 2;
        cell.titleL.text = [model.playInfo objectForKey:@"title"];
        cell.titleL.font = [UIFont systemFontOfSize:27];
        return cell;
    }
    if (2 == indexPath.row) {
        
        WLZ__Introduce_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
        WLZ_Details_Model *model = self.titleM[self.row];
        cell.url = [model.playInfo objectForKey:@"webview_url"];
        return cell;
    }
    if (3 == indexPath.row) {
        
        WLZ_Other_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell3" forIndexPath:indexPath];
        if (0 != self.userinfoArr.count) {
            
        WLZ_Other_Model *model = self.userinfoArr[indexPath.section];
        cell.mainL.text = model.uname;
        [cell.mainImageV sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        WLZ_OtherO_Model *model1 = self.authorinfoArr[indexPath.section];
            cell.originalL.text = model1.uname;
            [cell.originalImageV sd_setImageWithURL:[NSURL URLWithString:model1.icon]];
            WLZ_Other_Model *modelR = self.radionameArr[indexPath.section];
            cell.comfromL.text = modelR.radioname;
            WLZ_Other_Model *modelM = self.coverimgArr[indexPath.section];
            NSLog(@"%@", modelM.coverimg);
            if (0 != self.coverimgArr.count) {
                cell.imageArr = self.coverimgArr;
        }
        }
        return cell;
    }
    return nil;
}

- (void)changeVCColor
{
    [self.player stop];
    [self getData];
    STKAudioPlayerOptions playerOptions = {YES, YES, {50, 100, 200, 400, 800, 1600, 2600, 16000}};
    self.player = [[[STKAudioPlayer alloc] initWithOptions:playerOptions] autorelease];

    WLZ_Details_Model *model = self.titleM[self.row];
    [self.player play:model.musicUrl];
    
    self.playB.selected = YES;
    [self.collectionV reloadData];
}

- (void)playAction
{
    if (STKAudioPlayerStatePlaying == self.player.state) {
        //暂停
        [self.player pause];
        self.playB.selected = NO;
    } else if (STKAudioPlayerStatePaused == self.player.state){
        //继续
        [self.player resume];
        self.playB.selected = YES;
    } else{
        //播放
        WLZ_Details_Model *model = self.titleM[self.rowBegin];
        [self.player play:model.musicUrl];
        self.playB.selected = YES;
    }

    [self.collectionV reloadData];
}
- (void)audioPlayerStop
{
    [self.player stop];
}

- (void)nextAction
{
    self.row = (self.row + 1) % self.titleM.count;
    [self changeVCColor];
}

- (void)beforAction
{
    self.row = (self.row - 1 + self.titleM.count) % self.titleM.count;
    [self changeVCColor];
}

//- (void)exchangeVol:(float)vol
//{
//    self.player.volume = vol;
//}
//获取数据
- (void)getData
{
    [WLZ_GIFT show];
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
        
        [self.collectionV reloadData];
        [self playAction];
        [WLZ_GIFT dismiss];
        [self.collectionV reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
