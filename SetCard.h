//
//  SetCard.h
//  CardGame
//
//  Created by Davis, Carl on 5/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger number;

+(NSArray *)validSymbols;
+(NSArray *)validShadings;
+(NSArray *)validColors;
+(NSUInteger)maxNumber;

@end
