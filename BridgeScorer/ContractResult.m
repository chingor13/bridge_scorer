//
//  ContractResult.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/12/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "ContractResult.h"

@implementation ContractResult

- (id)initWithContract:(BridgeContract *)contract
{
    self = [super init];
    self.honors = 0;
    self.contract = contract;
    return self;
}

- (BOOL) madeContract
{
    return self.tricksMade >= self.contract.bid + 6;
}

- (NSInteger) overtricks
{
    return [self madeContract] ? (self.tricksMade - self.contract.bid - 6) : 0;
}

- (NSInteger) undertricks
{
    
    return [self madeContract] ? 0 : (self.contract.bid + 6 - self.tricksMade);
}


@end
