//
//  Player.h
//  TamPoker
//
//  Created by user119464 on 7/31/16.
//  Copyright © 2016 Tam Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hand.h"

@interface Player : NSObject

@property NSString* aName;
@property NSString* avatar;
@property int moneyBag;
@property NSString* status;
@property Boolean isFold, isBroke;
@property (copy, nonatomic) Hand  *playHand;
@property (copy, nonatomic) Hand *tempHand;

- (Player *) initWithName: (NSString *) theName andMoney: (int) theMoneyBag;
- (void) setPlayHandWithNumberOfCardsEqual: (int) numCards from: (Deck *) aDeck;
- (int) getBestCaseScenarioFrom: (Hand *) firstHalf andFrom: (Hand *) secondHalf;
- (NSString *) getCardTitleAtIndex: (int) theIndex;

@end
