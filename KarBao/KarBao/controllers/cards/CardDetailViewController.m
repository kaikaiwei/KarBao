//
//  CardDetailViewController.m
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "CardDetailViewController.h"
#import "QRUtil.h"

@implementation CardDetailViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


/**
 *  @abstract 更新二维码
 */
- (IBAction) updateQrCode:(id)sender
{
    NSLog(@"%s", __FUNCTION__);
    UIImage *img = [QRUtil generateUsingString:@"http://www.baidu.com"];
    self.qrcodeImageView.image = img;
    
    
}

@end
