//
//  QrSearchViewController.h
//  qrcode
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define QRBorderImageName @"qr_border"
#define QRLineImageName @"qr_line"
#define QRMessageText @"请将二维码/条形码放入框内,即可自动扫描"



@class QrSearchViewController;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  二维码扫描协议
@protocol QrSearchViewControllerDelegate <NSObject>
@optional

/**
 *  @abstract 二维码扫描结束
 */
- (void) qrCodeVideControllerCanceledSearch:(QrSearchViewController *) qrCodeViewController;

/**
 *  @abstract 二维码扫描结束
 */
- (void) qrCodeVideController:(QrSearchViewController *) qrCodeViewController didFinishedWithString:(NSString *) str;

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  二维码扫描视图控制器


@interface QrSearchViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

{
    int num;
    BOOL isDown;
}



@property (nonatomic, retain) id<QrSearchViewControllerDelegate> delegate;

@property (nonatomic, assign) AVCaptureDevicePosition cameraType;




@end
