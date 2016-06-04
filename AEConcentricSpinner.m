//
//  AEConcentricSpinner.m
//  Dials
//
//  Created by Trent Hamilton on 2/12/15.
//  Copyright © 2015 Trent Hamilton. All rights reserved.
//

#import "AEConcentricSpinner.h"

#define DEGREES_TO_RADIANS(degrees) ((M_PI * degrees)/180)

@implementation AEConcentricSpinner {
    UIView* outerCircleView;
    UIView* innerCircleView;
    
    CAShapeLayer* outerCircle;
    CAShapeLayer* innerCircle;
}

- (id)initWithFrame:(CGRect)frame andColor:(UIColor*)color andStrokeWidth:(CGFloat)strokeWidth {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self drawCirclesWithColor:color andStrokeWidth:strokeWidth];
    }
    return self;
}

- (void)drawCirclesWithColor:(UIColor*)color andStrokeWidth:(CGFloat)strokeWidth {
    outerCircleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    innerCircleView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:outerCircleView];
    [self addSubview:innerCircleView];
    
    outerCircle = [[CAShapeLayer alloc] initWithLayer:self.layer];
    UIBezierPath* outerPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) radius:self.bounds.size.width/2 startAngle:DEGREES_TO_RADIANS(0) endAngle:DEGREES_TO_RADIANS(270) clockwise:YES];
    outerCircle.path = outerPath.CGPath;
    outerCircle.strokeColor = color.CGColor;
    outerCircle.fillColor = [UIColor clearColor].CGColor;
    outerCircle.lineWidth = strokeWidth;
    outerCircle.lineCap = kCALineCapRound;
    [outerCircleView.layer addSublayer:outerCircle];
    
    innerCircle = [[CAShapeLayer alloc] initWithLayer:self.layer];
    UIBezierPath* innerPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2) radius:self.bounds.size.width/4 startAngle:DEGREES_TO_RADIANS(180) endAngle:DEGREES_TO_RADIANS(90) clockwise:YES];
    innerCircle.path = innerPath.CGPath;
    innerCircle.strokeColor = color.CGColor;
    innerCircle.fillColor = [UIColor clearColor].CGColor;
    innerCircle.lineWidth = strokeWidth;
    innerCircle.lineCap = kCALineCapRound;
    [innerCircleView.layer addSublayer:innerCircle];
    
    [self startAnimating];
}

- (void)startAnimating {
    CABasicAnimation *outerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    outerAnimation.byValue = [NSNumber numberWithFloat:DEGREES_TO_RADIANS(360)];
    outerAnimation.duration = 1.0;
    outerAnimation.repeatCount = INFINITY;
    [outerCircleView.layer addAnimation:outerAnimation forKey:@"outerCircleAnimation"];
    
    CABasicAnimation *innerAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    innerAnimation.byValue = [NSNumber numberWithFloat:DEGREES_TO_RADIANS(-360)];
    innerAnimation.duration = 1.0;
    innerAnimation.repeatCount = INFINITY;
    [innerCircleView.layer addAnimation:innerAnimation forKey:@"outerCircleAnimation"];
}

@end
