//
//  QRUtil.m
//  qrcode
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "QRUtil.h"
#import "DataMatrix.h"
#import "QREncoder.h"
#import "QrCodeNavigationController.h"

@implementation QRUtil


/**
 *  @abstract 根据信息生成二维码图片
 *  @param str 二维码图片的信息
 */

+(UIImage *) generateUsingString:(NSString *) str
{
    
    if (!str || [str isEqualToString:@""]) {
        NSLog(@"Warning: the Encode string shouldn't be null.");
        return nil;
    }
    
    int qrcodeImageDimension = 250;
    
    DataMatrix* qrMatrix = [QREncoder encodeWithECLevel:QR_ECLEVEL_AUTO version:QR_VERSION_AUTO string:str];
    
    
    UIImage* qrcodeImage = [QREncoder renderDataMatrix:qrMatrix imageDimension:qrcodeImageDimension];
    
    return qrcodeImage;
}

/**
 *  @abstract 在viewController模态弹出扫描界面
 *
 */
+(void) decodeWithViewController:(UIViewController *) viewController delegate:(id <QrSearchViewControllerDelegate>) delegate
{
    QrSearchViewController *controller = [[QrSearchViewController alloc] init];
    controller.delegate = delegate;
    UINavigationController *nav = [[QrCodeNavigationController alloc] initWithRootViewController:controller];
    
    [viewController presentViewController:nav animated:YES completion:^{
        
    }];
}
/**
 *  @abstract 在viewController模态弹出扫描界面
 *
 */
+(void) decodeWithViewController:(UIViewController *) viewController delegate:(id <QrSearchViewControllerDelegate>) delegate isFront:(BOOL) isFront
{
    QrSearchViewController *controller = [[QrSearchViewController alloc] init];
    controller.delegate = delegate;
    if (isFront) {
        controller.cameraType = AVCaptureDevicePositionFront;
    }
    
    UINavigationController *nav = [[QrCodeNavigationController alloc] initWithRootViewController:controller];
    
    [viewController presentViewController:nav animated:YES completion:^{
        
    }];
}





@end
