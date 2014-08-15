//
//  HBTHabit.h
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import <Parse/Parse.h>

@interface HBTHabit : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (copy) NSString *name;
@property (copy) NSString *interval;
@property (copy) NSString *targetUnit;

@property NSUInteger targetNumber;
@property NSUInteger count;

- (void)incrementCount;

- (NSString *)percentProgress;

@end
