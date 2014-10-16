//
//  NSObject+DelayBlocks.h
//  PdfEditor
//
//  Created by Liuxiaowei on 14-4-2.
//  Copyright (c) 2014年 MinwenYi. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 延迟执行扩展。有此需求请用这里的方法。
 */
@interface NSObject (DelayBlocks)

/*!
 在delay秒后执行block。
 @param block 打算执行的block。
 @param delay 延迟的时间，以秒计，可带小数
 */
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
