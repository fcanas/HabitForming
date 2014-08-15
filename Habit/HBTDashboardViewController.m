//
//  HBTDashboardViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTDashboardViewController.h"

#import "HBTLoginViewController.h"
#import "HBTHabitTableViewCell.h"

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
    
    self.percentFormatter = [[NSNumberFormatter alloc] init];
    [self.percentFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    
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
    PFObject *habit = [self objectAtIndexPath:indexPath];
    [habit incrementKey:@"count"];
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
    PFObject *habit = [self objectAtIndexPath:indexPath];
    HBTHabitTableViewCell *cell = (HBTHabitTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Habit"];
    
    cell.nameLabel.text = habit[@"name"];
    cell.percentLabel.text = [self.percentFormatter stringFromNumber:@([habit[@"count"] floatValue]/[habit[@"targetNumber"] floatValue])];
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
