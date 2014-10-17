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

@end
