//
//  GameScorerTests.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GameScorer.h"

@interface GameScorerTests : XCTestCase

@end

@implementation GameScorerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMadeContract
{
    GameState *gs = [[GameState alloc] init];
    BridgeContract *contract = [[BridgeContract alloc] init];
    contract.bid = 3;
    contract.suit = CardSuitClubs;
    contract.tricksMade = 10;
    
    ContractOutcome *outcome = [GameScorer calculateGameScore:contract inGameState:gs];
    XCTAssertEqual(60, outcome.gameScore.offenseBelowLine, @"Failed");
    XCTAssertEqual(20, outcome.gameScore.offenseAboveLine, @"Failed");
}

@end
