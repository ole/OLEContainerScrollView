//
//  OLEBorderedView.h
//  ScrollVisualization
//
//  Created by Ole Begemann on 09.05.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

@import UIKit;

@interface OLEBorderedView : UIView

@property (nonatomic) CGFloat borderWidth;
@property (nonatomic) UIColor *borderColor;
@property (nonatomic) NSArray *lineDashPattern;

@end
