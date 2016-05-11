/*
 OLEContainerScrollView

 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

#import "ChildViewUsingAutolayout.h"

@implementation ChildViewUsingAutolayout

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        [self updateText];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self updateText];
}

- (IBAction)changeTextButtonTapped:(UIButton *)sender
{
    [self updateText];
}

- (void)updateText
{
    self.textLabel.text = [[self class] randomText];

    // Update our bounds to "notify" the `OLEContainerScrollView` to recompute its layout.
    // TODO: This is a hack, not a very good solution. If we want `OLEContainerScrollView` to work
    // properly with subviews using auto layout, we probably have to change it completely to use
    // constraints for everything.
    CGSize fittingSize = [self systemLayoutSizeFittingSize:UILayoutFittingExpandedSize];
    self.bounds = (CGRect){ CGPointZero, fittingSize };
}

+ (NSString *)randomText
{
    NSArray *texts = @[
                       @"Lorem ipsum dolor sit amet.",
                       @"Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
                       @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                       @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                       @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                       @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                       ];
    u_int32_t randomIndex = arc4random_uniform((u_int32_t)texts.count);
    return texts[randomIndex];
}

@end
