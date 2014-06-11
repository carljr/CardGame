//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Davis, Carl on 4/16/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score; // This is the over-all score
@property (nonatomic, readonly) NSInteger newPoints; // Points from last match
@property (nonatomic) int numberOfCardsToMatch;
@property (nonatomic, strong) NSString* gameStatus;
@property (nonatomic, strong) NSMutableArray *history;

@end
