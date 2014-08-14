//
//  HBTSignUpViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTSignUpViewController.h"

#import "HBTParseAppearanceTransformer.h"

@interface HBTSignUpViewController ()

@end

@implementation HBTSignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // This is likely the behavior we want, but there may be a bug in Parse 1.2.20
    // https://developers.facebook.com/bugs/616174788501031/
//    self.emailAsUsername = YES;
    
    HBTParseAppearanceTransformer *transformer = [HBTParseAppearanceTransformer new];
    transformer.tintColor = self.view.tintColor;
    
    [self.signUpView setBackgroundColor:[UIColor whiteColor]];
    
    [transformer resetButton:self.signUpView.signUpButton];
    
    // Remove text field shadows
    CALayer *layer = self.signUpView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.signUpView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    
    self.signUpView.usernameField.textColor = [UIColor blackColor];
    self.signUpView.passwordField.textColor = [UIColor blackColor];
    self.signUpView.passwordField.placeholder = @"password";
    self.signUpView.usernameField.placeholder = @"email";
    
    // Add a Logo
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    logoLabel.text = @"HabitForming";
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.signUpView.logo = logoLabel;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

@end
