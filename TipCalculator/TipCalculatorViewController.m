//
//  TipCalculatorViewController.m
//  TipCalculator
//
//  Created by Tao Xia on 1/5/14.
//  Copyright (c) 2014 Tao Xia. All rights reserved.
//

#import "TipCalculatorViewController.h"
#import "SettingViewController.h"

@interface TipCalculatorViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLable;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
    
- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipCalculatorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"view will appear");

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int index = [defaults integerForKey:@"default_tip"];
    self.tipControl.selectedSegmentIndex = index;
    [self updateValues];
}
- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

-(void) updateValues {
    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValue = @[@(0.1), @(0.15), @(0.2)];
    
    float tipAmount = billAmount * [tipValue[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLable.text = [NSString stringWithFormat: @"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

-(void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];

}
@end
