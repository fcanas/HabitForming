//
//  HBTHabit.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTHabit.h"
#import <Parse/PFObject+Subclass.h>

@implementation HBTHabit

@dynamic name;
@dynamic interval;

@dynamic targetNumber;
@dynamic targetUnit;
@dynamic count;

static NSNumberFormatter *numberFormatter;

+ (void)load
{
    [self registerSubclass];
    numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
}

+ (NSString *)parseClassName
{
    return @"Habit";
}

- (void)incrementCount
{
    [self incrementKey:NSStringFromSelector(@selector(count))];
}

- (NSString *)percentProgress
{
    float progress = ((float)self.count)/((float)self.targetNumber);
    return [numberFormatter stringFromNumber:@(progress)];
}

@end
