//
//  HBTCreateHabitViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTCreateHabitViewController.h"

#import "HBTHabit.h"

#import <Parse/Parse.h>

@interface HBTCreateHabitViewController ()
@property (nonatomic, weak) IBOutlet UITextField *habitNameField;
@property (nonatomic, weak) IBOutlet UITextField *targetNumberField;
@property (nonatomic, weak) IBOutlet UITextField *targetUnitField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *intervalPicker;
@property (nonatomic, weak) IBOutlet UISwitch *privateSwitch;
@end

@implementation HBTCreateHabitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.intervalPicker.selectedSegmentIndex = 1;
}

#pragma mark - Actions

- (IBAction)createHabit:(id)sender
{
    NSArray *segmentValues = @[@"Day", @"Week", @"Month"];
    
    HBTHabit *habit = [[HBTHabit alloc] init];
    
    habit.name = self.habitNameField.text;
    habit.targetNumber = [self.targetNumberField.text integerValue];
    habit.targetUnit = self.targetUnitField.text;
    habit.interval = segmentValues[self.intervalPicker.selectedSegmentIndex];
    habit.count = 0;
    
    PFACL *habitACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [habitACL setPublicReadAccess:!self.privateSwitch.enabled];
    [habit setACL:habitACL];
    
    [habit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)cancel:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)advanceForm:(id)sender
{
    if (sender == self.habitNameField) {
        [self.targetNumberField becomeFirstResponder];
    } else if (sender == self.targetNumberField) {
        [self.targetUnitField becomeFirstResponder];
    } else {
        [sender resignFirstResponder];
    }
}

@end
