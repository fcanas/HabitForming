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
@property (nonatomic, strong) NSNumberFormatter *percentFormatter;
@end

@implementation HBTDashboardViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self == nil) {
        return nil;
    }
    
    self.parseClassName = @"Habit";
    
    return self;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBTHabit *habit = (HBTHabit *)[self objectAtIndexPath:indexPath];
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
    HBTHabit *habit = (HBTHabit *)[self objectAtIndexPath:indexPath];
    HBTHabitTableViewCell *cell = (HBTHabitTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Habit"];
    
    cell.nameLabel.text = habit.name;
    cell.percentLabel.text = [habit percentProgress];
    return cell;
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
