/*
 OLEContainerScrollView

 Copyright (c) 2014 Ole Begemann.
 https://github.com/ole/OLEContainerScrollView
 */

@import UIKit;

/// A view that holds a variable amount of text and adjusts its intrinsic content size accordingly.
@interface ChildViewUsingAutolayout : UIView

@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
