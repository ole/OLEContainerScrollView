//
//  UIColor+RandomColor.m
//  OLEContainerScrollViewDemo
//
//  Created by Ole Begemann on 24.06.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (instancetype)randomColor
{
    return [self colorWithHue:arc4random_uniform(256)/255.0 saturation:1.0 brightness:1.0 alpha:1.0];
}

@end
