//
//  CardGameViewController.m
//  CardGame
//
//  Created by Carl Davis on 3/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "CardGameViewController.h"

// iport no longer needed since we are not creating playing card deck here
// #import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutlet UISegmentedControl *controller;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *gameStatusMessage;
@end

@implementation CardGameViewController


-(NSMutableArray *)gameHistory
{
    if (!_gameHistory) _gameHistory = [[NSMutableArray alloc]init];
    return _gameHistory;
}

- (IBAction)controllerSelectionChange:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"Selected Match 2 Cards");
        NSLog(@"Previous value was %i", self.game.numberOfCardsToMatch);
        self.game.numberOfCardsToMatch = 2;
    } else if (sender.selectedSegmentIndex == 1){
        NSLog(@"Selected Match 3 Cards");
        NSLog(@"Previous value was %i", self.game.numberOfCardsToMatch);
        self.game.numberOfCardsToMatch = 3;
    }
}

- (IBAction)resetGame:(UIButton *)sender {
    self.game = nil;
    [self.controller setEnabled:YES forSegmentAtIndex:0];
    [self.controller setEnabled:YES forSegmentAtIndex:1];
    [self.controller setSelectedSegmentIndex:self.game.numberOfCardsToMatch-2];
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
    // removing code that creates paying card deck
    // NSLog(@"Deck is created");
    // return [[PlayingCardDeck alloc]init];
    
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    //Disabling number of card selector once game starts
    [self.controller setEnabled:NO forSegmentAtIndex:0];
    [self.controller setEnabled:NO forSegmentAtIndex:1];
    
    NSLog(@"setNumberOfCardsToMatch = %i", self.game.numberOfCardsToMatch);
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    NSLog(@"chosenButtonIndex is %d",chosenButtonIndex);// Index of card
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)updateUI
{
    NSLog(@"updateUI starts");
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        //updated setTitle method to setAttributedTitle
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.gameStatusMessage.text = self.game.gameStatus; // **** replace with currect status ****
    }
    //added if statement because set game starts with no message but updateUI runs ti get card faces
    if (!(self.game.gameStatus == nil)){
        
        // removing code below. Instead changed gameHistory to NSArray
        // from NSMutable array and copied data from history array in model.
        //[self.gameHistory addObject:self.game.gameStatus];
        //for (NSString *loggedHistory in self.gameHistory)
        //{
        //    // Print the array of chosen cards
        //    NSLog(@"Game History: %@",
        //          loggedHistory);
        //}
        
        self.gameHistory = [[NSMutableArray alloc] initWithArray:self.game.history];
    }
}

-(NSAttributedString *)titleForCard:(Card *)card
{
    // return card.isChosen ? card.contents : @"";
    // instead of old return above will use the code commented above to create an
    // attributed string instead.
    NSAttributedString *attributedTitleForCard = [[NSAttributedString alloc] initWithString:card.isChosen ? card.contents : @""];
    return attributedTitleForCard;
}


-(UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
