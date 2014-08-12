//
//  GameViewController.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/4/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BridgeRound.h"
#import "ContractDelegate.h"

@interface GameViewController : UIViewController <ContractDelegate>
@property BridgeRound *bridgeRound;
@end
