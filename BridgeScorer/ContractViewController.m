//
//  ContractViewController.m
//  BridgeScorer
//
//  Created by Jeffrey Ching on 8/11/14.
//  Copyright (c) 2014 Jeffrey Ching. All rights reserved.
//

#import "ContractViewController.h"
#import "GameViewController.h"
#import "BridgeContract.h"

@interface ContractViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *suitPicker;
@property (weak, nonatomic) IBOutlet UISlider *resultsSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *doubleCountrol;
@property (weak, nonatomic) IBOutlet UISwitch *teamSwitch;
@property (strong, nonatomic) NSArray *suitArray;
@property (strong, nonatomic) NSArray *bidArray;
@property (nonatomic) BOOL doubled;
@property (nonatomic) BOOL redoubled;
@property (nonatomic) NSInteger honors;
@end

@implementation ContractViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)contractDoublingChanged:(id)sender
{
    if([sender selectedSegmentIndex] == 2) {
        self.doubled = YES;
        self.redoubled = YES;
    } else if([sender selectedSegmentIndex] == 1) {
        self.doubled = YES;
        self.redoubled = NO;
    } else {
        self.doubled = NO;
        self.redoubled = NO;
    }
}

- (IBAction)honorsChanged:(id)sender
{
    NSInteger honorPoints[] = {0, 100, 150};
    self.honors = honorPoints[[sender selectedSegmentIndex]];
}

- (IBAction)saveContract:(id)sender
{
    [self.contractDelegate setContract:[self buildContract]];
    [self.navigationController popViewControllerAnimated:true];
}

- (BridgeContract *)buildContract
{
    BridgeContract *contract = [[BridgeContract alloc] init];
    contract.bid = [self bid];
    contract.suit = [self selectedSuit];
    contract.doubled = self.doubled;
    contract.redoubled = self.redoubled;
    contract.north = !self.teamSwitch.on;
    return contract;
}

- (NSInteger)bid
{
    return 4;
}

- (CardSuit)selectedSuit
{
    return CardSuitClubs;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.suitArray = @[@"♣︎",@"♦︎",@"♥︎",@"♠︎",@"NT"];
    self.bidArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
    // Do any additional setup after loading the view.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0) {
        return [self.bidArray count];
    } else {
        return [self.suitArray count];
    }
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if(component == 0) {
        return [self.bidArray objectAtIndex:row];
    } else {
        return [self.suitArray objectAtIndex:row];
    }
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
