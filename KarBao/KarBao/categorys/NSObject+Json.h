//
//  NSObject+Json.h
//  PdfEditor
//
//  Created by Liuxiaowei on 14-5-16.
//  Copyright (c) 2014年 MinwenYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(Json)

/*!
 json encode
 */
- (NSString *)jsonString;

- (NSData *)jsonData;

/*!
 json decode
 */
- (id)jsonValue;

@end
