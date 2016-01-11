//
//  WLZ_Base_Model.h
//  WLZ
//
//  Created by 왕닝 on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLZ_Base_Model : NSObject

- (instancetype)initWithDic:(NSDictionary *)dic;

+ (instancetype)baseModelWithDic:(NSMutableDictionary *)dic;

+ (NSMutableArray *)baseModelWithArr:(NSMutableArray *)arr;

@property (nonatomic, copy) NSString *mid;

@end
