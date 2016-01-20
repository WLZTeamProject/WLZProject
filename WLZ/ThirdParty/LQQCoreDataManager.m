//
//  LQQCoreDataManager.m
//  CoreData
//
//  Created by lqq on 16/1/8.
//  Copyright © 2016年 lqq. All rights reserved.
//

#import "LQQCoreDataManager.h"
#define COREDATA_MODEL_NAME @"WLZ"
#define COREDATA_SQLITE_NAME @"WLZ.sqlite"
#import "DocModel.h"
#import "RadiosModel.h"
@implementation LQQCoreDataManager

//单例
+ (instancetype)sharaCoreDataManager
{
    static LQQCoreDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LQQCoreDataManager alloc] init];
    });
    return manager;
}

#pragma mark - Core Data stack
//被管理对象上下文(数据管理器)
//重写set get方法时调用
@synthesize managedObjectContext = _managedObjectContext;
//数据模型器
@synthesize managedObjectModel = _managedObjectModel;
//数据连接器
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma 文件路径
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lqq.CoreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
#pragma 数据模型器
- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    //懒加载
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //momd 是 xcdatamodeld编译之后的类型, 工程名(同名), 获取本工程文件
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:COREDATA_MODEL_NAME withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
#pragma 数据连接器
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    //懒加载
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:COREDATA_SQLITE_NAME];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();//程序异常
    }
    
    return _persistentStoreCoordinator;
}

#pragma GET方法, 管理上下文
- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    //懒加载,如果存在直接返回,否则创建
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    //数据连接器
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    //1.管理上下文
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();//程序异常
        }
    }
}




#pragma 查询
- (NSMutableArray *)readSearch
{
    NSMutableArray *arr = [NSMutableArray array];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DocModel" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error: %@", error);
    }
    [arr setArray:fetchedObjects];
    return arr;    
}
#pragma 查询
- (NSMutableArray *)RadiosSearch
{
    NSMutableArray *arr = [NSMutableArray array];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RadiosModel" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error: %@", error);
    }
    [arr setArray:fetchedObjects];
    return arr;
}

//#pragma 删除
- (void)readDelete:(NSString *)mid
{
    for (DocModel *model in [self readSearch]) {
        if ([model.mid isEqualToString:mid]) {
            [self.managedObjectContext deleteObject:model];
        }
    }
    [self saveContext];
}
//#pragma 删除
- (void)RadiosDelete:(NSString *)scenicID
{
    for (RadiosModel *model in [self RadiosSearch]) {
        if ([model.scenicID isEqualToString:scenicID]) {
            [self.managedObjectContext deleteObject:model];
        }
    }
    [self saveContext];
}
@end
