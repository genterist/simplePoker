//
//  Hand.m
//  TamPoker
//
//  Created by user119464 on 7/31/16.
//  Copyright © 2016 Tam Nguyen. All rights reserved.
//

#import "Hand.h"


@implementation Hand


@synthesize handCards,odds, weight;

- (Hand *) init {
    self = [super init];
    if (self) {
        handCards = [[NSMutableArray alloc] init];
        odds = 0;
        weight = 0;
    }
    return self;
}

- (void) getHandCard: (Card *) aCard{ 
    
    if ( ([handCards count]==0) || (aCard.weight> [ [handCards objectAtIndex:(int)([handCards count]-1)] weight ]) )
        [handCards addObject: aCard];
    else{
        int ctr = 0;
        for (ctr = 0; ctr <[handCards count]; ctr++) {
            if (aCard.weight<[[handCards objectAtIndex:ctr] weight]){
                [handCards insertObject:aCard atIndex:ctr];
                ctr = (int)[handCards count]; //break out of the loop
            }
        }
    }
    self.odds = [self getOdds];
    self.weight = (int) [self getWeight];
    
}

- (Boolean) isRoyalFlush {
    if ( ([handCards[4] num] == 1 &&
         [handCards[3] num] == 13 &&
         [handCards[2] num] == 12 &&
         [handCards[1] num] == 11 &&
         [handCards[0] num] == 10)
        )return true;
    else
        return false;
}

- (Boolean) isStraight {
    bool straight = true;
    int count = 0;
    
    //check for a straight
    for (count = 0; count <4; count++) {
        if ( ([handCards[count] num]+1) != [handCards[count+1] num])
        {
            straight = false;
            count = 9; //break out of loop
        }
    }

    return straight;
}
- (Boolean) isFlush {
    bool flush = true;
    int count = 0;
    
    //check for a flush
    for (count = 0; count <4; count++) {
        if ( [[handCards[count] sign] isEqualToString:[handCards[count+1] sign]] == false)
        {
            flush = false;
            count = 9; //break out of loop
        }
    }
    return flush;
}

- (NSMutableArray *) check3count {
    NSMutableArray *threeCounts = [NSMutableArray new];
    int ctr1 = 0;
    int ctr2 = 0;
    
    for (ctr1 = 0; ctr1<3; ctr1++){
        ctr2 = 0;
        if ([handCards[ctr1] num] != [handCards[ctr1+1] num]) ctr2++;
        if ([handCards[ctr1+1] num] != [handCards[ctr1+2] num]) ctr2++;
        [threeCounts addObject:@(ctr2)];
    }

    
    return threeCounts;
}

- (NSMutableArray *) check2count {
    NSMutableArray *twoCounts = [NSMutableArray new];
    int ctr1 = 0;
    int ctr2 = 0;
    
    for (ctr1 = 0; ctr1<[handCards count]-1; ctr1++){
        ctr2 = 0;
        if ([handCards[ctr1] num] != [handCards[ctr1+1] num]) ctr2++;
        [twoCounts addObject:@(ctr2)];
    }
    
    
    return twoCounts;
}

- (Boolean) isFullHouse {
    bool fullHouse = false;
    NSMutableArray *threeCounts = [NSMutableArray new];
    threeCounts = [self check3count];
    
    if ( [threeCounts[0] isEqual:@(1)]&&
         [threeCounts[1] isEqual:@(1)]&&
         [threeCounts[2] isEqual:@(0)]
        ) fullHouse = true;
    
    if ( [threeCounts[0] isEqual:@(0)]&&
        [threeCounts[1] isEqual:@(1)]&&
        [threeCounts[2] isEqual:@(1)]
        ) fullHouse = true;
    
    return fullHouse;
}

- (Boolean) isFourAKind {
    bool fourAKind = false;
    NSMutableArray *threeCounts = [NSMutableArray new];
    threeCounts = [self check3count];
    
    if ( [threeCounts[0] isEqual:@(1)]&&
        [threeCounts[1] isEqual:@(0)]&&
        [threeCounts[2] isEqual:@(0)]
        ) fourAKind = true;
    
    if ( [threeCounts[0] isEqual:@(0)]&&
        [threeCounts[1] isEqual:@(0)]&&
        [threeCounts[2] isEqual:@(1)]
        ) fourAKind = true;
    
    return fourAKind;
}

- (Boolean) isThreeAKind {
    bool threeAKind = false;
    NSMutableArray *threeCounts = [NSMutableArray new];
    threeCounts = [self check3count];
    
    if ( [threeCounts[0] isEqual:@(2)]&&
        [threeCounts[1] isEqual:@(1)]&&
        [threeCounts[2] isEqual:@(0)]
        ) threeAKind = true;
    
    if ( [threeCounts[0] isEqual:@(0)]&&
        [threeCounts[1] isEqual:@(1)]&&
        [threeCounts[2] isEqual:@(2)]
        ) threeAKind = true;
    
    if ( [threeCounts[0] isEqual:@(1)]&&
        [threeCounts[1] isEqual:@(0)]&&
        [threeCounts[2] isEqual:@(1)]
        ) threeAKind = true;
    
    return threeAKind;
}

