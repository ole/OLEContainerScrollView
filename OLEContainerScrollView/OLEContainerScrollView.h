//
//  OLEContainerScrollView.h
//  ScrollView
//
//  Created by Ole Begemann on 26.09.13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OLEContainerScrollView : UIScrollView

// Add your subviews to contentView; OLEContainerScrollView will lay
// them out vertically in the order in which they were added.
@property (nonatomic, readonly) UIView *contentView;

@end
