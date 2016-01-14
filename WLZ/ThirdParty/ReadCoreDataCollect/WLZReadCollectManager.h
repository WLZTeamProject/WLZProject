//
//  WLZReadCollectManager.h
//  WLZ
//
//  Created by lqq on 16/1/14.
//  Copyright © 2016年 lwz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ReadCollection;
@interface WLZReadCollectManager : NSObject

- (void)addData:(ReadCollection *)model;//添加数据
- (void)deleteData:(NSString *)mid;
@end
