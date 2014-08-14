//
//  HBTParseAppearanceTransformer.m
//  Habit
//
//  Created by Fabian Canas on 8/14/14.
//  Copyright (c) 2014 Fabián Cañas. All rights reserved.
//

#import "HBTParseAppearanceTransformer.h"

@implementation HBTParseAppearanceTransformer

- (void)resetButton:(UIButton *)button
{
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setBackgroundImage:nil forState:UIControlStateHighlighted];
    [button setTitleColor:self.tintColor forState:UIControlStateNormal];
    [button setTitleColor:self.tintColor forState:UIControlStateHighlighted];
    [button setTitleShadowColor:nil forState:UIControlStateNormal];
    [button setTitleShadowColor:nil forState:UIControlStateHighlighted];
    
    button.layer.borderWidth = 1;
    button.layer.borderColor = button.tintColor.CGColor;
}

@end
