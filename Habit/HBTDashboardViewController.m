//
//  HBTDashboardViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTDashboardViewController.h"

#import "HBTHabit.h"
#import "HBTHabitViewController.h"
#import "HBTHabitTableViewCell.h"
#import "HBTLoginViewController.h"

#import <BlocksKit/BlocksKit+UIKit.h>
#import <Parse/Parse.h>

@interface HBTDashboardViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (nonatomic, strong) NSArray *habits;
@property (nonatomic, strong) HBTHabit *selectedHabit;
@end

@implementation HBTDashboardViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshHabits:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([PFUser currentUser] == nil) {
        HBTLoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:loginVC
                           animated:YES
                         completion:nil];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.habits.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedHabit = (HBTHabit *)self.habits[indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBTHabit *habit = (HBTHabit *)self.habits[indexPath.row];
    HBTHabitTableViewCell *cell = (HBTHabitTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Habit"];
    
    cell.nameLabel.text = habit.name;
    cell.percentLabel.text = [habit percentProgress];
    
    [cell.incrementButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
    [cell.incrementButton bk_addEventHandler:^(id sender) {
        [habit incrementCount];
        [habit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [tableView reloadRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationMiddle];
        }];
    }
                            forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (IBAction)refreshHabits:(UIRefreshControl *)sender
{
    PFQuery *query = [PFQuery queryWithClassName:@"Habit"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.habits = objects;
        [self.tableView reloadData];
        [sender endRefreshing];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"HabitDetailSegue"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if ([[segue destinationViewController] isKindOfClass:[HBTHabitViewController class]]) {
            [(HBTHabitViewController *)[segue destinationViewController] setHabit:self.habits[indexPath.row]];
        }
    }
}

#pragma mark - Login Handling

- (void)logInViewController:(PFLogInViewController *)logInController
               didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
