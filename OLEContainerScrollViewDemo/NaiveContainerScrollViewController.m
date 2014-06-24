//
//  NaiveContainerScrollViewController.m
//  OLEContainerScrollViewDemo
//
//  Created by Ole Begemann on 13.05.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "NaiveContainerScrollViewController.h"
#import "OLESimulatedTableView.h"

@interface NaiveContainerScrollViewController ()

@property (nonatomic) UIScrollView *containerScrollView;
@property (nonatomic) OLESimulatedTableView *tableView1;
@property (nonatomic) OLESimulatedTableView *tableView2;

@end

@implementation NaiveContainerScrollViewController

static void *KVOContext = &KVOContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.containerScrollView.clipsToBounds = NO;
    self.containerScrollView.backgroundColor = [UIColor clearColor];
    self.containerScrollView.layer.borderWidth = 2.0;
    self.containerScrollView.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.view addSubview:self.containerScrollView];
    
    self.tableView1 = [[OLESimulatedTableView alloc] initWithNumberOfRows:9 rowHeight:72 edgeInsets:UIEdgeInsetsMake(16, 16, 16, 16) cellSpacing:4];
    self.tableView1.backgroundColor = [UIColor colorWithHue:0.562 saturation:0.295 brightness:0.943 alpha:1];
    self.tableView1.cellColor = [UIColor colorWithHue:0.564 saturation:0.709 brightness:0.768 alpha:1];
    self.tableView1.contentSizeOutlineColor = [UIColor colorWithHue:0.992 saturation:0.654 brightness:0.988 alpha:1];
    [self.containerScrollView addSubview:self.tableView1];
    
    self.tableView2 = [[OLESimulatedTableView alloc] initWithNumberOfRows:12 rowHeight:48 edgeInsets:UIEdgeInsetsMake(16, 16, 16, 16) cellSpacing:4];
    self.tableView2.backgroundColor = [UIColor colorWithHue:0.113 saturation:0.235 brightness:0.98 alpha:1];
    self.tableView2.cellColor = [UIColor colorWithHue:0.117 saturation:0.665 brightness:0.984 alpha:1];
    self.tableView2.contentSizeOutlineColor = [UIColor colorWithHue:0.992 saturation:0.654 brightness:0.988 alpha:1];
    [self.containerScrollView addSubview:self.tableView2];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView1 addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:0 context:KVOContext];
    [self.tableView2 addObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) options:0 context:KVOContext];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.tableView1 removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) context:KVOContext];
    [self.tableView2 removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentSize)) context:KVOContext];
    [super viewDidDisappear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    CGSize containerViewSize = CGSizeMake(320, 568);
    CGPoint containerViewOrigin = CGPointMake(CGRectGetMidX(self.view.bounds) - containerViewSize.width / 2, self.topLayoutGuide.length + 100);
    self.containerScrollView.frame = (CGRect){ containerViewOrigin, containerViewSize };

    self.tableView1.frame = CGRectMake(0, 0, self.containerScrollView.bounds.size.width, self.tableView1.contentSize.height);
    self.tableView2.frame = CGRectMake(0, self.tableView1.contentSize.height, self.containerScrollView.bounds.size.width, self.tableView2.contentSize.height);

    self.containerScrollView.contentSize = CGSizeMake(self.containerScrollView.bounds.size.width, self.tableView1.contentSize.height + self.tableView2.contentSize.height);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == KVOContext) {
        [self.view setNeedsLayout];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
