//
//  GameViewController.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/4/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "GameViewController.h"
#import "BridgeRoundView.h"
#import "ContractViewController.h"
#import "ResultsViewController.h"
#import "ContractResult.h"
#import "GameScorer.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet BridgeRoundView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *contractLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *resultsButton;
@property (strong, nonatomic) NSMutableArray *gameStates;
@property (strong, nonatomic) NSMutableArray *contractResults;
@end

@implementation GameViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self reset:nil];
}

- (IBAction)reset:(id)sender {
    NSLog(@"Resetting");
    self.contractResults = [[NSMutableArray alloc] init];
    self.gameStates = [[NSMutableArray alloc] init];
    [self.gameStates addObject:[[GameState alloc] init]];
    [self.gameView reset];
    [self setContract:nil];
}

- (void)setContract:(BridgeContract *)contract
{
    _currentContract = contract;
    if(contract) {
        // change Add button to Edit
        self.addButton.titleLabel.text = @"Edit";
        
        // set current contract label to the contract string
        self.contractLabel.text = [contract shortDescription];
        if(contract.north) {
            self.contractLabel.textAlignment = NSTextAlignmentLeft;
        } else {
            self.contractLabel.textAlignment = NSTextAlignmentRight;
        }
        
        // enable Results button
        self.resultsButton.enabled = YES;
    } else {
        // change Edit button to Add
        self.addButton.titleLabel.text = @"Add";
        
        // clear current contract label
        self.contractLabel.text = @"";
        
        // disable Results button
        self.resultsButton.enabled = NO;
    }
}

- (void)setResults:(ContractResult *)result
{
    [self addResult:result];
    // unset current contract
    [self setContract: nil];
}

- (void)addResult:(ContractResult *)result
{
    [self.contractResults addObject:result];
    ContractOutcome *outcome = [GameScorer calculateGameScore:result inGameState:[self currentState]];
    [self.gameStates addObject:outcome.gameState];
    GameScore *score = outcome.gameScore;
    
    if(result.contract.north) {
        self.gameView.topLeftScores = [self.gameView.topLeftScores arrayByAddingObject:[NSNumber numberWithInt:score.offenseAboveLine]];
        self.gameView.bottomLeftScores = [self.gameView.bottomLeftScores arrayByAddingObject:[NSNumber numberWithInt:score.offenseBelowLine]];
        self.gameView.topRightScores = [self.gameView.topRightScores arrayByAddingObject:[NSNumber numberWithInt:score.defenseAboveLine]];
        self.gameView.bottomRightScores = [self.gameView.bottomRightScores arrayByAddingObject:[NSNumber numberWithInt:0]];

    } else {
        self.gameView.topRightScores = [self.gameView.topRightScores arrayByAddingObject:[NSNumber numberWithInt:score.offenseAboveLine]];
        self.gameView.bottomRightScores = [self.gameView.bottomRightScores arrayByAddingObject:[NSNumber numberWithInt:score.offenseBelowLine]];
        self.gameView.topLeftScores = [self.gameView.topLeftScores arrayByAddingObject:[NSNumber numberWithInt:score.defenseAboveLine]];
        self.gameView.bottomLeftScores = [self.gameView.bottomLeftScores arrayByAddingObject:[NSNumber numberWithInt:0]];
    }
    
    if(outcome.gameMade) {
        self.gameView.bottomLeftScores =[self.gameView.bottomLeftScores arrayByAddingObject:[NSNumber numberWithInt:-1]];
        self.gameView.bottomRightScores =[self.gameView.bottomRightScores arrayByAddingObject:[NSNumber numberWithInt:-1]];
    }
}

- (GameState *)currentState
{
    return self.gameStates[[self.gameStates count] - 1];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"Create Contract Segue"]) {
         ContractViewController *cvc = segue.destinationViewController;
         cvc.contractDelegate = self;
     } else if([segue.identifier isEqualToString:@"Results Segue"]){
         ResultsViewController *rvc = segue.destinationViewController;
         rvc.contract = [self currentContract];
         rvc.contractDelegate = self;
     }
}

@end
