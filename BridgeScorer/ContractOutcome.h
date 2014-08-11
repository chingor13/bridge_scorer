//
//  ContractOutcome.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"
#import "GameScorer.h"

@interface ContractOutcome : NSObject

@property GameState *gameState;
@property GameScore *gameScore;

- (id) initWithGameState:(GameState *)gameState withGameScore:(GameScore *)gameScore;

@end
