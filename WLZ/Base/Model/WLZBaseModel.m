//
//  WLZBaseModel.m
//  WLZ
//
//  Created by lqq on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZBaseModel.h"

@implementation WLZBaseModel
- (void)dealloc
{
    [_mId release];
    [super dealloc];
}
/**
 *  初始化
 *
 *  @param dic 字典
 *
 *  @return
 */
- (instancetype)initWithDic:(NSMutableDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
/**
 *  KVC容错
 *
 *  @param value
 *  @param key
 */
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.mId = value;
    }
}
/**
 *  便利构造
 *
 *  @param dic
 *
 *  @return
 */
+ (instancetype)baseModelWithDic:(NSMutableDictionary *)dic
{
    id obj = [[[self class] alloc] initWithDic:dic];
    return [obj autorelease];
}

+(NSMutableArray *)baseModelWithArr:(NSMutableArray *)arr
{
    NSMutableArray *tempArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in arr) {
        [tempArr addObject:[[self class] baseModelWithDic:dic]];
    }
    return tempArr;
}
@end
