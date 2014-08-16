//
//  HBTDashboardViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTDashboardViewController.h"

#import "HBTHabit.h"
#import "HBTHabitTableViewCell.h"
#import "HBTLoginViewController.h"

#import <Parse/Parse.h>

@interface HBTDashboardViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
@property (nonatomic, strong) NSArray *habits;
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
    HBTHabit *habit = (HBTHabit *)self.habits[indexPath.row];
    [habit incrementCount];
    [habit saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBTHabit *habit = (HBTHabit *)self.habits[indexPath.row];
    HBTHabitTableViewCell *cell = (HBTHabitTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Habit"];
    
    cell.nameLabel.text = habit.name;
    cell.percentLabel.text = [habit percentProgress];
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
