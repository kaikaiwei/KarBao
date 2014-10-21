//
//  NSDate+Additions.h
//  PdfEditor
//
//  Created by Liuxiaowei on 14-3-27.
//  Copyright (c) 2014年 MinwenYi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(Additions)

// 将标准时间转换为本地时间
+ (NSDate *)convertDateToLocalTime: (NSDate *)forDate;

/**
 *  @abstract 从str中转换成为date对象，格式为：yyyy-MM-dd HH:mm:ss
 */
+ (NSDate *) covertDateFromString:(NSString *) str;

/*!
 生成yyyy/m/d格式的字符串
 @return 生成的字符串
 */
- (NSString *)shortDateString;

/*!
 生成yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)fullDateString;

@end
