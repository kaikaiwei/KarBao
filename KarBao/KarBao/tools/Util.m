//
//  Util.m
//  KarBao
//
//  Created by Caland on 14-10-17.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "Util.h"

@implementation Util


/**
 *  @abstract 获得生成的一个uuid
 *  @return udid
 */
+ (NSString *) generateUUID
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuidRef = CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
    NSString *uuidString = (__bridge NSString *)uuidRef;
    return uuidString;
}

/**
 *  @abstract 获得设备的udid
 *  @return udid
 */
+ (NSString *) getDeviceUDID
{
    return [UIDevice currentDevice].identifierForVendor.UUIDString;
}

/**
 *  @abstract 获得设备的名称
 *  @return udid
 */
+ (NSString *) getDeviceName
{
    return [UIDevice currentDevice].name;
}

/**
 *  @abstract 创建一个用户出来
 *  如果没有用户才会进行创建，否则不进行创建
 */
+ (void) initAccount
{
    if (![self valueForKey:LoginAccount]) {
        Account *acct = [[Account alloc] init];
        acct.username = [self generateUUID];
        acct.devId = [self getDeviceUDID];
        
        NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:acct];
        [Util setValue:userData forKey:LoginAccount];
    }
}

/**
 *  @abstract 得到登陆用户的信息
 *
 */
+ (Account *) loginAccount
{
    NSData *data = [self valueForKey:LoginAccount];
    if (data) {
        Account *acct = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        return acct;
    }
    return nil;
}

/**
 *  @abstract 得到登陆用户的ID
 */
+ (NSString*)currentLoginUserId
{
    NSData *data = [self valueForKey:LoginAccount];
    if (data) {
        Account *acct = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        return acct.username;
    }
    return nil;
}



/*!
 本地读取指定key的缓存值
 */
+ (id)valueForKey:(NSString *)key {
    NSUserDefaults *nd = [NSUserDefaults standardUserDefaults];
    return [nd valueForKey:key];
}
/*!
 存储一个值到本地
 */
+ (void)setValue:(id)value forKey:(NSString *)key {
    NSUserDefaults *nd = [NSUserDefaults standardUserDefaults];
    [nd setObject:value forKey:key];
    [nd synchronize];
}

@end
