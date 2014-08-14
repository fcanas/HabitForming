//
//  HBTHabitTableViewCell.h
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface HBTHabitTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIButton *incrementButton;

@end
