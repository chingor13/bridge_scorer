//
//  BridgeContract.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardSuit.h"

@interface BridgeContract : NSObject

@property NSInteger bid;
@property CardSuit suit;
@property NSInteger tricksMade;
@property NSInteger honors;
@property BOOL north;
@property BOOL doubled;
@property BOOL redoubled;
- (BOOL) madeContract;
- (NSInteger) overtricks;
- (NSInteger) undertricks;

@end
