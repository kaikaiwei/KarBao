//
//  BaseData.h
//  esapsign
//
//  Created by Suzic on 14-9-2.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

// 定义协议，主要应用于异步请求，通知外部程序当前的请求状态
@protocol RequestManagerDelegate<NSObject>

// 异步请求开始通知外部程序
- (void)asynRequestStarted:(ASIHTTPRequest *)request;

// 异步请求失败通知外部程序
- (void)asynRequestFailed:(ASIHTTPRequest *)request;

// 异步请求结束通知外部程序
- (void)asynRequestFinished:(ASIHTTPRequest *)request;

@end

/*!
 请求管理类
 */
@interface RequestManager : NSObject

+(RequestManager *) defaultInstance;

- (void)registerDelegate:(id<RequestManagerDelegate>) delgate;

- (void)unRegisterDelegate:(id<RequestManagerDelegate>) delgate;

// 异步向服务器发送数据, 并返回发送请求的实例对象
- (ASIFormDataRequest *)asyncPostData:(NSString *)address Parameter:(NSDictionary *)para;

// 异步向服务器发送文件，并返回发送请求的实例对象
- (ASIFormDataRequest *)asyncPostData:(NSString *)address file:(NSString *)filePath isPDF:(BOOL)isPDF;

@end
