//
//  mainGame-ViewController.h
//  NguyenTam4
//
//  Created by Nguyen, Tam N. (UMSL-Student) on 8/1/16.
//  Copyright © 2016 Nguyen, Tam N. (UMSL-Student). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "Hand.h"
#import "Player.h"

@interface mainGame_ViewController : UIViewController

@property Deck* theDeck;
@property Player* Dealer;
@property int numPlayers, currentPhase;
@property NSMutableArray *thePlayers;


@property int potMoney, callMoney, raiseMoney;
@property (weak, nonatomic) IBOutlet UILabel *myPotMoney;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *myPlayersCards;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *myPlayersCardBack;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *myDealerCardOutlet;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *myPlayerNamesOutlet;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *myPlayerMoneyOutlet;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *myPlayerTurnOutlet;

- (IBAction)nextPressed:(id)sender;

@end
