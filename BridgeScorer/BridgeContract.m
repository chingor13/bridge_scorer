//
//  BridgeContract.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/10/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "BridgeContract.h"

@implementation BridgeContract

- (id) init
{
    self = [super init];
    self.honors = 0;
    self.north = YES;
    self.doubled = NO;
    self.redoubled = NO;
    return self;
}

- (BOOL) madeContract
{
    return self.tricksMade >= self.bid + 6;
}

- (NSInteger) overtricks
{
    return [self madeContract] ? (self.tricksMade - self.bid - 6) : 0;
}

- (NSInteger) undertricks
{
    
    return [self madeContract] ? 0 : (self.bid + 6 - self.tricksMade);
}

- (NSString *) suitString
{
    if(self.suit == CardSuitClubs) {
        return @"♣︎";
    } else if(self.suit == CardSuitDiamonds) {
        return @"♦︎";
    } else if(self.suit == CardSuitHearts) {
        return @"♥︎";
    } else if(self.suit == CardSuitSpades) {
        return @"♠︎";
    } else {
        return @"NT";
    }
}

- (NSString *) ownerString
{
    if(self.north) {
        return @"North/South";
    } else {
        return @"East/West";
    }
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"BridgeContract:%ld%@ by %@",
            (long)self.bid,
            [self suitString],
            [self ownerString]];
}
@end
