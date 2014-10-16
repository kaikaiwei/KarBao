//
//  CardDetailViewController.h
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardDetailViewController : UIViewController


@property (nonatomic, retain) IBOutlet UIButton *qrcodeButton;



/**
 *  @abstract 更新二维码
 */
- (IBAction) updateQrCode:(id)sender;


@end
