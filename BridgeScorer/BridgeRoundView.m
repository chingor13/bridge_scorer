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
        [self setup];
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self setup];
    
}

- (void)setup
{
    self.topLeftScores = @[];
    self.topRightScores = @[];
    self.bottomLeftScores = @[];
    self.bottomRightScores = @[];
    
    UILabel *weLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width / 2, 30.0)];
    weLabel.text = @"WE";
    weLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:weLabel];
    
    UILabel *theyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 0.0, self.bounds.size.width / 2, 30.0)];
    theyLabel.text = @"THEY";
    theyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:theyLabel];
}

- (void)setTopLeftScores:(NSArray *)topLeftScores
{
    _topLeftScores = topLeftScores;
    [self setNeedsDisplay];
}

- (void)setTopRightScores:(NSArray *)topRightScores
{
    _topRightScores = topRightScores;
    [self setNeedsDisplay];
}

- (void)setBottomLeftScores:(NSArray *)bottomLeftScores
{
    _bottomLeftScores = bottomLeftScores;
    [self setNeedsDisplay];
}

- (void)setBottomRightScores:(NSArray *)bottomRightScores
{
    _bottomRightScores = bottomRightScores;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    NSInteger middleX = self.bounds.size.width / 2;
    NSInteger middleY = self.bounds.size.height / 2;
 
    // Set the starting point of the shape.
    aPath.lineWidth = 4.0;
    [aPath moveToPoint:CGPointMake(0.0, middleY)];
 
    // Draw the lines.
    [aPath addLineToPoint:CGPointMake(self.bounds.size.width, middleY)];
    
    [aPath moveToPoint:CGPointMake(middleX, 0.0)];
    [aPath addLineToPoint:CGPointMake(middleX, self.bounds.size.height)];
    
    [aPath moveToPoint:CGPointMake(0.0, 30.0)];
    [aPath addLineToPoint:CGPointMake(self.bounds.size.width, 30.0)];
    [aPath stroke];
    
    NSInteger y = middleY - 30;
    for (NSNumber *number in self.topLeftScores) {
        if([number intValue] > 0) {
            UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, y, middleX, 20)];
            scoreLabel.text = [NSString stringWithFormat:@"%@", number];
            scoreLabel.textAlignment = NSTextAlignmentCenter;
            [scoreLabel setTextColor:[UIColor blackColor]];
            [self addSubview:scoreLabel];
            y -= 30;
        }
    }
    y = middleY - 30;
    for (NSNumber *number in self.topRightScores) {
        if([number intValue] > 0) {
            UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleX, y, middleX, 20)];
            scoreLabel.text = [NSString stringWithFormat:@"%@", number];
            scoreLabel.textAlignment = NSTextAlignmentCenter;
            [scoreLabel setTextColor:[UIColor blackColor]];
            [self addSubview:scoreLabel];
            y -= 30;
        }
    }
    
    aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 1.0;
    NSInteger leftY = middleY + 10;
    NSInteger rightY = middleY + 10;
    for (NSInteger i = 0; i < [self.bottomLeftScores count]; i++){
        NSNumber *left = [self.bottomLeftScores objectAtIndex:i];
        NSNumber *right = [self.bottomRightScores objectAtIndex:i];
        if([left intValue] < 0) {
            // we've hit a game line
            NSInteger maxY = (leftY > rightY) ? leftY : rightY;
            [aPath moveToPoint:CGPointMake(0, maxY)];
            [aPath addLineToPoint:CGPointMake(self.bounds.size.width,maxY)];
            leftY = maxY + 10;
            rightY = maxY + 10;
        } else {
            if([left intValue] > 0) {
                UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, leftY, middleX, 20)];
                scoreLabel.text = [NSString stringWithFormat:@"%@", left];
                scoreLabel.textAlignment = NSTextAlignmentCenter;
                [scoreLabel setTextColor:[UIColor blackColor]];
                [self addSubview:scoreLabel];
                leftY += 30;
            }
            if([right intValue] > 0) {
                UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleX, rightY, middleX, 20)];
                scoreLabel.text = [NSString stringWithFormat:@"%@", right];
                scoreLabel.textAlignment = NSTextAlignmentCenter;
                [scoreLabel setTextColor:[UIColor blackColor]];
                [self addSubview:scoreLabel];
                rightY += 30;
            }
        }
    }
    
    [aPath stroke];
}


@end
