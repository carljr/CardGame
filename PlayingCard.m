//
//  PlayingCard.m
//  CardGame
//
//  Created by Carl Davis on 3/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    /*
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        }
    }
    */
    // Compare last chasen card to array of cards
    for (PlayingCard *otherCard in otherCards){
        if (otherCard.rank == self.rank) {
            score += 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score += 1;
        }
    }
    
    // If array has more than 1 card compare the cards to each other.
    // For now will only be able to handle two cards. i.e. "3" is selected.
    if ([otherCards count] == 2){
        PlayingCard *card0 = [otherCards objectAtIndexedSubscript:0];
        PlayingCard *card1 = [otherCards objectAtIndexedSubscript:1];
        if (card0.rank == card1.rank){
            score += 4;
        } else if (card0.suit == card1.suit){
            score += 1;
        }
    }
    return score;
}

-(NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter

+(NSArray *)validSuits{
    return @[@"♥︎",@"♦︎",@"♣︎",@"♠︎"];
}

-(void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(NSString *)suit {
    return _suit ? _suit : @"?";
}

+(NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+(NSUInteger)maxRank { return [[self rankStrings]count]-1;}

-(void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end