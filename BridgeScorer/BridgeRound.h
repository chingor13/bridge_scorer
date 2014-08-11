//
//  BridgeRound.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BridgeContract.h"

@interface BridgeRound : NSObject
- (void) addContract:(BridgeContract *)contract;
- (void) undo;
- (NSInteger) northTotal;
- (NSInteger) eastTotal;
@end
