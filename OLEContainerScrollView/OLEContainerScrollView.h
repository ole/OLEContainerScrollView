//
//  OLEContainerScrollView.h
//  ScrollView
//
//  Created by Ole Begemann on 26.09.13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

@import UIKit;

@interface OLEContainerScrollView : UIScrollView

/// The container scroll views content view. You should add your subviews to this content view.
/// Only views that are added to the content view will be managed by the container scroll view.
/// The container scroll view will lay the content view's subviews out vertically in the order
/// in which they were added.
@property (nonatomic, readonly) UIView *contentView;

@end
