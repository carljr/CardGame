//
//  SetCard.m
//  CardGame
//
//  Created by Davis, Carl on 5/21/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

-(int)match:(NSArray *)otherCards {
    
    int score = 0;
    //need to write match method.
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
