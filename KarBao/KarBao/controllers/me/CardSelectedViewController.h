//
//  CardSelectedViewController.h
//  KarBao
//
//  Created by Caland on 14-10-20.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface CardSelectedViewController : UIViewController

//用于生成二维码信息
@property (nonatomic, retain) Card *card;
@property (nonatomic, retain)IBOutlet UIImageView *qrcodeView;

/**
 *  @abstract 刷新二维码
 *
 */
- (IBAction) resetQrCodeImage:(id)sender;

@end
