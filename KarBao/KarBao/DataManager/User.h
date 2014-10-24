//
//  User.h
//  KarBao
//
//  Created by Caland on 14-10-23.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSDate * createtime;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic, retain) NSString * username;

@end
