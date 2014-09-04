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
@property (strong, nonatomic) NSMutableArray *contracts;
@property (strong, nonatomic) NSMutableArray *gameStates;
@property (strong, nonatomic) NSMutableArray *contractResults;
@property BOOL canUndo;
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

- (IBAction)reset:(id)sender
{
    self.canUndo = NO;
    self.contracts = [[NSMutableArray alloc] init];
    self.contractResults = [[NSMutableArray alloc] init];
    self.gameStates = [[NSMutableArray alloc] init];
    [self.gameStates addObject:[[GameState alloc] init]];
    [self.gameView reset];
    [self setContract:nil];
}

- (void)undo
{
    if(!self.canUndo){
        return;
    }
    
    if (self.currentContract) {
        // if we have a current contract, set it to nil
        [self setContract: nil];
        
        if ([self.gameStates count] == 1) {
            self.canUndo = NO;
        }
    } else {
        // undo the last results and set the current contract to the previous contract
        BridgeContract *lastContract = [self.contracts lastObject];
        [self.contracts removeLastObject];
        [self setContract:lastContract];
        
        [self.gameStates removeLastObject];
        [self.contractResults removeLastObject];
        
        [self.gameView undoLast];
    }
}

- (IBAction)undoSwipe:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.numberOfTouches == 2) {
        [self undo];
    }
}

- (void)setContract:(BridgeContract *)contract
{
    _currentContract = contract;
    if(contract) {
        // change Add button to Edit
        [self.addButton setTitle:@"Edit" forState:UIControlStateNormal];
        
        // set current contract label to the contract string
        self.contractLabel.text = [contract shortDescription];
        if(contract.north) {
            self.contractLabel.textAlignment = NSTextAlignmentLeft;
        } else {
            self.contractLabel.textAlignment = NSTextAlignmentRight;
        }
        
        // enable Results button
        self.resultsButton.enabled = YES;
        self.canUndo = YES;
    } else {
        // change Edit button to Add
        [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
        
        // clear current contract label
        self.contractLabel.text = @"";
        
        // disable Results button
        self.resultsButton.enabled = NO;
    }
}

- (void)setResults:(ContractResult *)result
{
    [self addResult:result];
    [self.contracts addObject:self.currentContract];
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
        [self.gameView addTopLeftScore:@(score.offenseAboveLine)];
        [self.gameView addBottomLeftScore:@(score.offenseBelowLine)];
        [self.gameView addTopRightScore:@(score.defenseAboveLine)];
        [self.gameView addBottomRightScore:@(0)];
    } else {
        [self.gameView addTopRightScore:@(score.offenseAboveLine)];
        [self.gameView addBottomRightScore:@(score.offenseBelowLine)];
        [self.gameView addTopLeftScore:@(score.defenseAboveLine)];
        [self.gameView addBottomLeftScore:@(0)];
    }
    
    if(outcome.gameMade) {
        [self.gameView addGameLine:self.currentContract.north];
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
