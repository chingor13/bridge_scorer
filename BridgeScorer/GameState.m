//
//  GameState.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "GameState.h"

@implementation GameState

- (id) init
{
    self = [super init];
    self.northPointsOn = 0;
    self.eastPointsOn = 0;
    self.northVulnerable = NO;
    self.eastVulnerable = NO;
    return self;
}

@end
