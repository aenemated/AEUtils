//
//  AEPieProgress.m
//  Headlight
//
//  Created by Trent Hamilton on 6/03/15.
//  Copyright © 2015 Trent Hamilton. All rights reserved.
//

#import "AEPieProgress.h"

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/180)

@implementation AEPieProgress {
    CAShapeLayer* backgroundCircle;
    
    CAShapeLayer* outerProgressCircle;
    CAShapeLayer* innerProgressCircle;
    
    UIColor* backgroundCircleColor;
    UIColor* outerProgressColor;
    UIColor* innerProgressColor;
    
    CGFloat outerWidth;
}

- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor andInnerColor:(UIColor*)innerColor andOuterColor:(UIColor*)outerColor andOuterWidth:(CGFloat)width {
    self = [super initWithFrame:frame];
    if (self) {
        
        backgroundCircleColor = backgroundColor;
        outerProgressColor = outerColor;
        innerProgressColor = innerColor;
        outerWidth = width;

        [self drawBackground];
    }
    return self;
}

- (void)drawBackground {
    backgroundCircle = [[CAShapeLayer alloc] initWithLayer:self.layer];
    UIBezierPath* backgroundPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) radius:(self.bounds.size.width/2)+outerWidth startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(360) clockwise:YES];
    backgroundCircle.path = backgroundPath.CGPath;
    backgroundCircle.strokeColor = [UIColor clearColor].CGColor;
    backgroundCircle.lineWidth = 0.0;
    backgroundCircle.fillColor = backgroundCircleColor.CGColor;
    [self.layer addSublayer:backgroundCircle];
}

- (void)setOuterProgress:(CGFloat)progress {
    
    if (progress > 1.0) {
        return;
    }

    [outerProgressCircle removeFromSuperlayer];
    outerProgressCircle = [[CAShapeLayer alloc] initWithLayer:self.layer];
    UIBezierPath* outerPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) radius:(self.bounds.size.width/2) startAngle:DEGREES_TO_RADIANS(-90) endAngle:[self calculateAngleProgress:progress] clockwise:NO];
    outerProgressCircle.path = outerPath.CGPath;
    outerProgressCircle.strokeColor = outerProgressColor.CGColor;
    outerProgressCircle.fillColor = [UIColor clearColor].CGColor;
    outerProgressCircle.lineWidth = outerWidth;
    outerProgressCircle.lineCap = kCALineCapButt;
    [self.layer addSublayer:outerProgressCircle];
    
}

- (void)setInnerProgress:(CGFloat)progress {
    
    if (progress > 1.0) {
        return;
    }
    
    [innerProgressCircle removeFromSuperlayer];
    innerProgressCircle = [[CAShapeLayer alloc] initWithLayer:self.layer];
    innerProgressCircle.fillColor = innerProgressColor.CGColor;
    innerProgressCircle.strokeColor = [UIColor clearColor].CGColor;
    innerProgressCircle.lineWidth = 0.0;
    
    CGFloat start = DEGREES_TO_RADIANS(-90.0);
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2);
    CGFloat radius = (self.bounds.size.width/2)-outerWidth;
    
    UIBezierPath *cutoutPath = [[UIBezierPath alloc] init];
    [cutoutPath moveToPoint:center];
    [cutoutPath addLineToPoint:CGPointMake(center.x+radius*cosf(start),center.y+radius*sinf(start))];
    [cutoutPath addArcWithCenter:center radius:radius startAngle:start endAngle:[self calculateAngleProgress:progress] clockwise:NO];
    [cutoutPath closePath];
    
    innerProgressCircle.path = cutoutPath.CGPath;
    [self.layer addSublayer:innerProgressCircle];
    
}

- (CGFloat)calculateAngleProgress:(CGFloat)progress {
    float pct = (360.0*progress)-90;
    return DEGREES_TO_RADIANS(pct);
}

@end
