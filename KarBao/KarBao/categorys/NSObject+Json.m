//
//  NSObject+Json.m
//  PdfEditor
//
//  Created by Liuxiaowei on 14-5-16.
//  Copyright (c) 2014年 MinwenYi. All rights reserved.
//

#import "NSObject+Json.h"

@implementation NSObject(Json)

/*!
 json encode
 */
- (NSString *)jsonString {
    NSError *error = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        NSLog(@"Json Encode Error %@", error);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (NSData *)jsonData {
    NSError *error = nil;
    NSData *body = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) {
        NSLog(@"Json Encode Error %@", error);
        return nil;
    }
    
    return body;
}

/*!
 json decode
 */
- (id)jsonValue {
    NSData *_data = nil;
    if ([self isKindOfClass:[NSData class]]) {
        _data = (NSData *)self;
    } else if ([self isKindOfClass:[NSString class]]) {
        NSString *dataString = (NSString *)self;
        _data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    if (_data) {
        NSError *error = nil;
        id value = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:&error];
        
        if (error) {
            NSLog(@"Json Decode Error %@", error);
            return nil;
        }
        
        return value;
    }
    
    return nil;
}

@end
