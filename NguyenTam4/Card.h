//
//  Card.h
//  TamPoker
//
//  Created by user119464 on 7/31/16.
//  Copyright © 2016 Tam Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property int num, status, weight;
@property NSString* sign, * image;
@property bool selected;

- (Card *) initWithNum: (int) theNum thenSign: (NSString *) theSign thenWeight: (int) theWeight andImage: (NSString *) theImage;
- (void) printCard;
- (NSString *) getCardTitle;

@end
