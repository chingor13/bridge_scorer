//
//  GameState.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

@interface GameState : NSObject

@property NSInteger northPointsOn;
@property NSInteger eastPointsOn;
@property BOOL northVulnerable;
@property BOOL eastVulnerable;

- (id) initFromGameState:(GameState *)gameState;

@end
