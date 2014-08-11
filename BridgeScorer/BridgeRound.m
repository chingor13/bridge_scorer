//
//  BridgeRound.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "BridgeRound.h"
#import "GameState.h"
#import "GameScore.h"
#import "GameScorer.h"
#import "ContractOutcome.h"

@interface BridgeRound()
@property (strong, nonatomic) NSMutableArray *contracts;
@property (strong, nonatomic) NSMutableArray *northScoresAboveLine;
@property (strong, nonatomic) NSMutableArray *northScoresBelowLine;
@property (strong, nonatomic) NSMutableArray *eastScoresAboveLine;
@property (strong, nonatomic) NSMutableArray *eastScoresBelowLine;
@property (nonatomic) GameState *gameState;
@end

@implementation BridgeRound

- (id) init
{
    self = [super init];
    if(self)
    {
        self.contracts = [[NSMutableArray alloc] init];
        self.northScoresAboveLine = [[NSMutableArray alloc] init];
        self.northScoresBelowLine = [[NSMutableArray alloc] init];
        self.eastScoresAboveLine = [[NSMutableArray alloc] init];
        self.eastScoresBelowLine = [[NSMutableArray alloc] init];
        self.gameState = [[GameState alloc] init];
    }
    return self;
}

- (void) addContract:(BridgeContract *)contract
{
    [self.contracts addObject:contract];
    ContractOutcome *outcome = [GameScorer calculateGameScore:contract inGameState:self.gameState];
    GameScore *gs = outcome.gameScore;
    self.gameState = outcome.gameState;
    if(contract.north) {
        [self.northScoresAboveLine addObject:[NSNumber numberWithInteger:gs.offenseAboveLine]];
        [self.northScoresBelowLine addObject:[NSNumber numberWithInteger:gs.offenseBelowLine]];
        [self.eastScoresAboveLine addObject:[NSNumber numberWithInteger:gs.defenseAboveLine]];
        [self.eastScoresBelowLine addObject:[NSNumber numberWithInteger:0]];
    } else {
        [self.northScoresAboveLine addObject:[NSNumber numberWithInteger:gs.defenseAboveLine]];
        [self.northScoresBelowLine addObject:[NSNumber numberWithInteger:0]];
        [self.eastScoresAboveLine addObject:[NSNumber numberWithInteger:gs.offenseAboveLine]];
        [self.eastScoresBelowLine addObject:[NSNumber numberWithInteger:gs.offenseBelowLine]];
    }
}

- (void) undo
{
    [self.northScoresAboveLine removeLastObject];
    [self.northScoresBelowLine removeLastObject];
    [self.eastScoresAboveLine removeLastObject];
    [self.eastScoresBelowLine removeLastObject];
}

- (NSInteger) northTotal
{
    NSInteger sum = 0;
    for (NSNumber *num in self.northScoresBelowLine)
    {
        sum += [num intValue];
    }
    for (NSNumber *num in self.northScoresAboveLine)
    {
        sum += [num intValue];
    }
    return sum;
}

- (NSInteger) eastTotal
{
    NSInteger sum = 0;
    for (NSNumber *num in self.eastScoresBelowLine)
    {
        sum += [num intValue];
    }
    for (NSNumber *num in self.eastScoresAboveLine)
    {
        sum += [num intValue];
    }
    return sum;
}

@end
