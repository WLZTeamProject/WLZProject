//
//  WLZ_Dance_detailViewController.h
//  WLZ
//
//  Created by 邹邹邹雨 on 16/1/11.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseViewController.h"
@class WLZ_Dance_ListModel;
@interface WLZ_Dance_detailViewController : WLZBaseViewController
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, retain) WLZ_Dance_ListModel *zyDance;
@end
