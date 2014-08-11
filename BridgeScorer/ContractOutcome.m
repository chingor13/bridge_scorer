//
//  ContractOutcome.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "ContractOutcome.h"

@implementation ContractOutcome

- (id) initWithGameState:(GameState *)gameState withGameScore:(GameScore *)gameScore
{
    self = [super init];
    self.gameState = gameState;
    self.gameScore = gameScore;
    return self;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"ContractOutcome: %@ %@", self.gameScore, self.gameState];
}

@end