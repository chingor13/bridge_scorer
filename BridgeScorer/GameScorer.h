//
//  GameScorer.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardSuit.h"
#import "GameState.h"
#import "GameScore.h"
#import "BridgeContract.h"
#import "ContractOutcome.h"

@interface GameScorer : NSObject
+ (ContractOutcome *) calculateGameScore:(BridgeContract *)contract inGameState:(GameState *)currentGameState;
@end
