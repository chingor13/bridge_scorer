//
//  ContractViewController.h
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContractDelegate.h"

@interface ContractViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) id<ContractDelegate> contractDelegate;

@end
