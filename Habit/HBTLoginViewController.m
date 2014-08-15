//
//  HBTLoginViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTLoginViewController.h"

#import "HBTParseAppearanceTransformer.h"

@interface HBTLoginViewController ()

@end

@implementation HBTLoginViewController

- (IBAction)loginWithFacebook:(id)sender
{
    NSArray *permissionsArray = @[ @"email", @"public_profile", @"user_friends" ];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user || error) {
            [[[UIAlertView alloc] initWithTitle:@"Problem logging in."
                                        message:@"Logging in with Facebook failed. Please try again later."
                                       delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil] show];
            return;
        }
        [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
