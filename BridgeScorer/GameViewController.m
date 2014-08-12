//
//  GameViewController.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/4/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "GameViewController.h"
#import "BridgeRoundView.h"
#import "ContractViewController.h"

@interface GameViewController ()
@property (weak, nonatomic) IBOutlet BridgeRoundView *gameView;
@end

@implementation GameViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    // Testing
    self.gameView.topLeftScores = @[[NSNumber numberWithInt:30],
                                    [NSNumber numberWithInt:40]];
    
    self.gameView.topRightScores = @[[NSNumber numberWithInt:50],
                                     [NSNumber numberWithInt:100]];
    
    self.gameView.bottomLeftScores = @[[NSNumber numberWithInt:100],
                                       [NSNumber numberWithInt:30]];
    
    self.gameView.bottomRightScores = @[[NSNumber numberWithInt:60]];
}

- (void)addContract:(BridgeContract *)contract
{
//    [self.gameView addC];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
     if([segue.identifier isEqualToString:@"Create Contract Segue"]) {
         ContractViewController *cvc = segue.destinationViewController;
         cvc.contractDelegate = self;
     }
}

@end