- (int) getWeight{
    bool found = false; //flag for all searches. Stop when found.
    int myCounter = 0;
    int theWeight = 0;
    
    //get total raw weights
    for (myCounter = 0; myCounter<[handCards count]; myCounter++){
        theWeight = theWeight + (int) [[handCards objectAtIndex:myCounter] weight];
    }
    
   
    //case of Royal Flush - ten - prince - queen - king - ace
    if ([handCards count] ==5 && found == false && [self isRoyalFlush])
     {
            theWeight = theWeight + 5000;
            NSLog(@"ROYAL FLUSH !!");
            found = true; // cut off further search
    }
    
    
    if ( [handCards count] ==5  && found == false) {
        
        if ([self isStraight]  && ![self isFlush]){
            theWeight = theWeight + 800;
            //NSLog(@"Straight");
            found = true;
        }
        
        else if (![self isStraight]  && [self isFlush]) {
            theWeight = theWeight + 1000;
            //NSLog(@"Flush");
            found = true;
        }
        
        else if ([self isStraight]  && [self isFlush])
        {
            theWeight = theWeight + 4000;
            //NSLog(@"Sraight Flush");
            found = true;
        }
        
        else if ([self isFullHouse]) {
            theWeight = theWeight + 2000;
            //NSLog(@"Full House");
            found = true;
        }
        
        else if ([self isFourAKind]) {
            theWeight = theWeight + 3000;
            //NSLog(@"Four of a Kind");
            found = true;
        }
        
        else if ([self isThreeAKind]) {
            theWeight = theWeight + 500;
            //NSLog(@"Three of a Kind");
            found = true;
        }
    }
    
    if ( [handCards count] ==4  && found == false) {
        NSMutableArray *check2 = [NSMutableArray new];
        check2 = [self check2count];
        if ([check2 count]==0) {
            theWeight = theWeight + 3000;
            //NSLog(@"Four of a Kind");
            found = true;
            
        }

    }
    
    if ( [handCards count] >=2  && found == false) {
        int tempNum = [[handCards objectAtIndex:0] num];
        int sameNum = 0;
        int difNum = 0;
        int count = 0;
        bool is3aKind = false;
        bool is2pairs = false;
        
        for (count = 1; count < [handCards count]; count++) {
            if ([[handCards objectAtIndex:count] num] != tempNum){
                tempNum = [[handCards objectAtIndex:count] num];
                difNum++;
            } else
            {
                sameNum++;
            }
        }
        
        if (sameNum==2) {
            if ([handCards count]==3) is3aKind=true;
            if ([handCards count]==4 && theWeight%2==1) is3aKind=true;
            if ([handCards count]==4 && theWeight%2==0) is2pairs=true;
            
            if ([handCards count]==5){
                for (count=0; count<3; count++){
                    if ([[handCards objectAtIndex:count] num]==[[handCards objectAtIndex:count+1] num] &&
                        [[handCards objectAtIndex:count+1] num]==[[handCards objectAtIndex:count+2] num]
                        ) {
                        is3aKind = true;
                        count = 5; //to break out of the loop
                    }
                }
                if (!is3aKind) is2pairs=true;
            }
            
         // case of Three of a Kind
            if (is3aKind){
                theWeight = theWeight + 500;
                found = true;
            }
        // case of two pairs
            if (is2pairs){
                theWeight = theWeight + 300;
                found = true;
            }
        }
        
        if (sameNum==1) {
            theWeight = theWeight + 100;
            found = true;
            
        }
     
    }

    
    // case of single highest card
    
    if ( [handCards count] >=1  && found == false) {
        theWeight = [[ handCards objectAtIndex: [handCards count]-1 ] weight];
        found = true;
    }
    
    return theWeight;
}

//underDevelopment
- (float) getOdds {
    int theOdds = 0;
    //int theWeight = [self getWeight];
    switch ([handCards count]) {
        case 1:
            theOdds = 0;
            break;
        case 2:
            theOdds = 0;
            break;
        case 3:
            theOdds = 0;
            break;
        case 4:
            theOdds = 0;
            break;
        case 5:
            theOdds = 0;
            break;
            
        default:
            break;
    }
    
    return theOdds;
    
}

- (void) print {
    int count = 0;
    NSLog(@"------------\n");
    if ([self.handCards count] == 0) NSLog(@"No card on hand\n");
    else
        for (count = 0; count < [self.handCards count]; count++){
            [[self.handCards objectAtIndex:count] printCard];
        }
    NSLog(@"\n");
    NSLog(@"Odds: %d  Weight: %i \n", self.odds, self.weight);
}

- (void) reset {
    [handCards removeAllObjects];
    self.odds = 0;
    self.weight = 0;
}


@end
