//
//  Account.h
//  KarBao
//
//  Created by Caland on 14-10-20.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

//用户名
@property (nonatomic, retain) NSString *username;

//密码
@property (nonatomic, retain) NSString *password;

//设备id
@property (nonatomic, retain) NSString *devId;



@end
