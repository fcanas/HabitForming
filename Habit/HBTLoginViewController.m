//
//  HBTLoginViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTLoginViewController.h"

@interface HBTLoginViewController ()

@end

@implementation HBTLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.logInView setBackgroundColor:[UIColor whiteColor]];
    
    [self resetButton:self.logInView.logInButton];
    [self resetButton:self.logInView.signUpButton];
    [self resetButton:self.logInView.passwordForgottenButton];
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

- (void)resetButton:(UIButton *)button
{
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:nil forState:UIControlStateHighlighted];
    [button setTitleColor:self.view.tintColor forState:UIControlStateNormal];
    [button setTitleColor:self.view.tintColor forState:UIControlStateHighlighted];
    [button setTitleShadowColor:nil forState:UIControlStateNormal];
    [button setTitleShadowColor:nil forState:UIControlStateHighlighted];
    
    button.layer.borderWidth = 1;
    button.layer.borderColor = button.tintColor.CGColor;
    
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
