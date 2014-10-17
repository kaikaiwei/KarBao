//
//  AppDelegate.m
//  KarBao
//
//  Created by Caland on 14-10-15.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "AppDelegate.h"
#import "TabbarManager.h"
#import "GeneralNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setTheDefaultAppear];
    
    UINavigationController *nav = (UINavigationController *) self.window.rootViewController;
    self.tabController = (UITabBarController *) nav.topViewController;
//    self.tabController = (UITabBarController *) self.window.rootViewController;
    UIViewController *createController = [[UIStoryboard storyboardWithName:@"ToolKit_iPad" bundle:nil] instantiateViewControllerWithIdentifier:@"CreateUserController"];
    self.createNavController = [[UINavigationController alloc] initWithRootViewController:createController];
    self.tabController.delegate = [TabbarManager defaultInstance];
    [self.tabController presentViewController:self.createNavController animated:YES completion:^{
        
    }];
    
    
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  设置UINavigationController的默认出现颜色等信息
 *
 */
- (void) setTheDefaultAppear
{
    // 系统状态栏采用浅色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"ArialMT" size:15.0], NSFontAttributeName, nil] forState:UIControlStateNormal];
    // [[UITableView appearance] setSectionIndexBackgroundColor:[UIColor colorWithR:255 G:255 B:255 A:100]];
    
    // 导航栏设置默认背景和系统UI颜色
//    [[UINavigationBar appearanceWhenContainedIn:[GeneralNavigationController class], nil] setBackgroundImage:[UIImage imageNamed:@"BarTopAll"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    // 导航栏设置默认文字字体效果和颜色
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:245 green:245 blue:245 alpha:255], NSForegroundColorAttributeName,
                                                          shadow, NSShadowAttributeName,
                                                          [UIFont fontWithName:@"ArialMT" size:24.0], NSFontAttributeName, nil]];
}


+(AppDelegate *) sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

@end
