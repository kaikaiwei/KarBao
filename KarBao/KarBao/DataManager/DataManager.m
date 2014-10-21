//
//  DataManager.m
//  KarBao
//
//  Created by Caland on 14-10-17.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "DataManager.h"


static DataManager *instance;




@interface DataManager ()

// 通用的对象存储管理
//@property (nonatomic, retain) NSManagedObjectContext *objectContext;
@property (nonatomic, retain) NSManagedObjectModel *objectModel;
@property (nonatomic, retain) NSPersistentStoreCoordinator *storeCoordinator;


@end

@implementation DataManager


/**
 *  @abstract 单实例模式
 *
 */
+ (DataManager *) defaultInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[DataManager alloc] init];
    });
    return instance;
}

- (id) init
{
    if (self == [super init]) {
        
        // 监听程序进入前后台
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterbackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillTerminate:)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];
    }
    return self;
}

/**
 *  @abstract 保存数据
 *
 */
- (void) saveContext
{
    NSError *error = nil;
    if (self.objectContext)
    {
        if ([self.objectContext hasChanges] && ![self.objectContext save:&error]) {
            NSAssert(nil, @"failed to saveContext. error:%@", error);
        }
    }
}


/**
 *  @abstract 抓取数据
 *  @entityName 数据库表名称
 *  @predicate 查询条件
 *  @limit  数据总数
 *  @offset 数据偏移量
 *  @sortDescriptors 排序描述符
 */
- (NSArray *)arrayFromCoreData:(NSString *)entityName
                     predicate:(NSPredicate *)predicate
                         limit:(NSUInteger)limit
                        offset:(NSUInteger)offset
                       orderBy:(NSArray *)sortDescriptors
{
    NSManagedObjectContext *context = [self objectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:context];
    
    [request setEntity:entity];
    
    if (sortDescriptors != nil && sortDescriptors.count > 0)
    {
        [request setSortDescriptors:sortDescriptors];
    }
    if (predicate)
    {
        [request setPredicate:predicate];
    }
    
    [request setFetchLimit:limit];
    [request setFetchOffset:offset];
    
    NSError *error = nil;
    NSArray *fetchObjects = [context executeFetchRequest:request error:&error];
    
    if (error)
    {
        NSLog(@"\nDataManager: Info \nfetch request error=%@", error);
        return nil;
    }
    
    return fetchObjects;
}


/**
 *  @abstract 在进入后台的时候保存数据
 */
- (void)applicationWillEnterbackground:(NSNotification *)notification
{
    [self saveContext];
}
/**
 *  @abstract 在程序退出的时候保存数据
 */
- (void)applicationWillTerminate:(NSNotification *)notification
{
    [self saveContext];
}


#pragma mark - Getter Methods here

- (NSManagedObjectContext *) objectContext
{
    if (!_objectContext) {
        NSPersistentStoreCoordinator *coordinator = [self storeCoordinator];
        NSAssert(coordinator != nil, @"failed to create NSPersistentStoreCoordinator");
        _objectContext = [[NSManagedObjectContext alloc] init];
        [_objectContext setStalenessInterval:0.0]; //强制性从磁盘装载
        [_objectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];//设置上下文对象合并策略
        [_objectContext setPersistentStoreCoordinator:coordinator];
    }
    return _objectContext;
}

- (NSManagedObjectModel *) objectModel
{
    if (!_objectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"KarBao" withExtension:@"momd"];
        NSAssert(modelURL != nil, @"clientInfo.momd couldn't be found");
        _objectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _objectModel;
}

- (NSPersistentStoreCoordinator *) storeCoordinator
{
    if (!_storeCoordinator) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [paths objectAtIndex:0];
        
        NSString *dbFilePath = [path stringByAppendingPathComponent:DBFileName];
        NSURL *dbURL = [NSURL fileURLWithPath:dbFilePath];
        NSError *error = nil;
        _storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self objectModel]];
        BOOL retry = NO;
        if (![_storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:dbURL
                                                   options:nil
                                                     error:&error])
        {
            retry = YES;
        }
        
        if (retry)
        {
            [[NSFileManager defaultManager] removeItemAtPath:dbFilePath error:&error];
            NSLog(@"deleting dbFilePath:%@ error:%@", dbFilePath, error);
            if (![_storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                 configuration:nil
                                                           URL:dbURL
                                                       options:nil
                                                         error:&error]) {
                NSAssert(nil, @"failed to setup persistentStoreCoordinator_. error:%@", error);
            }
        }
    }
    return _storeCoordinator;
}

@end
