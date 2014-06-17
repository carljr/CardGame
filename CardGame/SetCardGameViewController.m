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
#import "HistoryViewController.h"


@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowHistory"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            [segue.destinationViewController setHistory:self.game.history];
        }
    }
}

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
    return [UIImage imageNamed:card.isChosen ? @"SelectedSetCard" : @"cardfront"];
    //return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

-(NSAttributedString *)titleForCard:(Card *)card
{
    SetCard *setCard = (SetCard *)card;
    
    //Setting symbol for Card
    NSString *titleForCard = @"?";
    
    if ([setCard.symbol isEqualToString:@"diamond"])
    {
        titleForCard = @"♦︎";
    }
    if ([setCard.symbol isEqualToString:@"squiggle"])
    {
        titleForCard = @"◼︎";
    }
    if ([setCard.symbol isEqualToString:@"circle"])
    {
        titleForCard = @"●";
    }
    
    //Setting the number of symbols for the title
    NSMutableString *numberedTitleForCard = [NSMutableString stringWithCapacity:3];
    for (int i = 0; i < setCard.number; i++)
    {
        [numberedTitleForCard appendString:titleForCard];
    }
       
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

    // Put title together with attributes
    NSAttributedString *attributedTitleForCard = [[NSAttributedString alloc] initWithString:numberedTitleForCard attributes: titleAttributes];
    
    return attributedTitleForCard;
}

@end

