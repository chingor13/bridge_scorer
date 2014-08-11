//
//  BridgeContract.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "BridgeContract.h"

@implementation BridgeContract

- (id) init
{
    self = [super init];
    self.honors = 0;
    self.doubled = NO;
    self.redoubled = NO;
    return self;
}

- (BOOL) madeContract
{
    return self.tricksMade >= self.bid + 6;
}

- (NSInteger) overtricks
{
    return [self madeContract] ? (self.tricksMade - self.bid - 6) : 0;
}

- (NSInteger) undertricks
{
    
    return [self madeContract] ? 0 : (self.bid + 6 - self.tricksMade);
}

@end
