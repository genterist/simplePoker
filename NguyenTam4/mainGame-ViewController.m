//
//  mainGame-ViewController.m
//  NguyenTam4
//
//  Created by Nguyen, Tam N. (UMSL-Student) on 8/1/16.
//  Copyright © 2016 Nguyen, Tam N. (UMSL-Student). All rights reserved.
//

#import "mainGame-ViewController.h"
#import "AppDelegate.h"

@interface mainGame_ViewController ()
{
    AppDelegate *myDelegate;
}

- (void) loadCards;
- (void) clearCards;
- (void) resetCards;

@end

@implementation mainGame_ViewController

@synthesize theDeck, Dealer, numPlayers, currentPhase, thePlayers, potMoney, callMoney, raiseMoney;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    //*************************
    //INITIALIZE EVERYTHING
    //
    currentPhase = 0;
    //init Deck and Dealer
    theDeck = [[Deck alloc] init];
    Dealer = [[Player alloc] initWithName:@"DEALER" andMoney:0];
    [ Dealer setPlayHandWithNumberOfCardsEqual:3 from: theDeck ];
    
    //init play values
    numPlayers = 6;
    potMoney = 0;
    callMoney = 50;
    raiseMoney = 0;
    
    int ctr = 0;
    thePlayers = [[NSMutableArray alloc] init];
    
    for (ctr = 0; ctr < numPlayers; ctr++){
        if (ctr ==0) {
            thePlayers[ctr]=[[Player alloc] initWithName:[NSString stringWithFormat:myDelegate.myName,ctr] andMoney:2000];
        } else
            thePlayers[ctr]=[[Player alloc] initWithName:[NSString stringWithFormat:@"Player %i",ctr] andMoney:2000];
        [[thePlayers objectAtIndex:ctr] setPlayHandWithNumberOfCardsEqual:2 from: theDeck];
        ((UILabel *) self.myPlayerNamesOutlet[ctr]).text = [self.thePlayers[ctr] aName ];
        [self.myPlayerTurnOutlet[ctr] setAlpha:0.0];
    }
    
    [self loadCardsImage:thePlayers];
    [self showCardBack];
    [self updateMoneyBoxes];
    

    
    
}

///////////////////////////////////////////////

- (void) flip: (Boolean) val {
    if (val == true) {val = false;}
    else {val = true;}
}

- (void) updateMoneyBoxes {
    int ctr = 0;
    for (ctr = 0; ctr < numPlayers; ctr++)
        if ([thePlayers[ctr] isFold]==false) ((UILabel *) self.myPlayerMoneyOutlet[ctr]).text = [NSString stringWithFormat: @"$%i",[thePlayers[ctr] moneyBag]];
    self.myPotMoney.text = [NSString stringWithFormat:@" $%i", potMoney];
}

- (void) evaluateAllHands {
    int ctr = 0;
    for (ctr = 0; ctr < numPlayers; ctr++)
        if ([thePlayers[ctr] isFold]==false)
        [self.thePlayers[ctr] playHand].weight = [self.thePlayers[ctr] getBestCaseScenarioFrom: Dealer.playHand andFrom: [self.thePlayers[ctr] playHand] ];
}

- (int) getWinner {
    int ctr = 0;
    int theWinner = 0;
    for (ctr = 1; ctr < numPlayers; ctr++){
        if ([thePlayers[ctr] isFold]==true) [self.thePlayers[ctr] playHand].weight = 0;
        if ([self.thePlayers[ctr] playHand].weight > [self.thePlayers[theWinner] playHand].weight)
            theWinner = ctr;
    }
    
    return theWinner;
}

- (void) setStuffUp {
    int ctr;
    [ Dealer setPlayHandWithNumberOfCardsEqual:3 from: theDeck ];
    for (ctr = 0; ctr < numPlayers; ctr++){
        [thePlayers[ctr] isFold]==false;
        [[thePlayers objectAtIndex:ctr] setPlayHandWithNumberOfCardsEqual:2 from: theDeck];
    }
    [self loadCardsImage:thePlayers];
    [self showCardBack];
    
}

- (void) resetCards {
    [theDeck reset];
    [Dealer.playHand reset];
    [self clearCards];
    int ctr = 0;
    for (ctr = 0; ctr < numPlayers; ctr++){
        [[self.thePlayers[ctr] playHand] reset];
        ((Player *) self.thePlayers[ctr]).isFold=false;
    }
}

