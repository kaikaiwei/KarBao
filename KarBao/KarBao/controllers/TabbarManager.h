//
//  TabbarManager.h
//  KarBao
//
//  Created by Caland on 14-10-16.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TabbarManager : NSObject <UITabBarControllerDelegate>

/**
 *  @abstract 单例入口
 */
+(TabbarManager *) defaultInstance;

@end
