//
//  WLZ_Music_ViewController.h
//  WLZ
//
//  Created by 왕닝 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseViewController.h"
#import "WLZ_Details_Model.h"
@interface WLZ_Music_ViewController : WLZBaseViewController

@property (nonatomic, copy) NSMutableArray *titleM;

@property (nonatomic, copy) NSString *musicVisitM;

@property (nonatomic, retain) NSString *playInfo;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger rowBegin;

@property (nonatomic, assign) NSInteger row;

@property (nonatomic, copy) NSString *titlePlay;

@property (nonatomic, copy) NSString *tingid;

@property (nonatomic, retain) WLZ_Details_Model *model1;

- (void)changeVCColor;

@property (nonatomic, retain) UIButton *playBefor;

@property (nonatomic, retain) UIButton *playB;

@property (nonatomic, retain) UIButton *playNext;

@property (nonatomic, retain) STKAudioPlayer *player;

+ (instancetype)sharePlayPageVC;
@end
