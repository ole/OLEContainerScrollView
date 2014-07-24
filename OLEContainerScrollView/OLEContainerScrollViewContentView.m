/*
 OLEContainerScrollView
 
 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

#import "OLEContainerScrollViewContentView.h"
#import "OLEContainerScrollView.h"
#import "OLEContainerScrollView_Private.h"

@implementation OLEContainerScrollViewContentView

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    if ([self.superview isKindOfClass:[OLEContainerScrollView class]]) {
        [(OLEContainerScrollView *)self.superview didAddSubviewToContainer:subview];
    }
}

- (void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];
    if ([self.superview isKindOfClass:[OLEContainerScrollView class]]) {
        [(OLEContainerScrollView *)self.superview willRemoveSubviewFromContainer:subview];
    }
}

@end
