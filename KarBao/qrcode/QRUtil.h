//
//  QRUtil.h
//  qrcode
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QRUtil : NSObject

/**
 *  @abstract 根据信息生成二维码图片
 *  @param str 二维码图片的信息
 */
 
+(UIImage *) generateUsingString:(NSString *) str;

/**
 *  @abstract 在viewController模态弹出扫描界面
 *  
 */
+(void) decodeWithViewController:(UIViewController *) viewController;


@end
