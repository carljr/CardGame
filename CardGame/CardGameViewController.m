//
//  CardGameViewController.m
//  CardGame
//
//  Created by Carl Davis on 3/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;

@property (strong, nonatomic) Deck *deck;

@end

@implementation CardGameViewController

- (Deck *)deck
{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc]init];
}



- (IBAction)touchCardButton:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        // if card front was showing do this
        [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@""
                forState:UIControlStateNormal];
        self.flipCount++;
    } else {
        // when card back was showing get a new card to show
        Card *randomCard = [self.deck drawRandomCard];
        if (randomCard) {
            // if card was available get details
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:(UIControlStateNormal)];
            [sender setTitle:randomCard.contents
                    forState:UIControlStateNormal];
            self.flipCount++;
        }
    }
}


-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
}
    
    
/*
 This was solution I had. It was nicer because it hid the card. Solution above is from class
     Card *card;
    if ([sender.currentTitle length]) {
        card = [self.deck drawRandomCard]; // draw next card if available
        if (card){
            [self.deck addCard:card]; // put card back if it was avaiable and show back
            [sender setBackgroundImage:[UIImage imageNamed:@"cardback"]
                              forState:UIControlStateNormal];
            [sender setTitle:@"" forState:UIControlStateNormal];
        }
        else{
             sender.hidden = YES; // if another card was not available hide card
        }
    } else {
        card = [self.deck drawRandomCard];
        if (card) {
            [sender setBackgroundImage:[UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
        }
    }
    self.flipCount++;
     
}
 */

@end
