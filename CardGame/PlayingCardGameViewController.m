//
//  PlayingCardGameViewController.m
//  CardGame
//
//  Created by Carl Davis on 5/6/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "HistoryViewController.h"
#import "CardMatchingGame.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            [segue.destinationViewController setHistory:self.game.history];
        }
    }
}

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc]init];
}

@end
