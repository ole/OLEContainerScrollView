//
//  MultipleCollectionsViewController.m
//  OLEContainerScrollViewDemo
//
//  Created by Ole Begemann on 24.06.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "MultipleCollectionsViewController.h"
#import "OLEContainerScrollView.h"
#import "UIColor+RandomColor.h"

@interface MultipleCollectionsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) IBOutlet OLEContainerScrollView *containerScrollView;
@property (nonatomic) NSMutableArray *collectionViews;
@property (nonatomic) NSMutableArray *numberOfItemsPerCollectionView;
@property (nonatomic) NSMutableArray *cellColorPerCollectionView;

@end

@implementation MultipleCollectionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSInteger numberOfCollectionViews = 3;
    self.collectionViews = [NSMutableArray new];
    self.numberOfItemsPerCollectionView = [NSMutableArray new];
    self.cellColorPerCollectionView = [NSMutableArray new];
    
    for (NSInteger collectionViewIndex = 0; collectionViewIndex < numberOfCollectionViews; collectionViewIndex++) {
        UIView *collectionView = [self preconfiguredCollectionView];
        NSInteger randomNumberOfItemsInCollectionView = arc4random_uniform(50) + 10;
        [self.collectionViews addObject:collectionView];
        [self.numberOfItemsPerCollectionView addObject:@(randomNumberOfItemsInCollectionView)];
        [self.cellColorPerCollectionView addObject:[UIColor randomColor]];
        [self.containerScrollView addSubviewToContainer:collectionView];
    }
}

- (UICollectionView *)preconfiguredCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MyCell"];
    collectionView.backgroundColor = [UIColor whiteColor];
    return collectionView;
}

- (IBAction)addCell:(id)sender
{
    NSInteger collectionViewIndex = 0;
    UICollectionView *collectionView = self.collectionViews[collectionViewIndex];
    NSInteger previousNumberOfItemsInCollectionView = [self.numberOfItemsPerCollectionView[collectionViewIndex] integerValue];
    NSInteger newNumberOfItemsInCollectionView = previousNumberOfItemsInCollectionView + 1;
    self.numberOfItemsPerCollectionView[collectionViewIndex] = @(newNumberOfItemsInCollectionView);
    [collectionView performBatchUpdates:^{
        NSIndexPath *indexPathOfAddedCell = [NSIndexPath indexPathForItem:previousNumberOfItemsInCollectionView inSection:0];
        [collectionView insertItemsAtIndexPaths:@[ indexPathOfAddedCell ]];
    } completion:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSUInteger collectionViewIndex = [self.collectionViews indexOfObject:collectionView];
    NSInteger numberOfItemsInCollectionView = [self.numberOfItemsPerCollectionView[collectionViewIndex] integerValue];
    return numberOfItemsInCollectionView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    NSUInteger collectionViewIndex = [self.collectionViews indexOfObject:collectionView];
    UIColor *cellColor = self.cellColorPerCollectionView[collectionViewIndex];
    cell.backgroundColor = cellColor;
    return cell;
}

@end
