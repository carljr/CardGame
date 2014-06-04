//
//  SetCardDeck.m
//  CardGame
//
//  Created by Davis, Carl on 5/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init {
    self = [super init];
    
    if (self) {
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSString *shading in [SetCard validShadings]) {
                for (NSString *color in [SetCard validColors]) {
                    for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++) {
                        SetCard *card = [[SetCard alloc]init];
                        card.symbol = symbol;
                        card.shading = shading;
                        card.color = color;
                        card.number = number;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
