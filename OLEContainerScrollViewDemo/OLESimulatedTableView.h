/*
 OLEContainerScrollView
 
 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

@import UIKit;

/**
 *  A view that can be used to illustrate how cell reuse works in UITableView.
 *
 *  It creates a scrollable list of dummy cells (with no content). Dashed outlines
 *  represent cells that exist conceptually but do not get instantiated until they
 *  are scrolled into the visible bounds of the table view.
 *
 *  When you place this view into your view hierarchy, you should give it a top and 
 *  bottom margin in order to see how cells get added and removed during scrolling.
 */
@interface OLESimulatedTableView : UIScrollView

- (instancetype)initWithNumberOfRows:(NSUInteger)numberOfRows rowHeight:(CGFloat)rowHeight edgeInsets:(UIEdgeInsets)edgeInsets cellSpacing:(CGFloat)cellSpacing;

@property (nonatomic) BOOL showBoundsOutline;
@property (nonatomic) UIColor *cellColor;
@property (nonatomic) UIColor *contentSizeOutlineColor;
@property (nonatomic, readonly) NSUInteger numberOfRows;
@property (nonatomic, readonly) CGFloat rowHeight;
@property (nonatomic, readonly) CGFloat cellSpacing;
@property (nonatomic, readonly) UIEdgeInsets edgeInsets;

@end
