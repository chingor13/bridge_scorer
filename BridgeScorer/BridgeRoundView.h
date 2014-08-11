//
//  BridgeRoundView.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BridgeRoundView : UIView

@property (strong, nonatomic) NSArray *topLeftScores;
@property (strong, nonatomic) NSArray *topRightScores;
@property (strong, nonatomic) NSArray *bottomLeftScores;
@property (strong, nonatomic) NSArray *bottomRightScores;

@end
