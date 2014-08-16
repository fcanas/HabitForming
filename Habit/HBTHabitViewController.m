//
//  HBTHabitViewController.m
//  Habit
//
//  Created by Fabian Canas on 8/15/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTHabitViewController.h"

@interface HBTHabitViewController ()

@end

@implementation HBTHabitViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.progressLabel.text = [self.habit percentProgress];
    self.navigationItem.title = self.habit.name;
}

@end
