//
//  CreateUserViewController.m
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "CreateUserViewController.h"

@interface CreateUserViewController ()

@end

@implementation CreateUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  @abstract 创建一个默认用户
 */
-(IBAction) createUser:(id)sender
{
    NSLog(@"%s", __FUNCTION__);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  @abstract 失去交点
 */
-(IBAction) dismissController:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
