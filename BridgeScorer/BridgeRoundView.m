//
//  BridgeRoundView.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "BridgeRoundView.h"

@interface BridgeRoundView()

@property (strong, nonatomic) NSMutableArray *contracts;
@property (strong, nonatomic) NSMutableArray *scoreViews;
@property (strong, nonatomic) NSMutableArray *topLeftScores;
@property (strong, nonatomic) NSMutableArray *topRightScores;
@property (strong, nonatomic) NSMutableArray *bottomLeftScores;
@property (strong, nonatomic) NSMutableArray *bottomRightScores;
@property (strong, nonatomic) UILabel *weContracts;
@property (strong, nonatomic) UILabel *theyContracts;
@property (strong, nonatomic) UILabel *weLabel;
@property (strong, nonatomic) UILabel *theyLabel;

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
    NSInteger middleX = self.bounds.size.width / 2;
    self.contracts = [[NSMutableArray alloc] init];
    self.topLeftScores = [[NSMutableArray alloc] init];
    self.topRightScores = [[NSMutableArray alloc] init];
    self.bottomLeftScores = [[NSMutableArray alloc] init];
    self.bottomRightScores = [[NSMutableArray alloc] init];
    
    [self.weLabel removeFromSuperview];
    self.weLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width / 2, 30.0)];
    self.weLabel.text = @"WE";
    self.weLabel.adjustsFontSizeToFitWidth = YES;
    self.weLabel.textAlignment = NSTextAlignmentCenter;
    self.weLabel.minimumScaleFactor = 0.3f;
    [self addSubview:self.weLabel];
    
    [self.theyLabel removeFromSuperview];
    self.theyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width / 2, 0.0, self.bounds.size.width / 2, 30.0)];
    self.theyLabel.text = @"THEY";
    self.theyLabel.adjustsFontSizeToFitWidth = YES;
    self.theyLabel.textAlignment = NSTextAlignmentCenter;
    self.theyLabel.minimumScaleFactor = 0.3f;
    [self addSubview:self.theyLabel];
    
    [self.weContracts removeFromSuperview];
    self.weContracts = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, middleX, 20)];
    self.weContracts.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.weContracts];
    [self.theyContracts removeFromSuperview];
    self.theyContracts = [[UILabel alloc] initWithFrame:CGRectMake(middleX, 35, middleX, 20)];
    self.theyContracts.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.theyContracts];
    
    [self setNeedsDisplay];
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
    [self.contracts removeLastObject];
    [self setNeedsDisplay];
}

- (void)addContract:(BridgeContract *)contract
{
    [self.contracts addObject:contract];
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
    

    self.weContracts.text = [self contractDescriptionsForPredicate:[NSPredicate predicateWithFormat:@"north == YES"]];
    self.theyContracts.text = [self contractDescriptionsForPredicate:[NSPredicate predicateWithFormat:@"north == NO"]];
    
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
            if ([left intValue] == -1) {
                // we game
                [aPath moveToPoint:CGPointMake(10, maxY - 10)];
                [aPath addLineToPoint:CGPointMake(0, maxY)];
                [aPath addLineToPoint:CGPointMake(10, maxY + 10)];
            } else {
                // they game
                [aPath moveToPoint:CGPointMake(self.bounds.size.width - 10, maxY - 10)];
                [aPath addLineToPoint:CGPointMake(self.bounds.size.width, maxY)];
                [aPath addLineToPoint:CGPointMake(self.bounds.size.width - 10, maxY + 10)];
            }
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

- (NSString *) contractDescriptionsForPredicate:(NSPredicate *)predicate
{
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    for (BridgeContract *contract in [self.contracts filteredArrayUsingPredicate:predicate]) {
        [strings addObject:[contract shortDescription]];
    }
    return [strings componentsJoinedByString:@", "];
}

@end
