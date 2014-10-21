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
    BOOL isVerify;
}
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isVerify = YES;//默认是验证模式
    
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
    
    [QRUtil decodeWithViewController:self delegate:self];
    
}

/**
 *  更新卡片内容
 */
- (IBAction) resetCard:(id)sender
{
    Account *acct = [Util loginAccount];
    UIImage *img = [QRUtil generateUsingString:[NSString stringWithFormat:@"%@_%@", acct.username, [[NSDate date] fullDateString]]];
    self.qrcodeView.image = img;
//    self.qrcodeView.hidden = NO;
//    [self performBlock:^{
//        self.qrcodeView.hidden = YES;
//        NSLog(@"\n%s, the QRCode view has hidden.", __FUNCTION__);
//    } afterDelay:60.0];
    
}

/**
 *  刷卡
 */
- (IBAction) flushCard:(id)sender
{
    isVerify = NO;
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
    NSLog(@"%@", str);
    
    
    //数据验证
    NSArray *arr = [str componentsSeparatedByString:@"_"];
    if (arr.count != 2) {
        NSString *str2 = [str stringByAppendingString:@"，不符合规定"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str2 delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return ;
    }
    
    //时间验证
    NSDate *date = [NSDate covertDateFromString:[arr objectAtIndex:1]];
    NSDate *now = [NSDate date];
//    NSLog(@"%f,%f,%f", date.timeIntervalSince1970, now.timeIntervalSince1970, now.timeIntervalSince1970 - date.timeIntervalSince1970);
//    NSLog(@"%@, %@", date, now);
    
    //5分钟之内
    if (now.timeIntervalSince1970 - date.timeIntervalSince1970 > 300)
    {
        return ;
    }
    
    
    if (isVerify) {
        //验证模式
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"交易成功" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }else {
        //刷卡模式
        //需要进入另外一个页面，然后列出所有可用的卡片，点击卡片显示卡片的二维码，然后进行交易。（多个卡片）
        //或者直接弹出界面，直接进行交易。（单个卡片）
//        NSArray *cards = [[DataManager defaultInstance] getchObjsByCreateUser:[arr objectAtIndex:0]];
//        if (cards.count == 0) {
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有此处的会员卡，要不要戳一下？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"办理", nil];
//            [alert show];
//        }else if (cards.count ==1){
//            CardSelectedViewController *viewController = (CardSelectedViewController*) [self.storyboard instantiateViewControllerWithIdentifier:@"CardSelected"];
//            [self.navigationController pushViewController:viewController animated:YES];
//            viewController.card = [cards objectAtIndex:0];
//        }else if (cards.count > 1) {
//            CardSelectedListViewController *listViewController = (CardSelectedListViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"CardSelectedList"];
//            [self.navigationController pushViewController:listViewController animated:YES];
//            listViewController.storeinfo = [arr objectAtIndex:0];
//        }
        //根据店家生成一个card
        DataManager *manager = [DataManager defaultInstance];
        
        NSDictionary *dict = @{@"cardid" : [Util generateUUID],
                               @"cardname" : @"KarBao Test",
                               @"carduser" : [Util currentLoginUserId],
                               @"createuser" : [arr objectAtIndex:0],
                               @"createtime" : date};
        
        Card *aCard = [manager syncCard:dict];
        CardSelectedViewController *viewController = (CardSelectedViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"CardSelected"];
        viewController.card = aCard;
        [self.navigationController pushViewController:viewController animated:YES];
        isVerify = YES;
        
    }
}


@end
