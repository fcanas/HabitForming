//
//  HBTLoginViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTLoginViewController.h"

#import "HBTParseAppearanceTransformer.h"
#import "HBTSignUpViewController.h"

@interface HBTLoginViewController ()

@end

@implementation HBTLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HBTParseAppearanceTransformer *transformer = [HBTParseAppearanceTransformer new];
    transformer.tintColor = self.view.tintColor;
    
    [self.logInView setBackgroundColor:[UIColor whiteColor]];
    
    [transformer resetButton:self.logInView.logInButton];
    [transformer resetButton:self.logInView.signUpButton];
    [transformer resetButton:self.logInView.passwordForgottenButton];
    
    [self.logInView.passwordForgottenButton setTitle:@"Forgot" forState:UIControlStateNormal];
    
    // Remove text field shadows
    CALayer *layer = self.logInView.usernameField.layer;
    layer.shadowOpacity = 0.0;
    layer = self.logInView.passwordField.layer;
    layer.shadowOpacity = 0.0;
    
    // Remove Text Shadow
    self.logInView.signUpLabel.shadowColor = nil;
    
    self.logInView.usernameField.textColor = [UIColor blackColor];
    self.logInView.passwordField.textColor = [UIColor blackColor];
    
    // Add a Logo
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    logoLabel.text = @"HabitForming";
    logoLabel.textAlignment = NSTextAlignmentCenter;
    logoLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.logInView.logo = logoLabel;
    
    HBTSignUpViewController *signUpController = [HBTSignUpViewController new];
    signUpController.delegate = (id<PFSignUpViewControllerDelegate>)self.delegate;
    [self setSignUpController:signUpController];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Customize layout of Forgotten password button.
    [self.logInView.passwordForgottenButton setFrame:CGRectMake(self.logInView.signUpButton.frame.origin.x,
                                                                self.logInView.signUpButton.frame.origin.y + self.logInView.signUpButton.frame.size.height + 22,
                                                                self.logInView.signUpButton.frame.size.width,
                                                                44)];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
