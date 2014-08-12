//
//  ResultsViewController.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/12/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSArray *tricksArray;
@end

@implementation ResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tricksArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13"];
    // Do any additional setup after loading the view.
}

- (void)setContract:(BridgeContract *)contract
{
    _contract = contract;
    self.title = [contract shortDescription];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 14;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.tricksArray objectAtIndex:row];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
