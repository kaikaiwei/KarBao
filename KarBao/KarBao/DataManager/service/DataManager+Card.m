//
//  DataManager+Card.m
//  KarBao
//
//  Created by Caland on 14-10-20.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "DataManager+Card.h"

#define EntityCard @"Card"


@implementation DataManager (Card)


- (Card *) syncCard:(NSDictionary *) dict
{
    Card *card = [self getCardById:[dict objectForKey:@"cardid"]];
    if (card == nil) {
        card = (Card *) [NSEntityDescription insertNewObjectForEntityForName:EntityCard inManagedObjectContext:self.objectContext];
//        NSDictionary *dict = @{@"cardid" : [Util generateUUID],
//                               @"cardname" : @"KarBao Test",
//                               @"carduser" : [Util currentLoginUserId],
//                               @"createuser" : [arr objectAtIndex:0],
//                               @"createtime" : date};
        card.cardid = [dict objectForKey:@"cardid"];
        card.cardname = [dict objectForKey:@"cardname"];
        card.carduser = [dict objectForKey:@"carduser"];
        card.createuser = [dict objectForKey:@"createuser"];
        card.createtime = [dict objectForKey:@"createtime"];
        
    }
    
    return card;
}

- (void) deleteObject:(Card *) card
{
    [self.objectContext deleteObject:card];
}

- (NSArray *) fetchObjs
{
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid==%@", cardId];
    NSArray *fetchObjects = [self arrayFromCoreData:EntityCard
                                          predicate:nil
                                              limit:NSUIntegerMax
                                             offset:0
                                            orderBy:nil];
    return fetchObjects;
}

- (NSArray *) getchObjsByUserId:(NSString *) userId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userid==%@", userId];
    NSArray *fetchObjects = [self arrayFromCoreData:EntityCard
                                          predicate:predicate
                                              limit:NSUIntegerMax
                                             offset:0
                                            orderBy:nil];
    return fetchObjects;
}

- (NSArray *) getchObjsByCreateUser:(NSString *) createuser
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createuser==%@", createuser];
    NSArray *fetchObjects = [self arrayFromCoreData:EntityCard
                                          predicate:predicate
                                              limit:NSUIntegerMax
                                             offset:0
                                            orderBy:nil];
    return fetchObjects;
}

- (Card *) getCardById:(NSString *) cardId
{
    Card *card = nil;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cardid==%@", cardId];
    NSArray *fetchObjects = [self arrayFromCoreData:EntityCard
                                          predicate:predicate
                                              limit:NSUIntegerMax
                                             offset:0
                                            orderBy:nil];
    if ([fetchObjects count])
        card = [fetchObjects firstObject];
    
    return card;
}


@end
