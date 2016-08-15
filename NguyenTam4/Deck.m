//
//  Deck.m
//  TamPoker
//
//  Created by user119464 on 7/31/16.
//  Copyright © 2016 Tam Nguyen. All rights reserved.
//

#import "Deck.h"

@implementation Deck

@synthesize theDeck;

- (Deck *) init {
    self = [super init];
    int numCount = 0;
    int signCount = 0;

    
    if (self) {
        self.theDeck = [[NSMutableArray alloc] init];
        
        //begins basic init of deck cards
        for (signCount = 0; signCount<4; signCount++){
            switch (signCount) {
                case 0:
                    for (numCount = 0; numCount<13; numCount++){
                        if (numCount ==0) {
                            [ self.theDeck addObject:[[Card alloc ]initWithNum:(numCount+1) thenSign:@"Spade"  thenWeight:13*4-3 andImage:@"empty"]];
                        } else
                            [ self.theDeck addObject:[[Card alloc ]initWithNum:(numCount+1) thenSign:@"Spade"  thenWeight:signCount+4*(numCount-1) andImage:@"empty"]];
                    }
                    
                    break;
                case 1:
                    for (numCount = 0; numCount<13; numCount++){
                        if (numCount ==0) {
                            [ self.theDeck addObject:[[Card alloc ]initWithNum:(numCount+1) thenSign:@"Club"  thenWeight:13*4-2 andImage:@"empty"]];
                        } else
                            [ self.theDeck addObject:[[Card alloc ]initWithNum:(numCount+1) thenSign:@"Club"  thenWeight:signCount+4*(numCount-1)  andImage:@"empty"]];
                    }
                    break;
                case 2:
                    for (numCount = 0; numCount<13; numCount++){
                        if (numCount ==0) {
                            [ self.theDeck addObject:[[Card alloc ]initWithNum:(numCount+1) thenSign:@"Diamond"  thenWeight:13*4-1 andImage:@"empty"]];
                        } else
                            [ self.theDeck addObject:[[Card alloc ]initWithNum:(numCount+1) thenSign:@"Diamond"  thenWeight:signCount+4*(numCount-1)  andImage:@"empty"]];
                    }
                    break;
                case 3:
                    for (numCount = 0; numCount<13; numCount++){
                        if (numCount ==0) {
                            [ self.theDeck addObject:[[Card alloc ]initWithNum:(numCount+1) thenSign:@"Heart"  thenWeight:13*4 andImage:@"empty"]];
                        } else
                            [ self.theDeck addObject:[[Card alloc ]initWithNum:(numCount+1) thenSign:@"Heart"  thenWeight:signCount+4*(numCount-1)  andImage:@"empty"]];
                    }
                    break;
                    
                default:
                    break;
            }
        }
        
        //begin init card image values
        for (signCount = 0; signCount<[theDeck count]; signCount++){
            [[self.theDeck objectAtIndex:signCount] setImage:[NSString stringWithFormat:@"%i.jpg",signCount]];
        }
    
        
    }
    
    return self;
}

- (void) print {
    int count = 0;
    for (count = 0; count <52; count++){
        if ([[self.theDeck objectAtIndex:count] status]==0)
        [[self.theDeck objectAtIndex:count] printCard];
    }
}

- (Card *) popCard {
    int temp = arc4random_uniform(52);
    //make sure not to pop a used card
    while ([[self.theDeck objectAtIndex:temp] status] == 1) {temp = arc4random_uniform(52);}
    //now pop it out
    [[self.theDeck objectAtIndex:temp] setStatus:1];
    return [self.theDeck objectAtIndex:temp];
}

- (Card *) popCardAtIndex: (int) theIndex {
    //make sure not to pop a used card
    if ([[self.theDeck objectAtIndex:theIndex] status] == 1) return nil;
    //now pop it out
    [[self.theDeck objectAtIndex:theIndex] setStatus:1];
    return [self.theDeck objectAtIndex:theIndex];
}

- (void) reset {
    int count = 0;
    for (count = 0; count<52; count++){
        [[self.theDeck objectAtIndex:count] setStatus:0];
    }
}
@end
