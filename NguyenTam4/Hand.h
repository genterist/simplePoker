//
//  Hand.h
//  TamPoker
//
//  Created by user119464 on 7/31/16.
//  Copyright © 2016 Tam Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface Hand : NSObject

@property (strong, nonatomic) NSMutableArray* handCards;
@property int odds, weight;

- (Hand *) init;
- (void) getHandCard: (Card *) aCard;
- (int) getWeight;
- (float) getOdds;
- (void) print;
- (void) reset;
- (Boolean) isRoyalFlush;
- (Boolean) isFlush;
- (Boolean) isStraight;
- (Boolean) isFullHouse;
- (Boolean) isFourAKind;

@end
