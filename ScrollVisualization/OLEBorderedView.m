//
//  OLEBorderedView.m
//  ScrollVisualization
//
//  Created by Ole Begemann on 09.05.14.
//  Copyright (c) 2014 Ole Begemann. All rights reserved.
//

#import "OLEBorderedView.h"

@interface OLEBorderedView ()

@property (nonatomic, readonly) CAShapeLayer *shapeLayer;

@end

@implementation OLEBorderedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
    [self commonInitForOLEBorderedView];
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self == nil) {
        return nil;
    }
    [self commonInitForOLEBorderedView];
    return self;
}

- (void)commonInitForOLEBorderedView
{
    self.shapeLayer.fillColor = NULL;
    [self updateBorderPath];
}

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (CAShapeLayer *)shapeLayer
{
    return (CAShapeLayer *)self.layer;
}

//- (CGFloat)borderWidth
//{
//    return self.layer.borderWidth;
//}
//
//- (void)setBorderWidth:(CGFloat)borderWidth
//{
//    self.layer.borderWidth = borderWidth;
//}
//
//- (UIColor *)borderColor
//{
//    if (self.layer.borderColor == NULL) {
//        return nil;
//    }
//    return [UIColor colorWithCGColor:self.layer.borderColor];
//}
//
//- (void)setBorderColor:(UIColor *)borderColor
//{
//    self.layer.borderColor = [borderColor CGColor];
//}

- (void)updateBorderPath
{
    CGRect borderBounds = CGRectInset(self.bounds, self.borderWidth/2, self.borderWidth/2);
    UIBezierPath *border = [UIBezierPath bezierPathWithRect:borderBounds];
    self.shapeLayer.path = [border CGPath];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self updateBorderPath];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    [self updateBorderPath];
}

- (CGFloat)borderWidth
{
    return self.shapeLayer.lineWidth;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.shapeLayer.lineWidth = borderWidth;
}

- (UIColor *)borderColor
{
    if (self.shapeLayer.strokeColor == nil) {
        return nil;
    }
    return [UIColor colorWithCGColor:self.shapeLayer.strokeColor];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.shapeLayer.strokeColor = [borderColor CGColor];
}

- (NSArray *)lineDashPattern
{
    return self.shapeLayer.lineDashPattern;
}

- (void)setLineDashPattern:(NSArray *)lineDashPattern
{
    self.shapeLayer.lineDashPattern = lineDashPattern;
}

@end
