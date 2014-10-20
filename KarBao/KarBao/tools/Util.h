//
//  Util.h
//  KarBao
//
//  Created by Caland on 14-10-17.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface Util : NSObject

/**
 *  @abstract 获得生成的一个uuid
 *  @return udid
 */
+ (NSString *) generateUUID;

/**
 *  @abstract 获得设备的udid
 *  @return udid
 */
+ (NSString *) getDeviceUDID;

/**
 *  @abstract 获得设备的名称
 *  @return udid
 */
+ (NSString *) getDeviceName;

/**
 *  @abstract 创建一个用户出来
 *  如果没有用户才会进行创建，否则不进行创建
 */
+ (void) initAccount;

/**
 *  @abstract 得到登陆用户的信息
 *
 */
+ (Account *) loginAccount;

/**
 *  @abstract 得到登陆用户的ID
 */
+ (NSString*)currentLoginUserId;

@end
