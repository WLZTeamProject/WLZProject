//
//  WLZ_Base_Model.m
//  WLZ
//
//  Created by 왕닝 on 16/1/10.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import "WLZ_Base_Model.h"

@implementation WLZ_Base_Model

- (void)dealloc
{
    [_mid release];
    [super dealloc];
}

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)baseModelWithDic:(NSMutableDictionary *)dic
{
    // 使用多态的方式进行对象的创建.
    id obj = [[[self class] alloc] initWithDic:dic];
    return [obj autorelease];
}

+ (NSMutableArray *)baseModelWithArr:(NSMutableArray *)arr
{
    // 创建一个数组, 用来装model
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NSMutableDictionary *dic in arr) {
        @autoreleasepool {
            // 通过便利构造器方式创建对象.
            id model = [[self class] baseModelWithDic:dic];
            // 把对象添加到数组中
            [modelArr addObject:model];
        }
    }
    return modelArr;
    
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
        self.mid = value;
    }
    
}
- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}


@end
