//
//  CardSelectedViewController.m
//  KarBao
//
//  Created by Caland on 14-10-20.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "CardSelectedViewController.h"
#import "QRUtil.h"
#import "NSDate+Additions.h"


@implementation CardSelectedViewController


- (void) viewDidLoad
{
    [super viewDidLoad];
    UIImage *img = [QRUtil generateUsingString:[NSString stringWithFormat:@"%@_%@", card.cardid, [[NSDate date] fullDateString]]];
    self.qrcodeView.image = img;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Action Methods
/**
 *  @abstract 刷新二维码
 *
 */
- (IBAction) resetQrCodeImage:(id)sender
{
    UIImage *img = [QRUtil generateUsingString:[NSString stringWithFormat:@"%@_%@", card.cardid, [[NSDate date] fullDateString]]];
    self.qrcodeView.image = img;
}


@end
