//
//  BridgeRoundView.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "BridgeRoundView.h"

@implementation BridgeRoundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *aPath = [UIBezierPath bezierPath];
 
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(0.0, (self.bounds.size.height / 2))];
 
    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(self.bounds.size.width, (self.bounds.size.height / 2))];
    
    [aPath moveToPoint:CGPointMake((self.bounds.size.width / 2), 0.0)];
    [aPath addLineToPoint:CGPointMake(self.bounds.size.width / 2, self.bounds.size.height)];
    
    [aPath stroke];
}


@end
