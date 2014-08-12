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
    self.north = YES;
    self.doubled = NO;
    self.redoubled = NO;
    return self;
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

- (NSString *)doubledString
{
    if(self.redoubled) {
        return @"x4";
    } else if(self.doubled) {
        return @"x2";
    } else {
        return @"";
    }
}

- (NSString *)shortDescription
{
    return [NSString stringWithFormat:@"%ld%@%@",
            (long)self.bid,
            [self suitString],
            [self doubledString]];
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"BridgeContract:%@ by %@",
            [self shortDescription],
            [self ownerString]];
}
@end
