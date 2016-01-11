//
//  WLZBaseModel.h
//  WLZ
//
//  Created by lqq on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLZBaseModel : NSObject
@property (nonatomic, retain) NSString *mId;
- (instancetype)initWithDic:(NSMutableDictionary *)dic;
+ (instancetype)baseModelWithDic:(NSMutableDictionary *)dic;
+(NSMutableArray *)baseModelWithArr:(NSMutableArray *)arr;
@end
