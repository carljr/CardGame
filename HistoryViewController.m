//
//  HistoryViewController.m
//  CardGame
//
//  Created by Davis, Carl on 6/11/14.
//  Copyright (c) 2014 Carl Davis. All rights reserved.
//

#import "HistoryViewController.h"
#import "CardMatchingGame.h"

@interface HistoryViewController ()
@property (strong, nonatomic) IBOutlet UITextView *historyText;

@end

@implementation HistoryViewController

- (void)setHistory:(NSArray *)history
{
    _history = history;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.historyText.text = [self.history componentsJoinedByString:@"\n"];
}

@end
