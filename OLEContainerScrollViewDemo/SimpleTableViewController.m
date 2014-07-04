/*
 OLEContainerScrollView
 
 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

#import "SimpleTableViewController.h"
#import "OLESimulatedTableView.h"

@interface SimpleTableViewController ()

@property (nonatomic) OLESimulatedTableView *tableView;

@end

@implementation SimpleTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[OLESimulatedTableView alloc] initWithNumberOfRows:14 rowHeight:72 edgeInsets:UIEdgeInsetsMake(16, 16, 16, 16) cellSpacing:4];
    self.tableView.backgroundColor = [UIColor colorWithHue:0.562 saturation:0.295 brightness:0.943 alpha:1];
    self.tableView.cellColor = [UIColor colorWithHue:0.564 saturation:0.709 brightness:0.768 alpha:1];
    self.tableView.contentSizeOutlineColor = [UIColor colorWithHue:0.992 saturation:0.654 brightness:0.988 alpha:1];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGSize tableViewSize = CGSizeMake(320, 568);
    CGPoint tableViewOrigin = CGPointMake(CGRectGetMidX(self.view.bounds) - tableViewSize.width / 2, self.topLayoutGuide.length + 100);
    self.tableView.frame = (CGRect){ tableViewOrigin, tableViewSize };
}

@end
