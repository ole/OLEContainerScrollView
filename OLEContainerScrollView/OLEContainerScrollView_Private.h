//
//  OLEContainerScrollView_Private.h
//  OLEContainerScrollViewDemo
//
//  Created by Ole Begemann on 24.07.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "OLEContainerScrollView.h"

@interface OLEContainerScrollView ()

- (void)didAddSubviewToContainer:(UIView *)subview;
- (void)willRemoveSubviewFromContainer:(UIView *)subview;

@end
