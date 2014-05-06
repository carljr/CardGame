//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Davis, Carl on 4/16/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger newPoints; // making newPoints readwrite internally
@property (nonatomic, strong) NSMutableArray *cards; // of card
@property (nonatomic, strong) NSMutableArray *chosenNotMatchedCards; //of card

@end

@implementation CardMatchingGame

- (int)numberOfCardsToMatch
{
    //set initial value to 2 to match button
    if (_numberOfCardsToMatch == 0) {
        _numberOfCardsToMatch = 2;
    }
    return _numberOfCardsToMatch;
}

-(NSMutableArray *)chosenNotMatchedCards
{
    if (!_chosenNotMatchedCards) _chosenNotMatchedCards = [[NSMutableArray alloc]init];
    return _chosenNotMatchedCards;
}

-(NSMutableArray *)cards
{
    if (!_cards) _cards= [[NSMutableArray alloc]init];
    return _cards;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
{
    self = [super init]; // super's designated initializer
    
    if (self) {
        NSLog(@"pick the cards for this round.");
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
                // print the cards that were picked.
                NSLog(@"%@", card.contents);
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

// will not use MISMATCH_PENALTY const
// instead set to MISMATCH_PENALTY to number of cards to choose
// static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;



- (void)chooseCardAtIndex:(NSUInteger)index
{
    
    // Player has just selected a card. Receiving the card index and number of cards to match.
    // print numToMatch - delete prior to go live
    NSLog(@"numToMatch = %i", self.numberOfCardsToMatch);
    
    //clearing out existing chosenNotMatchedCards array
    self.chosenNotMatchedCards = nil;
    
    // setting card to the card the player selected.
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            
            // If card is chosen then clicking it unchooses it.
            // No score change for unclicking.
            card.chosen = NO;
            self.gameStatus = [NSString stringWithFormat:@"Card %@ deselected.",card.contents];
            
        } else {
            
            // If card was not already chosen then try to match.
            // match against previously chosen cards
            // for loop will iterate through all cards and find them.
            
            // display card we just picked
            printf("\n");
            NSLog(@"Matching Card");
            NSLog(@"card is %@", card.contents);
            
            // iterate through all the card buttons
            // if card is chosen and not mathced add to
            // chosenNotMatchedCards array
            for (Card *otherCard in self.cards) {
                
                // Print the array of all cards and status
                NSLog(@"otherCard contents: %@ ischosen: %hhd  card isMatched: %hhd",
                      otherCard.contents, otherCard.isChosen, otherCard.isMatched);
                
                // find all cards that need to be matched
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    // adding current chosen not matched card to array
                    [self.chosenNotMatchedCards addObject:otherCard];
                }
            }
            
            if ([self.chosenNotMatchedCards count] < self.numberOfCardsToMatch-1){
                // can add another card
                NSLog(@"can add another card");
                
                self.gameStatus = [NSString stringWithFormat:@"Card %@ selected.",card.contents];
                
            } else {
                // ready to match
                NSLog(@"ready to match");
                int matchScore = [card match:self.chosenNotMatchedCards];
                NSLog(@"matchScore = %i", matchScore);
                
                // If we have a match then update score
                // and mark cards as matched
                if (matchScore) {
                    self.newPoints = matchScore * MATCH_BONUS; // getting new points for status message
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *matchedCard in self.chosenNotMatchedCards){
                        matchedCard.matched = YES;
                    }
                self.gameStatus = [NSString stringWithFormat:@"Match found for %ld points", (long)self.newPoints];
                    
                // otherwise set cards in chosenNotMatchedCards to not chosen
                // and penalize for not having a match.
                } else {
                    for (Card *unChosenCard in self.chosenNotMatchedCards){
                        [unChosenCard setChosen:NO];
                    }
                int MISMATCH_PENALTY = self.numberOfCardsToMatch;
                self.score -= MISMATCH_PENALTY;
                self.gameStatus = [NSString stringWithFormat:@"No match, %i point penalty.", MISMATCH_PENALTY];
                }
            }
            self.score -= COST_TO_CHOOSE;
            
            //set selected card to chosen
            card.chosen = YES;

            printf("\n");
            NSLog(@"Current Card is %@", card.contents);
            NSLog(@"Array of chosen cards");
            for (Card *chosenCard in self.chosenNotMatchedCards) {
                // Print the array of chosen cards
                NSLog(@"chosen card array contents: %@ ischosen: %hhd  card isMatched: %hhd",
                                chosenCard.contents, chosenCard.isChosen, chosenCard.isMatched);
            }
        }
    }
}

@end
