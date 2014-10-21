//
//  Account.m
//  KarBao
//
//  Created by Caland on 14-10-20.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "Account.h"

@implementation Account


- (id)initWithCoder: (NSCoder *)coder
{
    if (self = [super init]) {
        self.username = [coder decodeObjectForKey:@"username"];
        self.password = [coder decodeObjectForKey:@"password"];
        self.devId = [coder decodeObjectForKey:@"devId"];
    }
    
    return self;
}

- (void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.username forKey:@"username"];
    [coder encodeObject:self.password forKey:@"password"];
    [coder encodeObject:self.devId forKey:@"devId"];
}
@end
