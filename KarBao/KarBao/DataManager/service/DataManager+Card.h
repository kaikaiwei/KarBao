//
//  DataManager+Card.h
//  KarBao
//
//  Created by Caland on 14-10-20.
//  Copyright (c) 2014年 Caland. All rights reserved.
//

#import "DataManager.h"
#import "Card.h"

@interface DataManager (Card)


- (Card *) syncCard:(NSDictionary *) dict;

- (void) deleteObject:(Card *) card;

- (NSArray *) fetchObjs;

- (NSArray *) getchObjsByUserId:(NSString *) userId;


- (NSArray *) getchObjsByCreateUser:(NSString *) createuser;

- (Card *) getCardById:(NSString *) cardId;







@end
