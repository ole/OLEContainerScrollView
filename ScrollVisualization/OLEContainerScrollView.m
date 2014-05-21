//
//  OLEContainerScrollView.m
//  ScrollView
//
//  Created by Ole Begemann on 26.09.13.
//  Copyright (c) 2013 Ole Begemann. All rights reserved.
//

@import QuartzCore;

#import "OLEContainerScrollView.h"

@interface OLEContainerScrollView ()

@property (nonatomic, readonly) UIView *contentView;
@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation OLEContainerScrollView

static void *KVOContext = &KVOContext;

- (void)dealloc
{
    // Removing the subviews will unregister KVO observers
    for (UIView *subview in self.contentView.subviews) {
        [self removeSubviewFromContainer:subview];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitForOLEContainerScrollView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self commonInitForOLEContainerScrollView];
}

- (void)commonInitForOLEContainerScrollView
{
    self.contentHeight = 0.0;
    
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_contentView];
}

#pragma mark - Adding and removing subviews

- (void)addSubviewToContainer:(UIView *)subview
{
    NSParameterAssert(subview != nil);
    [self.contentView addSubview:subview];
    
    if ([subview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)subview;
        scrollView.scrollEnabled = NO;
        [scrollView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:NSKeyValueObservingOptionOld context:KVOContext];
    } else {
        [subview addObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) options:NSKeyValueObservingOptionOld context:KVOContext];
        [subview addObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) options:NSKeyValueObservingOptionOld context:KVOContext];
    }
    
    [self setNeedsLayout];
}

- (void)removeSubviewFromContainer:(UIView *)subview
{
    NSParameterAssert(subview != nil);
    
    if ([subview isKindOfClass:[UIScrollView class]]) {
        [subview removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) context:KVOContext];
    } else {
        [subview removeObserver:self forKeyPath:NSStringFromSelector(@selector(frame)) context:KVOContext];
        [subview removeObserver:self forKeyPath:NSStringFromSelector(@selector(bounds)) context:KVOContext];
    }
    [subview removeFromSuperview];
    [self setNeedsLayout];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        // Initiate a layout recalculation only when a subviewʼs frame or contentSize has changed
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(contentSize))]) {
            UIScrollView *scrollView = object;
            CGSize oldContentSize = [change[NSKeyValueChangeOldKey] CGSizeValue];
            CGSize newContentSize = scrollView.contentSize;
            if (!CGSizeEqualToSize(newContentSize, oldContentSize)) {
                [self setNeedsLayout];
            }
        } else if ([keyPath isEqualToString:NSStringFromSelector(@selector(frame))] ||
                   [keyPath isEqualToString:NSStringFromSelector(@selector(bounds))]) {
            UIView *subview = object;
            CGRect oldFrame = [change[NSKeyValueChangeOldKey] CGRectValue];
            CGRect newFrame = subview.frame;
            if (!CGRectEqualToRect(newFrame, oldFrame)) {
                [self setNeedsLayout];
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - Layout

- (void)setContentHeight:(CGFloat)contentHeight
{
    _contentHeight = contentHeight;
    self.contentSize = CGSizeMake(self.bounds.size.width, fmax(self.contentHeight, self.bounds.size.height));
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // Translate scroll view content offset to content view bounds
    self.contentView.frame = self.bounds;
    self.contentView.bounds = (CGRect){ self.contentOffset, self.contentView.bounds.size };
    
    // The "virtual" content offset while iterating over all views,
    // i.e. including the full contentSize of all scroll views we have already iterated over.
    CGFloat virtualYOffset = 0.0;
    
    for (UIView *subview in self.contentView.subviews)
    {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)subview;
            CGRect frame = scrollView.frame;
            CGPoint contentOffset = scrollView.contentOffset;

            // Translate the virtual offset into the sub-scrollview's real content offset and frame size.
            // Methodology:

            if (self.contentOffset.y < virtualYOffset) {
                // (1) As long as the sub-scrollview has not yet reached the top of the screen, set its scroll position
                // to 0.0 and position it just like a normal view. Its content scrolls naturally as the container
                // scroll view scrolls.
                contentOffset.y = 0.0;
                frame.origin.y = virtualYOffset;
            }
            else {
                // (2) If the user has scrolled far enough down so that the sub-scrollview reaches the top of the
                // screen, position its frame at 0.0 and start adjusting the sub-scrollview's content offset to
                // scroll its content.
                contentOffset.y = self.contentOffset.y - virtualYOffset;
                frame.origin.y = self.contentOffset.y;
            }

            // (3) The sub-scrollview's frame should never extend beyond the bottom of the screen, even if its
            // content height is potentially much greater. When the user has scrolled so far that the remaining
            // content height is smaller than the height of the screen, adjust the frame height accordingly.
            CGFloat remainingBoundsHeight = fmax(CGRectGetMaxY(self.bounds) - CGRectGetMinY(frame), 0.0);
            CGFloat remainingContentHeight = fmax(scrollView.contentSize.height - contentOffset.y, 0.0);
            frame.size.height = fmin(remainingBoundsHeight, remainingContentHeight);
            frame.size.width = self.contentView.bounds.size.width;
            
            scrollView.frame = frame;
            scrollView.contentOffset = contentOffset;

            virtualYOffset += scrollView.contentSize.height;
        }
        else {
            // Normal views are simply positioned at the current offset
            CGRect frame = subview.frame;
            frame.origin.y = virtualYOffset;
            subview.frame = frame;
            
            virtualYOffset += frame.size.height;
        }
    }
    
    self.contentHeight = virtualYOffset;
}

@end
