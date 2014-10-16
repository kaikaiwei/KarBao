//
//  NSDate+Additions.m
//  PdfEditor
//
//  Created by Liuxiaowei on 14-3-27.
//  Copyright (c) 2014年 MinwenYi. All rights reserved.
//

#import "NSDate+Additions.h"

@implementation NSDate(Additions)

+ (NSDate *)convertDateToLocalTime: (NSDate *)forDate
{
    NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
    int timeOffset = (int)[nowTimeZone secondsFromGMTForDate:forDate];
    NSDate *newDate = [forDate dateByAddingTimeInterval:timeOffset];
    return newDate;
}

/*!
 生成yyyy/m/d格式的字符串
 @return 生成的字符串
 */
- (NSString *)shortDateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy/M/d"];
    NSString *sdate = [dateFormat stringFromDate:self];
    
    return sdate;
}

/*!
 生成yyyy-mm-dd HH:MM:ss格式的字符串
 */
- (NSString *)fullDateString {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *sdate = [dateFormat stringFromDate:self];
    
    return sdate;
}

@end
