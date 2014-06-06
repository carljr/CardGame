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
    //Will need to set title for set cards - still using NSStrings for now
    
    SetCard *setCard = (SetCard *)card;

    if ([setCard.symbol isEqualToString:@"diamond"])
    {
        NSAttributedString *attributedTitleForCard = [[NSAttributedString alloc] initWithString: @"♦︎"];
        return attributedTitleForCard;
    }
    if ([setCard.symbol isEqualToString:@"squiggle"])
    {
        NSAttributedString *attributedTitleForCard = [[NSAttributedString alloc] initWithString: @"◼︎"];
        return attributedTitleForCard;
    }
    if ([setCard.symbol isEqualToString:@"circle"])
    {
        NSAttributedString *attributedTitleForCard = [[NSAttributedString alloc] initWithString: @"●"];
        return attributedTitleForCard;
    }

    return nil;
}

@end

