//
//  InfoViewController.m
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "InfoViewController.h"
#import "QRUtil.h"
#import "Util.h"
#import "NSObject+DelayBlocks.h"
#import "NSDate+Additions.h"
#import "DataManager+Card.h"
#import "CardSelectedListViewController.h"
#import "CardSelectedViewController.h"


@interface InfoViewController () <QrSearchViewControllerDelegate>
{
}
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化商户信息
    Account *acct = [Util loginAccount];
    UIImage *img = [QRUtil generateUsingString:[NSString stringWithFormat:@"%@_%@", acct.username, [[NSDate date] fullDateString]]];
    self.qrcodeView.image = img;

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
    
    [QRUtil decodeWithViewController:self delegate:self isFront:YES isStore:YES dictionary:@{QRDicInfoKey:[Util currentLoginUserId]}];
    
}

/**
 *  更新卡片内容
 */
- (IBAction) resetCard:(id)sender
{
    Account *acct = [Util loginAccount];
    UIImage *img = [QRUtil generateUsingString:[NSString stringWithFormat:@"%@_%@", acct.username, [[NSDate date] fullDateString]]];
    self.qrcodeView.image = img;
}

/**
 *  刷卡
 */
- (IBAction) flushCard:(id)sender
{
    [QRUtil decodeWithViewController:self delegate:self isFront:YES];
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
 *  @abstract 用户模式下扫描结束
 *
 */
- (void) qrCodeViewController:(QrSearchViewController *)qrCodeViewController didFinishedCustomWithString:(NSString *)str
{
    //商家的信息就只有一个商家的id
    DataManager *manager = [DataManager defaultInstance];
    
    NSDictionary *dict = @{@"cardid" : [Util generateUUID],
                           @"cardname" : @"KarBao Test",
                           @"carduser" : [Util currentLoginUserId],
                           @"createuser" : str,
                           @"createtime" : [NSDate date]};
    Card *aCard = [manager syncCard:dict];
    CardSelectedViewController *viewController = (CardSelectedViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"CardSelected"];
    viewController.card = aCard;
    
    [self.navigationController pushViewController:viewController animated:YES];    
}

/**
 *  @abstract 店家模式下扫描结束
 *
 */
- (void) qrCodeViewController:(QrSearchViewController *)qrCodeViewController didFinishedStoreWithString:(NSString *)str
{
    //店家扫完商家的信息后需要进行判断，如果是我家店的信息，那么久可以用
    //店家扫描得到的信息目前由三部分组成：店家id_用户id_时间
    NSArray *arr = [str componentsSeparatedByString:@"_"];
    if (arr.count != 3) {
        return ;
    }
    
    NSString *storeid = [arr objectAtIndex:0];
    NSString *cardid = [arr objectAtIndex:1];
    NSString *time = [arr objectAtIndex:2];
    
    //时间验证
    NSDate *date = [NSDate covertDateFromString:time];
    NSDate *now = [NSDate date];
    //5分钟之内
    if (now.timeIntervalSince1970 - date.timeIntervalSince1970 > 300)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"二维码已超时，戳它试试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return ;
    }
    
    NSLog(@"已经刷卡,cardid: %@, in store num:%@", cardid, storeid);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"交易成功" message:[NSString stringWithFormat:@"card：%@\n store:%@", cardid, storeid] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
    
}


@end
