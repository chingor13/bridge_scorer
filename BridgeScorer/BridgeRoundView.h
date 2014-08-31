//
//  BridgeRoundView.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BridgeRoundView : UIView

- (void)reset;
- (void)undoLast;
- (void)addGameLine:(BOOL) we;
- (void)addTopLeftScore:(NSNumber *)number;
- (void)addTopRightScore:(NSNumber *)number;
- (void)addBottomLeftScore:(NSNumber *)number;
- (void)addBottomRightScore:(NSNumber *)number;

@end