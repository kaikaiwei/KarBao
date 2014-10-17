//
//  TabbarManager.m
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "TabbarManager.h"

static TabbarManager *instance;

@implementation TabbarManager


/**
 *  @abstract 单例入口
 */
+(TabbarManager *) defaultInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TabbarManager alloc] init];
    });
    return instance;
}

#pragma mark UITabbarDelegate Methods
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *) viewController;
        [nav popToRootViewControllerAnimated:YES];
    }
    
}

@end
