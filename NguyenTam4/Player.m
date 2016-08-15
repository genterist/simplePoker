//
//  Player.m
//  TamPoker
//
//  Created by user119464 on 7/31/16.
//  Copyright © 2016 Tam Nguyen. All rights reserved.
//

#import "Player.h"

@implementation Player

@synthesize aName, avatar, moneyBag,status,playHand, tempHand, isFold, isBroke;

- (Player *) initWithName: (NSString *) theName andMoney: (int) theMoneyBag {
    self = [super init];
    if (self) {
        aName = theName;
        moneyBag = theMoneyBag;
        avatar = @"";
        status = @"";
        playHand = [[Hand alloc] init];
        tempHand = [[Hand alloc] init];
        isFold = false;
        isBroke = false;
    }
    return self;
}

- (void) setPlayHandWithNumberOfCardsEqual: (int) numCards from: (Deck *) aDeck{
    int count = 0;
    for (count = 0; count<numCards; count++)
        [ self.playHand getHandCard:[aDeck popCard]];
}


- (int) getBestCaseScenarioFrom: (Hand *) firstHalf andFrom: (Hand *) secondHalf; {
    int bestWeight = 0;
    Hand *temp = [[Hand alloc] init];
    Hand *masked = [[Hand alloc] init];
    int maskSlot1, maskSlot2, ctr, ctr1, ctr2;
    int total1 = (int) [firstHalf.handCards count];
    int total2 = (int) [secondHalf.handCards count];
    
    for (ctr1 = 0; ctr1<total1; ctr1++) [temp getHandCard:[firstHalf.handCards objectAtIndex:ctr1]];
    for (ctr2 = 0; ctr2<total2; ctr2++) [temp getHandCard:[secondHalf.handCards objectAtIndex:ctr2]];
    //[temp print];
    
    if (total1+total2==5){
        bestWeight = [temp getWeight];
    }
    
    if (total1+total2==6){
        for (ctr = 0; ctr <6; ctr++){ //for each masked situation
            maskSlot1 = ctr; //set masked slot
            [masked reset]; //make sure masked array is clear
            //forming masked array
            for (ctr1 = 0; ctr1<6; ctr1++){
                if (ctr1!=maskSlot1){
                    [masked getHandCard:temp.handCards[ctr1]];
                    //NSLog(@"%i ", ctr1);
                }
            }
            masked.weight = [masked getWeight];

            // compared masked array with best array
            if (masked.weight > bestWeight) bestWeight = masked.weight;
        }
    }
    
    if (total1+total2==7){
        ctr = 0;
        ctr1 = 1;
        for (ctr = 0; ctr <7; ctr++){ //for each maskSlot1 situation
            [masked reset]; //make sure masked array is clear
            maskSlot1 = ctr;
            for (ctr1 = 1; ctr1<5; ctr1++) {//for each maskSlot1 and maskSlot2 difference
                maskSlot2 = (maskSlot1+ctr1)%7;
                
                //forming masked array
                ctr2 = 0;
                for (ctr2 = 0; ctr2<7; ctr2++){
                    if (ctr2!=maskSlot1 && ctr2!=maskSlot2)
                        [masked getHandCard:temp.handCards[ctr2]];
                }
                masked.weight = [masked getWeight];
                // compared masked array with best array
                if (masked.weight > bestWeight) bestWeight = masked.weight;
                
            }
        }
    }
    
    return bestWeight;
}

- (NSString *) getCardTitleAtIndex: (int) theIndex {
    NSString *tempString = [[NSString alloc] init];
    if (theIndex >= [self.playHand.handCards count])
        tempString = @"empty";
    else
        tempString = [[self.playHand.handCards objectAtIndex:theIndex] getCardTitle];
   
    
    return tempString;
}

@end
