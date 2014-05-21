//
//  OLEContainerScrollView.h
//  ScrollView
//
//  Created by Ole Begemann on 26.09.13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLEContainerScrollView : UIScrollView

@property (nonatomic, readonly) UIView *contentView;

- (void)addSubviewToContainer:(UIView *)subview;
- (void)removeSubviewFromContainer:(UIView *)subview;

@end
