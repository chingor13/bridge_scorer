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
    GameState gs;
    gs.northVulnerable = NO;
    gs.eastVulnerable = NO;
    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
