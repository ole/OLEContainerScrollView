//
//  TableViewWithWebViewViewController.m
//  OLEContainerScrollViewDemo
//
//  Created by Tom Kraina on 18.7.2018.
//  Copyright © 2018 Ole Begemann. All rights reserved.
//

#import "TableViewWithWebViewViewController.h"
#import "OLEContainerScrollView.h"
#import "UIColor+RandomColor.h"

@interface TableViewWithWebViewViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) IBOutlet OLEContainerScrollView *containerScrollView;
@property (nonatomic) NSMutableArray *tableViews;
@property (nonatomic) NSMutableArray *numberOfRowsPerTableView;
@property (nonatomic) NSMutableArray *cellColorsPerTableView;
@end


@import WebKit;

// Make WKWebView conform to OLEContainerScrollViewScrollable in order to work correcly
@interface WKWebView () <OLEContainerScrollViewScrollable>
@end


@implementation TableViewWithWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableViews = [NSMutableArray new];
    self.numberOfRowsPerTableView = [NSMutableArray new];
    self.cellColorsPerTableView = [NSMutableArray new];
    
    [self addTableView];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero];
    [self.containerScrollView.contentView addSubview:webView];
    NSURL *url = [[NSURL alloc] initWithString: @"https://oleb.net"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    [webView loadRequest:request];
    
    [self addTableView];
}

- (void)addTableView
{
    UIView *tableView = [self preconfiguredTableView];
    NSInteger randomNumberOfRows = 10 + arc4random_uniform(10);
    [self.tableViews addObject:tableView];
    [self.numberOfRowsPerTableView addObject:@(randomNumberOfRows)];
    [self.cellColorsPerTableView addObject:[UIColor randomColor]];
    [self.containerScrollView.contentView addSubview:tableView];
}

- (UITableView *)preconfiguredTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyCell"];
    tableView.backgroundColor = [UIColor whiteColor];
    return tableView;
}

- (IBAction)addCell:(id)sender
{
    NSInteger tableViewIndex = 0;
    UITableView *tableView = self.tableViews[tableViewIndex];
    NSInteger previousNumberOfRows = [self.numberOfRowsPerTableView[tableViewIndex] integerValue];
    NSInteger newNumberOfRows = previousNumberOfRows + 1;
    self.numberOfRowsPerTableView[tableViewIndex] = @(newNumberOfRows);
    
    [tableView beginUpdates];
    NSIndexPath *indexPathOfAddedCell = [NSIndexPath indexPathForItem:previousNumberOfRows inSection:0];
    [tableView insertRowsAtIndexPaths:@[ indexPathOfAddedCell ] withRowAnimation:UITableViewRowAnimationTop];
    [tableView endUpdates];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger tableViewIndex = [self.tableViews indexOfObject:tableView];
    NSInteger numberOfRowsInTableView = [self.numberOfRowsPerTableView[tableViewIndex] integerValue];
    return numberOfRowsInTableView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    NSUInteger tableViewIndex = [self.tableViews indexOfObject:tableView];
    UIColor *cellColor = self.cellColorsPerTableView[tableViewIndex];
    cell.backgroundColor = cellColor;
    return cell;
}

@end
