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
    


@end
