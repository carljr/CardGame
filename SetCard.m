//
//  SetCard.m
//  CardGame
//
//  Created by Davis, Carl on 5/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards
{
    
    int score = 0;
    BOOL posibleMatch = YES; // if greater than zero we do not have a match
    
    // only works when 3 is selected
    if ([otherCards count] == 2)
    {
        SetCard *card0 = [otherCards objectAtIndexedSubscript:0];
        SetCard *card1 = [otherCards objectAtIndexedSubscript:1];
        
        //Matching symbols
        if ((card0.symbol == card1.symbol) && (self.symbol == card0.symbol))
        {
            posibleMatch = YES && posibleMatch;
        } else if ((card0.symbol != card1.symbol) && (card0.symbol != self.symbol) && (card1.symbol != self.symbol))
        {
            posibleMatch = YES & posibleMatch;
        } else
            posibleMatch = NO;
        
        //Matching shading
        if ((card0.shading == card1.shading) && (self.shading == card0.shading))
        {
            posibleMatch = YES && posibleMatch;
        } else if ((card0.shading != card1.shading) && (card0.shading != self.shading) && (card1.shading != self.shading))
        {
            posibleMatch = YES & posibleMatch;
        } else
            posibleMatch = NO;
        
        //Matching color
        if ((card0.color == card1.color) && (self.color == card0.color))
        {
            posibleMatch = YES && posibleMatch;
        } else if ((card0.color != card1.color) && (card0.color != self.color) && (card1.color != self.color))
        {
            posibleMatch = YES & posibleMatch;
        } else
            posibleMatch = NO;
        
        //Matching number
        if ((card0.number == card1.number) && (self.number == card0.number))
        {
            posibleMatch = YES && posibleMatch;
        } else if ((card0.number != card1.number) && (card0.number != self.number) && (card1.number != self.number))
        {
            posibleMatch = YES & posibleMatch;
        } else
            posibleMatch = NO;
    }
    
    if (posibleMatch) score +=4;
    
    return score;
}

-(NSString *)contents {
    //contents will be one long string with the property details separated by colons - will not display on card ofcourse
    return [NSString stringWithFormat:@"%@:%@:%@:%d", self.symbol, self.color, self.shading, self.number];
}

+(NSArray *)validSymbols{
    return @[@"diamond",@"squiggle",@"circle"];
}

@synthesize symbol = _symbol; // because we provide setter AND getter

-(void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

-(NSString *)symbol {
    return _symbol ? _symbol : @"?";
}

+(NSArray *)validShadings{
    return @[@"solid",@"striped",@"open"];
}

@synthesize shading = _shading; // because we provide setter AND getter

-(void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

-(NSString *)shading {
    return _shading ? _shading : @"?";
}

+(NSArray *)validColors{
    return @[@"red",@"green",@"purple"];
}

@synthesize color = _color; // because we provide setter AND getter

-(void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

-(NSString *)color {
    return _color ? _color : @"?";
}

+(NSUInteger)maxNumber {
    return 3;
}

-(void)setNumber:(NSUInteger)number {
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
}




@end
