//
//  GameScorer.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameState.h"
#import "BridgeContract.h"
#import "ContractResult.h"
#import "ContractOutcome.h"

@interface GameScorer : NSObject
+ (ContractOutcome *) calculateGameScore:(ContractResult *)result inGameState:(GameState *)currentGameState;
@end
