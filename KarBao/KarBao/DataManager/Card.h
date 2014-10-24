//
//  Card.h
//  KarBao
//
//  Created by Caland on 14-10-23.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Card : NSManagedObject

@property (nonatomic, retain) NSString * cardid;
@property (nonatomic, retain) NSString * cardname;
@property (nonatomic, retain) NSString * carduser;
@property (nonatomic, retain) NSData * createtime;
@property (nonatomic, retain) NSString * createuser;
@property (nonatomic, retain) User *card;

@end
