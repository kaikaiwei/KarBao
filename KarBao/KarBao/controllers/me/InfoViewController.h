//
//  InfoViewController.h
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

/**
 *  二维码的
 */
@property (nonatomic, retain) IBOutlet UIImageView *qrcodeView;

/**
 *  @abstract 开始验证
 */
- (IBAction) startVerify:(id)sender;

/**
 *  更新卡片内容
 */
- (IBAction) resetCard:(id)sender;

/**
 *  刷卡
 */
- (IBAction) flushCard:(id)sender;

@end
