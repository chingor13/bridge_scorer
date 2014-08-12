//
//  ContractDelegate.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/12/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "BridgeContract.h";

@protocol ContractDelegate
- (void)addContract:(BridgeContract *)contract;
@end
