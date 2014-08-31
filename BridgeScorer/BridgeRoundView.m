//
//  BridgeRoundView.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "BridgeRoundView.h"

@interface BridgeRoundView()

@property (strong, nonatomic) NSMutableArray *scoreViews;
@property (strong, nonatomic) NSMutableArray *topLeftScores;
@property (strong, nonatomic) NSMutableArray *topRightScores;
@property (strong, nonatomic) NSMutableArray *bottomLeftScores;
@property (strong, nonatomic) NSMutableArray *bottomRightScores;
@end

@implementation BridgeRoundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self reset];
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self reset];
}

- (void)reset
{
    self.topLeftScores = [[NSMutableArray alloc] init];
    self.topRightScores = [[NSMutableArray alloc] init];
    self.bottomLeftScores = [[NSMutableArray alloc] init];
    self.bottomRightScores = [[NSMutableArray alloc] init];
    
    UILabel *weLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width / 2, 30.0)];
    weLabel.text = @"WE";
    weLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:weLabel];
    
    UILabel *theyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 0.0, self.bounds.size.width / 2, 30.0)];
    theyLabel.text = @"THEY";
    theyLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:theyLabel];
}

- (void)undoLast
{
    [self.topLeftScores removeLastObject];
    [self.topRightScores removeLastObject];
    
    // if the last thing was a game, remove it and the last scores
    if ([[self.bottomLeftScores lastObject] intValue] < 0) {
        [self.bottomLeftScores removeLastObject];
        [self.bottomRightScores removeLastObject];
    }
    [self.bottomLeftScores removeLastObject];
    [self.bottomRightScores removeLastObject];
    [self setNeedsDisplay];
}

- (void)addTopLeftScore:(NSNumber *)number
{
    [self.topLeftScores addObject:number];
    [self setNeedsDisplay];
}

- (void)addTopRightScore:(NSNumber *)number
{
    [self.topRightScores addObject:number];
    [self setNeedsDisplay];
}

- (void)addBottomLeftScore:(NSNumber *)number
{
    [self.bottomLeftScores addObject:number];
    [self setNeedsDisplay];
}

- (void)addBottomRightScore:(NSNumber *)number
{
    [self.bottomRightScores addObject:number];
    [self setNeedsDisplay];
}

- (void) addGameLine:(BOOL)we
{
    if (we) {
        [self addBottomLeftScore:@(-1)];
        [self addBottomRightScore:@(-1)];
    } else {
        [self addBottomLeftScore:@(-2)];
        [self addBottomRightScore:@(-2)];
    }
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [self.scoreViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scoreViews = [[NSMutableArray alloc] init];
    
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
            [self.scoreViews addObject:scoreLabel];
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
            [self.scoreViews addObject:scoreLabel];
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
                [self.scoreViews addObject:scoreLabel];
                leftY += 30;
            }
            if([right intValue] > 0) {
                UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleX, rightY, middleX, 20)];
                scoreLabel.text = [NSString stringWithFormat:@"%@", right];
                scoreLabel.textAlignment = NSTextAlignmentCenter;
                [scoreLabel setTextColor:[UIColor blackColor]];
                [self addSubview:scoreLabel];
                [self.scoreViews addObject:scoreLabel];
                rightY += 30;
            }
        }
    }
    
    [aPath stroke];
}


@end
