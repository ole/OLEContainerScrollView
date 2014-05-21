//
//  SimulatedTableView.h
//  OLEContainerScrollViewDemo
//
//  Created by Ole Begemann on 16/03/14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimulatedTableView : UIScrollView

- (instancetype)initWithNumberOfRows:(NSUInteger)numberOfRows rowHeight:(CGFloat)rowHeight edgeInsets:(UIEdgeInsets)edgeInsets cellSpacing:(CGFloat)cellSpacing;

@property (nonatomic) BOOL showBoundsOutline;
@property (nonatomic) UIColor *cellColor;
@property (nonatomic) UIColor *contentSizeOutlineColor;
@property (nonatomic, readonly) NSUInteger numberOfRows;
@property (nonatomic, readonly) CGFloat rowHeight;
@property (nonatomic, readonly) CGFloat cellSpacing;
@property (nonatomic, readonly) UIEdgeInsets edgeInsets;

@end
