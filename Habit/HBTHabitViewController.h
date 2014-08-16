//
//  HBTHabitViewController.h
//  Habit
//
//  Created by Fabian Canas on 8/15/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBTHabit.h"

@interface HBTHabitViewController : UIViewController

@property (strong, nonatomic) HBTHabit *habit;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;

@end
