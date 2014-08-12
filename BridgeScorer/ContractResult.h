//
//  ContractResult.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/12/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BridgeContract.h"

@interface ContractResult : NSObject

- (id)initWithContract:(BridgeContract *)contract;
@property (strong, nonatomic) BridgeContract *contract;
@property NSInteger tricksMade;
@property NSInteger honors;
- (BOOL) madeContract;
- (NSInteger) overtricks;
- (NSInteger) undertricks;

@end
