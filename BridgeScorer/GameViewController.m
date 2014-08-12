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
#import "ContractResult.h"
#import "GameScorer.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet BridgeRoundView *gameView;
@property (strong, nonatomic) NSMutableArray *gameStates;
@property (strong, nonatomic) NSMutableArray *contractResults;
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.contractResults = [[NSMutableArray alloc] init];
    self.gameStates = [[NSMutableArray alloc] init];
    [self.gameStates addObject:[[GameState alloc] init]];
}

- (void)addContract:(BridgeContract *)contract
{
    self.currentContract = contract;
}

- (void)completeContractWithTricks:(NSInteger)tricksMade withHonors:(NSInteger)honors
{
    ContractResult *result = [[ContractResult alloc] initWithContract:self.currentContract];
    result.tricksMade = tricksMade;
    result.honors = honors;
    [self addResult:result];
}

- (void)addResult:(ContractResult *)result
{
    [self.contractResults addObject:result];
    ContractOutcome *outcome = [GameScorer calculateGameScore:result inGameState:[self currentState]];
    [self.gameStates addObject:outcome.gameState];
    GameScore *score = outcome.gameScore;
    if(result.contract.north) {
        [self.gameView.topLeftScores addObject:[NSNumber numberWithInt:score.offenseAboveLine]];
        [self.gameView.bottomLeftScores addObject:[NSNumber numberWithInt:score.offenseBelowLine]];
        [self.gameView.topRightScores addObject:[NSNumber numberWithInt:score.defenseAboveLine]];
    } else {
        [self.gameView.topRightScores addObject:[NSNumber numberWithInt:score.offenseAboveLine]];
        [self.gameView.bottomRightScores addObject:[NSNumber numberWithInt:score.offenseBelowLine]];
        [self.gameView.topLeftScores addObject:[NSNumber numberWithInt:score.defenseAboveLine]];
    }
}

- (GameState *)currentState
{
    return self.gameStates[-1];
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
     }
}

@end
