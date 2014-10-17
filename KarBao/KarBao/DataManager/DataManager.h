//
//  DataManager.h
//  KarBao
//
//  Created by Caland on 14-10-17.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>


#define DBFileName  @"KarBao.data"

//[self.objectContext deleteObject:obj]; //删除数据

@interface DataManager : NSObject


/**
 *  @abstract 单实例模式
 *
 */
+ (DataManager *) defaultInstance;

/**
 *  @abstract 保存数据
 *
 */
- (void) saveContext;

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
                       orderBy:(NSArray *)sortDescriptors;

@end
