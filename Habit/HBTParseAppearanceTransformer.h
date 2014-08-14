//
//  HBTParseAppearanceTransformer.h
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBTParseAppearanceTransformer : NSObject

@property (nonatomic, copy) UIColor *tintColor;

- (void)resetButton:(UIButton *)button;

@end
