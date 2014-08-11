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

- (void)testClubsMadeContract
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

- (void)testDiamondsMadeContract
{
    GameState *gs = [[GameState alloc] init];
    BridgeContract *contract = [[BridgeContract alloc] init];
    contract.bid = 3;
    contract.suit = CardSuitDiamonds;
    contract.tricksMade = 10;
    
    ContractOutcome *outcome = [GameScorer calculateGameScore:contract inGameState:gs];
    XCTAssertEqual(60, outcome.gameScore.offenseBelowLine, @"Failed");
    XCTAssertEqual(20, outcome.gameScore.offenseAboveLine, @"Failed");
}

- (void) testNoTrumpMadeContract
{
    GameState *gs = [[GameState alloc] init];
    BridgeContract *contract = [[BridgeContract alloc] init];
    contract.bid = 3;
    contract.suit = CardSuitNoTrump;
    contract.tricksMade = 10;
    
    ContractOutcome *outcome = [GameScorer calculateGameScore:contract inGameState:gs];
    XCTAssertEqual(100, outcome.gameScore.offenseBelowLine, @"Failed");
    XCTAssertEqual(30, outcome.gameScore.offenseAboveLine, @"Failed");
    XCTAssert(outcome.gameState.northVulnerable, @"Expected north to be vulnerable");
    XCTAssertEqual(0, outcome.gameState.northPointsOn, @"Expected to have no points on after a made game");
}

@end
