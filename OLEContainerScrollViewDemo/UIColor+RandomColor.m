/*
 OLEContainerScrollView
 
 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

#import "UIColor+RandomColor.h"

@implementation UIColor (RandomColor)

+ (instancetype)randomColor
{
    return [self colorWithHue:arc4random_uniform(256)/255.0 saturation:1.0 brightness:1.0 alpha:1.0];
}

@end
