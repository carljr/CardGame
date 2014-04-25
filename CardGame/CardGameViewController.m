//
//  CardGameViewController.m
//  CardGame
//
//  Created by Carl Davis on 3/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int numberOfCardsToMatch;
@end

@implementation CardGameViewController

- (int)numberOfCardsToMatch
{
    //set initial value to 2 to match button
    if (_numberOfCardsToMatch == 0) {
        _numberOfCardsToMatch = 2;
    }
    return _numberOfCardsToMatch;
}

- (IBAction)controllerSelectionChange:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"Selected Match 2 Cards");
        NSLog(@"Previous value was %i", self.numberOfCardsToMatch);
        self.numberOfCardsToMatch = 2;
    } else if (sender.selectedSegmentIndex == 1){
        NSLog(@"Selected Match 3 Cards");
        NSLog(@"Previous value was %i", self.numberOfCardsToMatch);
        self.numberOfCardsToMatch = 3;
    }
}

- (IBAction)resetGame:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
}

-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        NSLog(@"New game was initialized");
    }
    return _game;
}

- (Deck *)createDeck
{
    NSLog(@"Deck is created");
    return [[PlayingCardDeck alloc]init];
}


- (IBAction)touchCardButton:(UIButton *)sender
{
    //setting value to 3 for now - will set using button selection later;
    // [self setNumberOfCardsToMatch:3];
    NSLog(@"setNumberOfCardsToMatch = %i", self.numberOfCardsToMatch);
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    NSLog(@"chosenButtonIndex is %d",chosenButtonIndex);// Index of card
    [self.game chooseCardAtIndex:chosenButtonIndex numberOfCardsToMatch: _numberOfCardsToMatch];
    [self updateUI];
}

-(void)updateUI
{
    NSLog(@"updateUI starts");
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}


-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
