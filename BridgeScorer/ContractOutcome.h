//
//  ContractOutcome.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"
#import "GameScore.h"

@interface ContractOutcome : NSObject

@property (strong, nonatomic) GameState *gameState;
@property (strong, nonatomic) GameScore *gameScore;
@property BOOL gameMade;

- (id) initWithGameState:(GameState *)gameState withGameScore:(GameScore *)gameScore;

@end
