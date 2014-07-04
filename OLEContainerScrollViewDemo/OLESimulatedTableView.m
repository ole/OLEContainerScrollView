/*
 OLEContainerScrollView
 
 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

#import "OLESimulatedTableView.h"
#import "OLEBorderedView.h"

typedef OLEBorderedView OLESimulatedTableViewCell;


@interface OLESimulatedTableView ()

@property (nonatomic, strong) NSMutableArray *cells;
@property (nonatomic, strong) NSMutableSet *visibleCells;
@property (nonatomic, strong) OLEBorderedView *contentSizeView;
@property (nonatomic, strong) OLEBorderedView *boundsView;

@end


@implementation OLESimulatedTableView

- (instancetype)initWithNumberOfRows:(NSUInteger)numberOfRows rowHeight:(CGFloat)rowHeight edgeInsets:(UIEdgeInsets)edgeInsets cellSpacing:(CGFloat)cellSpacing
{
    self = [super initWithFrame:CGRectZero];
    if (self == nil) {
        return nil;
    }
    
    _numberOfRows = numberOfRows;
    _rowHeight = rowHeight;
    _cellSpacing = cellSpacing;
    _edgeInsets = edgeInsets;

    [self commonInitForSimulatedTableView];

    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithNumberOfRows:10 rowHeight:44.0 edgeInsets:UIEdgeInsetsMake(5, 5, 5, 5) cellSpacing:5];
    self.frame = frame;
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self == nil) {
        return nil;
    }
    
    _numberOfRows = 10;
    _rowHeight = 44.0;
    _cellSpacing = 5.0;
    _edgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    
    [self commonInitForSimulatedTableView];
    
    return self;
}

- (void)commonInitForSimulatedTableView
{
    self.clipsToBounds = NO;

    _showBoundsOutline = NO;
    _cellColor = [UIColor blackColor];
    _contentSizeOutlineColor = [UIColor redColor];

    _cells = [NSMutableArray arrayWithCapacity:_numberOfRows];
    _visibleCells = [NSMutableSet setWithCapacity:_numberOfRows];

    [self _setupCells];
    [self _setupContentSizeView];
    [self _setupBoundsView];
}

- (void)_setupCells
{
    for (OLESimulatedTableViewCell *existingCell in self.cells) {
        [existingCell removeFromSuperview];
    }
    [self.cells removeAllObjects];
    
    for (NSUInteger rowIndex = 0; rowIndex < _numberOfRows; rowIndex++) {
        OLESimulatedTableViewCell *cell = [[OLESimulatedTableViewCell alloc] initWithFrame:CGRectZero];
        cell.translatesAutoresizingMaskIntoConstraints = NO;
        cell.borderColor = self.cellColor;
        cell.borderWidth = 2.0;
        [self addSubview:cell];
        [self.cells addObject:cell];
        [self _toggleCellVisibilityIfNeeded:cell animated:NO];
    }
    
    [self setNeedsLayout];
}

- (void)_setupBoundsView
{
    self.boundsView = [[OLEBorderedView alloc] initWithFrame:CGRectZero];
    self.boundsView.translatesAutoresizingMaskIntoConstraints = NO;
    self.boundsView.backgroundColor = [UIColor clearColor];
    self.boundsView.borderColor = [UIColor blueColor];
    self.boundsView.borderWidth = 2.0;
    self.boundsView.lineDashPattern = @[ @10, @10 ];
    [self addSubview:self.boundsView];
    
    [self setNeedsLayout];
}

- (void)_setupContentSizeView
{
    self.contentSizeView = [[OLEBorderedView alloc] initWithFrame:CGRectZero];
    self.contentSizeView.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentSizeView.backgroundColor = [UIColor clearColor];
    self.contentSizeView.borderColor = self.contentSizeOutlineColor;
    self.contentSizeView.borderWidth = 2.0;
    self.contentSizeView.lineDashPattern = @[ @10, @10 ];
    [self insertSubview:self.contentSizeView atIndex:0];
    
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;

    CGFloat cellWidth = CGRectGetWidth(bounds) - _edgeInsets.left - _edgeInsets.right;
    CGFloat cumulativeCellHeight = _numberOfRows * _rowHeight;
    CGFloat cumulativeCellSpacingHeight = _numberOfRows > 0 ? (_numberOfRows - 1) * _cellSpacing : 0.0;
    CGFloat contentHeight = _edgeInsets.top + cumulativeCellHeight + cumulativeCellSpacingHeight + _edgeInsets.bottom;

    CGSize newContentSize = CGSizeMake(bounds.size.width, contentHeight);
    if (!CGSizeEqualToSize(self.contentSize, newContentSize)) {
        self.contentSize = newContentSize;
    }
    [self.cells enumerateObjectsUsingBlock:^(OLESimulatedTableViewCell *cell, NSUInteger idx, BOOL *stop) {
        CGFloat cellYPosition = _edgeInsets.top + (idx * (_rowHeight + _cellSpacing));
        cell.frame = CGRectMake(_edgeInsets.left, cellYPosition, cellWidth, _rowHeight);
        [self _toggleCellVisibilityIfNeeded:cell animated:YES];
    }];
    
    self.boundsView.hidden = !self.showBoundsOutline;
    CGFloat boundsViewHorizontalMargin = floor(_edgeInsets.left / 3);
    CGFloat boundsViewVerticalMargin = floor(_edgeInsets.top / 3);
    self.boundsView.frame = CGRectInset(bounds, boundsViewHorizontalMargin, boundsViewVerticalMargin);

    CGFloat contentSizeViewHorizontalMargin = self.showBoundsOutline ? floor(_edgeInsets.left / 3 * 2) : floor(_edgeInsets.left / 2);
    CGFloat contentSizeViewVerticalMargin = self.showBoundsOutline ? floor(_edgeInsets.top / 3 * 2) : floor(_edgeInsets.top / 2);
    CGRect contentSizeViewFrame = { CGPointZero, self.contentSize };
    contentSizeViewFrame = CGRectInset(contentSizeViewFrame, contentSizeViewHorizontalMargin, contentSizeViewVerticalMargin);
    self.contentSizeView.frame = contentSizeViewFrame;
    self.contentSizeView.borderColor = self.contentSizeOutlineColor;
}

- (void)setShowBoundsOutline:(BOOL)showBoundsOutline
{
    _showBoundsOutline = showBoundsOutline;
    [self setNeedsLayout];
}

- (void)setCellColor:(UIColor *)cellColor
{
    _cellColor = cellColor;

    for (OLESimulatedTableViewCell *cell in self.cells) {
        cell.backgroundColor = cellColor;
        cell.borderColor = cellColor;
    }
}

#pragma mark - Manage Cell Visibility

- (void)_toggleCellVisibilityIfNeeded:(OLESimulatedTableViewCell *)cell animated:(BOOL)animated
{
    BOOL cellShouldBeVisible = [self _shouldCellBeVisible:cell];
    BOOL cellIsVisible = [self _isCellVisible:cell];
    
    BOOL shouldShowCell = cellShouldBeVisible && !cellIsVisible;
    BOOL shouldHideCell = cellIsVisible && !cellShouldBeVisible;
    
    if (shouldShowCell) {
        [self _makeCellVisible:cell animated:animated];
    } else if (shouldHideCell) {
        [self _makeCellInvisible:cell animated:animated];
    }
}

- (BOOL)_shouldCellBeVisible:(OLESimulatedTableViewCell *)cell
{
    return CGRectIntersectsRect(cell.frame, self.bounds);
}

- (BOOL)_isCellVisible:(OLESimulatedTableViewCell *)cell
{
    return [self.visibleCells containsObject:cell];
}

- (void)_makeCellVisible:(OLESimulatedTableViewCell *)cell animated:(BOOL)animated
{
    BOOL isAlreadyVisible = [self _isCellVisible:cell];
    if (isAlreadyVisible) {
        return;
    }
    
    [self.visibleCells addObject:cell];
    
    CABasicAnimation *backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorAnimation.fromValue = (id)cell.layer.backgroundColor;
    backgroundColorAnimation.duration = 0.15;

    cell.layer.backgroundColor = [self.cellColor CGColor];
    cell.lineDashPattern = nil;
    
    if (animated) {
        [cell.layer addAnimation:backgroundColorAnimation forKey:@"showCell"];
    }
}

- (void)_makeCellInvisible:(OLESimulatedTableViewCell *)cell animated:(BOOL)animated
{
    BOOL isAlreadyInvisible = ![self _isCellVisible:cell];
    if (isAlreadyInvisible) {
        return;
    }

    [self.visibleCells removeObject:cell];
    
    CABasicAnimation *backgroundColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    backgroundColorAnimation.fromValue = (id)cell.layer.backgroundColor;
    backgroundColorAnimation.duration = 0.15;
    
    cell.backgroundColor = [UIColor clearColor];
    cell.lineDashPattern = @[ @10, @10 ];
    
    if (animated) {
        [cell.layer addAnimation:backgroundColorAnimation forKey:@"showCell"];
    }
}

@end
