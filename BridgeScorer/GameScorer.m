//
//  GameScorer.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "GameScorer.h"

@implementation GameScorer

+ (ContractOutcome *) calculateGameScore:(ContractResult *)result inGameState:(GameState *)currentGameState
{
    BridgeContract *contract = result.contract;
    GameScore *gameScore = [[GameScore alloc] init];
    GameState *gameState = [[GameState alloc] initFromGameState:currentGameState];
    
    NSInteger firstTrickPoints = 20;
    NSInteger otherTrickPoints = 20;
    if(contract.suit == CardSuitHearts || contract.suit == CardSuitSpades) {
        firstTrickPoints = 30;
        otherTrickPoints = 30;
    } else if(contract.suit == CardSuitNoTrump) {
        firstTrickPoints = 40;
        otherTrickPoints = 30;
    }
    BOOL bidderIsVulnerable = NO;
    BOOL defenseIsVulnerable = NO;
    NSInteger pointsOn = 0;
    if (contract.north) {
        bidderIsVulnerable = currentGameState.northVulnerable;
        defenseIsVulnerable = currentGameState.eastVulnerable;
        pointsOn = currentGameState.northPointsOn;
    } else {
        bidderIsVulnerable = currentGameState.eastVulnerable;
        defenseIsVulnerable = currentGameState.northVulnerable;
        pointsOn = currentGameState.eastPointsOn;
    }
    
    if([result madeContract]) {
        if(contract.doubled) {
            if(contract.redoubled) {
                firstTrickPoints *= 4;
                otherTrickPoints *= 4;
                gameScore.offenseAboveLine = 100;
            } else {
                firstTrickPoints *= 4;
                otherTrickPoints *= 4;
                gameScore.offenseAboveLine = 50;
            }
        }
        gameScore.offenseBelowLine = firstTrickPoints;
        gameScore.offenseBelowLine += otherTrickPoints * (contract.bid - 1);
        gameScore.offenseAboveLine += otherTrickPoints * result.overtricks;
        
        // if making a game
        if(pointsOn + gameScore.offenseBelowLine >= 100) {
            if(bidderIsVulnerable) {
                // made a rubber
                if(defenseIsVulnerable) {
                    gameScore.offenseAboveLine += 500;
                } else {
                    gameScore.offenseAboveLine += 700;
                }
                gameState.northVulnerable = NO;
                gameState.eastVulnerable = NO;
            } else {
                if(contract.north) {
                    gameState.northVulnerable = YES;
                } else {
                    gameState.eastVulnerable = YES;
                }
            }
            gameState.northPointsOn = 0;
            gameState.eastPointsOn = 0;
        }
    } else {
        if(bidderIsVulnerable) {
            if(contract.doubled) {
                if(contract.redoubled) {
                    gameScore.defenseAboveLine = 400;
                    gameScore.defenseAboveLine += (600 * (result.undertricks - 1));
                } else {
                    // double vulnerable
                    gameScore.defenseAboveLine = 200;
                    gameScore.defenseAboveLine += (300 * (result.undertricks - 1));
                }
            } else {
                // vulnerable
                gameScore.defenseAboveLine = result.undertricks * 100;
            }
        } else {
            if(contract.doubled) {
                if(contract.redoubled) {
                    gameScore.defenseAboveLine = 200;
                    if(result.undertricks > 3) {
                        gameScore.defenseAboveLine = 1000 + 600 * (result.undertricks - 3);
                    } else {
                        gameScore.defenseAboveLine += (400 * (result.undertricks - 1));
                    }
                    gameScore.defenseAboveLine += (300 * (result.undertricks - 1));
                } else {
                    gameScore.defenseAboveLine = 100;
                    if(result.undertricks > 3) {
                        gameScore.defenseAboveLine = 500 + 300 * (result.undertricks - 3);
                    } else {
                        gameScore.defenseAboveLine += (200 * (result.undertricks - 1));
                    }
                }
            } else {
                // default
                gameScore.defenseAboveLine = result.undertricks * 50;
            }
        }
    }
    
    // bonus points - honors
    gameScore.offenseAboveLine += result.honors;
    
    return [[ContractOutcome alloc] initWithGameState:gameState withGameScore:gameScore];
}

@end
