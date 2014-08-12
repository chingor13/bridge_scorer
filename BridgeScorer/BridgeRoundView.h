//
//  BridgeRoundView.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BridgeRoundView : UIView

@property (strong, nonatomic) NSMutableArray *topLeftScores;
@property (strong, nonatomic) NSMutableArray *topRightScores;
@property (strong, nonatomic) NSMutableArray *bottomLeftScores;
@property (strong, nonatomic) NSMutableArray *bottomRightScores;

@end
