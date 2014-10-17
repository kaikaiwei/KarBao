//
//  Util.h
//  KarBao
//
//  Created by Caland on 14-10-17.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>

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




@end
