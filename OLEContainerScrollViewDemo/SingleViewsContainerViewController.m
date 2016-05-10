/*
 OLEContainerScrollView

 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

#import "SingleViewsContainerViewController.h"
#import "OLEContainerScrollView.h"
#import "UIColor+RandomColor.h"

@interface SingleViewsContainerViewController ()

@property (weak, nonatomic) IBOutlet OLEContainerScrollView *containerScrollView;

@end


@implementation SingleViewsContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSInteger numberOfChildViews = 10;
    for (NSInteger childViewIndex = 0; childViewIndex < numberOfChildViews; childViewIndex++) {
        CGFloat randomHeight = arc4random_uniform(500) + 100;
        UIView *childView = [self preconfiguredChildViewWithHeight:randomHeight];
        [self.containerScrollView.contentView addSubview:childView];
    }
}

- (UIView *)preconfiguredChildViewWithHeight:(CGFloat)height
{
    UINib *nib = [UINib nibWithNibName:@"ChildView" bundle:nil];

    UIView *view = [[nib instantiateWithOwner:nil options:nil] firstObject];
    view.frame = ({
        CGRect frame = view.frame;
        frame.size.height = height;
        frame;
    });
    view.backgroundColor = [UIColor randomColor];
    return view;
}

@end
