//
//  LQQCoreDataManager.h
//  CoreData
//
//  Created by lqq on 16/1/8.
//  Copyright © 2016年 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//加载模型文件->指定数据存储路径->创建对应数据类型的存储->创建管理对象上下方并指定存储。
@interface LQQCoreDataManager : NSObject
//管理上下文
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模型器
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//连接器
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//保存数据
- (void)saveContext;
//沙盒路径
- (NSURL *)applicationDocumentsDirectory;
//单例
+ (instancetype)sharaCoreDataManager;


//查询
- (NSMutableArray *)readSearch;
//删除
- (void)readDelete:(NSString *)mid;
@end
