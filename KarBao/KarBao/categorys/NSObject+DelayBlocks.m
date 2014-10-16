//
//  NSObject+DelayBlocks.m
//  PdfEditor
//
//  Created by Liuxiaowei on 14-4-2.
//  Copyright (c) 2014年 MinwenYi. All rights reserved.
//

#import "NSObject+DelayBlocks.h"

@implementation NSObject (DelayBlocks)
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), block);
}
@end
