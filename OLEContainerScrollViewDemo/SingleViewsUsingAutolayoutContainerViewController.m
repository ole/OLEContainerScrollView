/*
 OLEContainerScrollView

 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

#import "SingleViewsUsingAutolayoutContainerViewController.h"
#import "OLEContainerScrollView.h"
#import "ChildViewUsingAutolayout.h"

@interface SingleViewsUsingAutolayoutContainerViewController ()

@property (weak, nonatomic) IBOutlet OLEContainerScrollView *containerScrollView;

@end


@implementation SingleViewsUsingAutolayoutContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSInteger numberOfChildViews = 10;
    for (NSInteger childViewIndex = 0; childViewIndex < numberOfChildViews; childViewIndex++) {
        UIView *childView = [self preconfiguredChildView];
        [self.containerScrollView.contentView addSubview:childView];
    }
}

- (UIView *)preconfiguredChildView
{
    UINib *nib = [UINib nibWithNibName:@"ChildViewUsingAutolayout" bundle:nil];
    ChildViewUsingAutolayout *view = [[nib instantiateWithOwner:nil options:nil] firstObject];
    view.layer.borderWidth = 1.0;
    view.layer.borderColor = [UIColor blackColor].CGColor;
    return view;
}

@end
