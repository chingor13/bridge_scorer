//
//  ContractDelegate.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/12/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "BridgeContract.h"
#import "ContractResult.h"

@protocol ContractDelegate
- (void)setContract:(BridgeContract *)contract;
- (void)setResults:(ContractResult *)result;
@end
