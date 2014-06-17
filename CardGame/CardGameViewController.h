//
//  CardGameViewController.h
//  CardGame
//
//  Created by Carl Davis on 3/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//
// THIS IS AN ABSTRACT CLASS NOW THAT I GOT RID OF
// PLAYING CARD DECK CREATION

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;

// for sunclassers
- (Deck *)createDeck; // Abstract

// making titleForCard visible so I can update for SetCards
-(NSAttributedString *)titleForCard:(Card *)card;

// making backgroundImageForCard visible so I can update for SetCards
-(UIImage *)backgroundImageForCard:(Card *)card;

// will need to call updateUI also
-(void)updateUI;

-(void)updateGameStatus;

@property (nonatomic, strong) NSMutableArray *gameHistory;

@end