- (void) loadCardsImage: (NSMutableArray *) thePlayers {
    int ctr = 0;
    int ctr2= 0;
    for (ctr = 0; ctr<numPlayers*2; ctr=ctr+2){
        [self.myPlayersCards[ctr] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [[[self.thePlayers[ctr2] playHand] handCards][0] image ]   ] ]] ;
        [self.myPlayersCards[ctr+1] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [[[self.thePlayers[ctr2] playHand] handCards][1] image ] ] ]] ;
        ctr2++;
    }
    ctr=0;
    for (ctr = 0; ctr<[Dealer.playHand.handCards count]; ctr++) {
        [self.myDealerCardOutlet[ctr] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [Dealer.playHand.handCards[ctr] image] ] ]] ;
    }

 
}

- (void) showCardBack {
    int ctr = 2;
    for (ctr=2; ctr<numPlayers*2; ctr++) {
        [self.myPlayersCards[ctr] setAlpha:0.0];
    }
}

- (void) showCardFront {
    int ctr = 2;
    for (ctr=2; ctr<numPlayers*2; ctr++) {
      [self.myPlayersCards[ctr] setAlpha:1];
    }
}

- (void) clearCards {
    int ctr = 0;
    for (ctr = 0; ctr<5; ctr++) {
        [self.myDealerCardOutlet[ctr] setImage:nil] ;
    }
    for (ctr = 0; ctr < numPlayers; ctr++){
        [self.myPlayersCards[ctr] setImage:nil ];
        [self.myPlayerTurnOutlet[ctr] setAlpha:0.0];
    }
    
}


- (IBAction)nextPressed:(id)sender {
    currentPhase++;
    if (currentPhase<3) {
        [Dealer.playHand.handCards addObject:[theDeck popCard]];
        int ctr=0;
        
        //PLAYER INTELLIGENCE PUT HERE
        [self evaluateAllHands];
        
        for (ctr = 0; ctr<numPlayers; ctr++) {
            if (((Player *)self.thePlayers[ctr]).isFold == false){
                    if (((Player *) self.thePlayers[ctr]).playHand.weight>3000){
                        if (arc4random()%9==1) ((Player *)self.thePlayers[ctr]).isFold = true;
                    }else if (((Player *) self.thePlayers[ctr]).playHand.weight>900){
                        if (arc4random()%7==1) ((Player *)self.thePlayers[ctr]).isFold = true;
                    }else if (((Player *) self.thePlayers[ctr]).playHand.weight>500){
                        if (arc4random()%5==1) ((Player *)self.thePlayers[ctr]).isFold = true;
                    }else
                        if (arc4random()%3==1) ((Player *)self.thePlayers[ctr]).isFold = true;

                    ((Player *) self.thePlayers[ctr]).moneyBag -= callMoney;
                    potMoney += callMoney;
                
            }
            if (((Player *)self.thePlayers[ctr]).isFold == true){ //if current hand is fold
                if (((Player *) self.thePlayers[ctr]).playHand.weight != 0){
                    ((UILabel *) self.myPlayerMoneyOutlet[ctr]).text = @"FOLD !!";
                    ((Player *) self.thePlayers[ctr]).playHand.weight = 0;
                    [self.myPlayersCards[ctr*2] setImage:nil ];
                    [self.myPlayersCards[ctr*2+1] setImage:nil ];
                }

            }
        }
        
        //GET ANOTHER CARD FOR DEALER
        for (ctr = 0; ctr<[Dealer.playHand.handCards count]; ctr++) {
            [self.myDealerCardOutlet[ctr] setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", [Dealer.playHand.handCards[ctr] image] ] ]] ;
        }
        
        //UPDATE ROUTINES
        [self updateMoneyBoxes];
        
    }else if (currentPhase==3){
        [self showCardFront];
        [self evaluateAllHands];
        int winner = [self getWinner];
        //now update the data of winner
        [self.myPlayerTurnOutlet[winner] setAlpha:1.1];
        ((Player *) self.thePlayers[winner]).moneyBag = ((Player *) self.thePlayers[winner]).moneyBag + potMoney;
        potMoney = 0;
        
        //UPDATE ROUTINES
        [self updateMoneyBoxes];
        
    }else if (currentPhase==4){
        currentPhase=0;
        [self resetCards];
        [self setStuffUp];
        
        //UPDATE ROUTINES
        [self updateMoneyBoxes];
        
    }
}
@end
