//
//  SetCardGameViewController.m
//  CardGame
//
//  Created by Carl Davis on 6/3/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super updateUI];
}

- (Deck *) createDeck
{
    return [[SetCardDeck alloc]init];
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    // for now making card always show card front as a test since it is white
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardfront"];
    //return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

-(NSAttributedString *)titleForCard:(Card *)card
{
    SetCard *setCard = (SetCard *)card;
    
    //setting color
    NSMutableDictionary *titleAttributes = [[NSMutableDictionary alloc]init];
    if ([setCard.color  isEqual: @"red"]) {
        [titleAttributes addEntriesFromDictionary: @{NSForegroundColorAttributeName : [UIColor redColor]}];
    }
    
    if ([setCard.color  isEqual: @"green"]) {
        [titleAttributes addEntriesFromDictionary: @{NSForegroundColorAttributeName : [UIColor greenColor]}];
    }
    
    if ([setCard.color  isEqual: @"purple"]) {
        [titleAttributes addEntriesFromDictionary: @{NSForegroundColorAttributeName : [UIColor purpleColor]}];
    }
    
    //setting fill
    if ([setCard.shading  isEqual: @"solid"]) {
        [titleAttributes addEntriesFromDictionary: @{NSStrokeWidthAttributeName : @-5}];
    }
    // will use transperant color for striped. Read current forground color and use for outline then make transperant.
    if ([setCard.shading  isEqual: @"striped"]) {
        [titleAttributes addEntriesFromDictionary: @{NSStrokeWidthAttributeName : @-5,
                                                     NSStrokeColorAttributeName : titleAttributes[NSForegroundColorAttributeName],
                                                     NSForegroundColorAttributeName : [titleAttributes[NSForegroundColorAttributeName] colorWithAlphaComponent:0.4]}];
    }

    if ([setCard.shading  isEqual: @"open"]) {
        [titleAttributes addEntriesFromDictionary: @{NSStrokeWidthAttributeName : @5}];
    }


    if ([setCard.symbol isEqualToString:@"diamond"])
    {
        NSAttributedString *attributedTitleForCard = [[NSAttributedString alloc] initWithString: @"♦︎" attributes: titleAttributes];
        return attributedTitleForCard;
    }
    if ([setCard.symbol isEqualToString:@"squiggle"])
    {
        NSAttributedString *attributedTitleForCard = [[NSAttributedString alloc] initWithString: @"◼︎" attributes: titleAttributes];
        return attributedTitleForCard;
    }
    if ([setCard.symbol isEqualToString:@"circle"])
    {
        NSAttributedString *attributedTitleForCard = [[NSAttributedString alloc] initWithString: @"●" attributes: titleAttributes];
        return attributedTitleForCard;
    }

    return nil;
}

@end

