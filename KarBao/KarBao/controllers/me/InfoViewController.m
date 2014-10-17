//
//  InfoViewController.m
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "InfoViewController.h"
#import "QRUtil.h"

@interface InfoViewController () <QrSearchViewControllerDelegate>

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private Method

/**
 *  @abstract 开始验证
 */
- (IBAction) startVerify:(id)sender
{
    NSLog(@"%s", __FUNCTION__);
    
    [QRUtil decodeWithViewController:self delegate:self];
    
}

#pragma mark - QrSearchViewControllerDelegate Methods
/**
 *  @abstract 二维码扫描结束
 */
- (void) qrCodeVideControllerCanceledSearch:(QrSearchViewController *) qrCodeViewController
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"扫描已取消" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

/**
 *  @abstract 二维码扫描结束
 */
- (void) qrCodeVideController:(QrSearchViewController *) qrCodeViewController didFinishedWithString:(NSString *) str
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}


@end
