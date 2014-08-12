//
//  ResultsViewController.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/12/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BridgeContract.h"
#import "ContractDelegate.h"

@interface ResultsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) BridgeContract *contract;
@property (strong, nonatomic) id<ContractDelegate> contractDelegate;

@end
