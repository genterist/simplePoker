//
//  Card.m
//  TamPoker
//
//  Created by user119464 on 7/31/16.
//  Copyright © 2016 Tam Nguyen. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize num, sign, status, image, weight, selected;

- (Card *) initWithNum: (int) theNum thenSign: (NSString *) theSign thenWeight: (int) theWeight  andImage: (NSString *) theImage{
    self = [super init];
    if (self) {
        self.num = theNum;
        self.sign = theSign;
        self.status = 0;
        self.image = theImage;
        self.weight = theWeight;
        self.selected = false;
    }
    return self;
}

- (void) printCard{
    NSLog(@" [%i %@] - w: %i - img: %@", self.num, self.sign, self.weight, self.image);
}

- (NSString *) getCardTitle {
    return [NSString stringWithFormat:@"%i %@", num, sign];
    
}


@end
