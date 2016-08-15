//
//  Deck.h
//  TamPoker
//
//  Created by user119464 on 7/31/16.
//  Copyright © 2016 Tam Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property NSMutableArray* theDeck;

- (Deck *) init ;

- (void) print;
- (Card *) popCard;
- (Card *) popCardAtIndex: (int) theIndex;
- (void) reset;

@end
