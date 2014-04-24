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
@property (nonatomic, strong) NSMutableArray *cards; // of card

@end

@implementation CardMatchingGame

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

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;



- (void)chooseCardAtIndex:(NSUInteger)index numberOfCardsToMatch:(int)numToMatch
{
    // print numToMatch
    NSLog(@"numToMatch = %i", numToMatch);
    
    
    Card *card = [self cardAtIndex:index];
    NSLog(@"chooseCardAtIndex in CardMatchingGame.m");
    
    if (!card.isMatched) {
        if (card.isChosen) {
            
            // If card is chosen then clicking it unchoses it.
            NSLog(@"Card %@ was Chosen - now setting to NO", card.contents);
            
            card.chosen = NO;
        } else {
            
            // If card was not already chosen then try to match.
            printf("\n");
            NSLog(@"Try to match the following");
            NSLog(@"card contents: %@ ischosen: %hhd  card isMatched: %hhd",
                  card.contents, card.isChosen, card.isMatched);
            
            // match against other chosen cards
            // for loop will iterate through all cards
            
            for (Card *otherCard in self.cards) {
                
                // Print the array of cards
                NSLog(@"otherCard contents: %@ ischosen: %hhd  card isMatched: %hhd",
                      otherCard.contents, otherCard.isChosen, otherCard.isMatched);
                
                if (otherCard.isChosen && !otherCard.isMatched) {
                    
                    // Will only call match method when otherCard is chosen and not matched.
                    // The card just picked is not "chosen" yet.
                    // It is set to chosen later in this method.
                    
                    int matchScore = [card match:@[otherCard]];
                    
                    printf("\n");
                    NSLog(@"Matching Cards");
                    NSLog(@"card is %@", card.contents);
                    NSLog(@"otherCard %@", otherCard.contents);
                    
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    
                    break; // can only choose 2 cards for now
                    
                }
            }
            self.score -= COST_TO_CHOOSE;
            
            // current card set to chosen in next line
            
            card.chosen = YES;
            
            // Print the chosen card and it's properties
            NSLog(@"Card %@ is set chosen. chosen: %hhd, matched: %hhd,", card.contents, card.chosen, card.matched);
            for (Card *otherCard in self.cards) {
                // Print the array of cards
                NSLog(@"otherCard contents: %@ ischosen: %hhd  card isMatched: %hhd",
                                otherCard.contents, otherCard.isChosen, otherCard.isMatched);
            }
        }
    }
}

@end
