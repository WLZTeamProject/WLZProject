//
//  WLZNewsVideoModel.h
//  WLZ
//
//  Created by lqq on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseModel.h"

@interface WLZNewsVideoModel : WLZBaseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *hls_url;
@property (nonatomic, copy) NSString *editer_name;
@property (nonatomic, copy) NSString *play_channel;
@end
