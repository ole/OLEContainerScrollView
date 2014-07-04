/*
 OLEContainerScrollView
 
 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

@import UIKit;

/**
 A container scroll view that allows you to place multiple views (including scroll views, table views and collection views) in a stacked layout.
 
 `OLEContainerScrollView` will automatically arrange all subviews that are added to its content view in a stacked vertical order. For any scroll views among those subviews (that is, any view that is an instance of `UIScrollView` or one of its subclasses; that includes `UITableView` and `UICollectionView`), the container view will seamlessly manage their frame rectangles in such a way that the subviews' frame height is never larger than absolutely necessary for the current scroll position.
 
 In other words, scroll views that are currently outside the container viewʼs bounds (and thus invisible) will have their frame height reduced to zero. Scroll views that are partly or fully inside the container viewʼs bounds will have their frame height and content offset adjusted accordingly in a way that gives the user the impression that the subviews themselves are being scrolled. All adjustments happen seamlessly as the container view scrolls.
 
 This allows you to stack multiple table or collection views vertically while retaining the full cell reuse capabilities of `UITableView` and `UICollectionView`.
 
 ## Usage
 
 Just add your views to the container scroll view's `contentView`.
 
 ## Limitations

 - Only vertically stacked layouts (and vertical scrolling) are supported at the moment.
 - The stack layout is very inflexible. It resizes all subviews to the width of the container. It does not support spacing between or free positioning of the subviews.
 - Content size changes of the subviews are observed, but not animated in the case of table or collection views.
 
 ## More Information
 
 See the accompanying blog post, [Scroll Views Inside Scroll Views](http://oleb.net/blog/2014/05/scrollviews-inside-scrollviews/), for more information.
 */
@interface OLEContainerScrollView : UIScrollView

/** @name Managing Subviews */
/**
 The container scroll view's content view. You should add your subviews to this content view. Only views that are added to the content view will be managed by the container scroll view. The container scroll view will lay the content view's subviews out vertically in the order in which they were added.
 */
@property (nonatomic, readonly) UIView *contentView;

@end
