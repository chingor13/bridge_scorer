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

- (NSString *) description
{
    return [NSString stringWithFormat:@"BridgeContract:%ld%@ by %@",
            (long)self.bid,
            [self suitString],
            [self ownerString]];
}
@end
