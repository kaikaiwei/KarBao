//
//  QRUtil.h
//  qrcode
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "QrSearchViewController.h"



@interface QRUtil : NSObject

/**
 *  @abstract 根据信息生成二维码图片
 *  @param str 二维码图片的信息
 */
 
+(UIImage *) generateUsingString:(NSString *) str;

/**
 *  @abstract 在viewController模态弹出扫描界面
 *  @param viewController   以那个viewController作为模态弹出
 *  @param delegate QrSearchViewController的delegate。
 *  
 */
+(void) decodeWithViewController:(UIViewController *) viewController delegate:(id <QrSearchViewControllerDelegate>) delegate;

/**
 *  @abstract 在viewController模态弹出扫描界面
 *  @param viewController   以那个viewController作为模态弹出
 *  @param delegate QrSearchViewController的delegate。
 *  @param isFront true 调用前置摄像头
 */
+(void) decodeWithViewController:(UIViewController *) viewController delegate:(id <QrSearchViewControllerDelegate>) delegate isFront:(BOOL) isFront;

/**
 *  @abstract 在viewController模态弹出扫描界面
 *  @param viewController   以那个viewController作为模态弹出
 *  @param delegate QrSearchViewController的delegate。
 *  @param isFront true 调用前置摄像头
 *  @param isStore true 表明是商家模式； false 表明这是一个客户
 *  @param dict 生成二维码需要用到的信息字典
 */
+(void) decodeWithViewController:(UIViewController *) viewController delegate:(id <QrSearchViewControllerDelegate>) delegate isFront:(BOOL) isFront isStore:(BOOL) isStore dictionary:(NSDictionary *) dict;

@end
