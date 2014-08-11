//
//  GameScore.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "GameScore.h"

@implementation GameScore

- (id) init
{
    self = [super init];
    self.offenseAboveLine = 0;
    self.offenseBelowLine = 0;
    self.defenseAboveLine = 0;
    return self;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"GameScore: %ld/%ld vs %ld", (long)self.offenseAboveLine, (long)self.offenseBelowLine, (long)self.defenseAboveLine];
}

@end
