//
//  AEPieProgress.h
//  Headlight
//
//  Created by Trent Hamilton on 6/03/15.
//  Copyright © 2015 Trent Hamilton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AEPieProgress : UIView

- (id)initWithFrame:(CGRect)frame withBackgroundColor:(UIColor*)backgroundColor andInnerColor:(UIColor*)innerColor andOuterColor:(UIColor*)outerColor andOuterWidth:(CGFloat)width;

- (void)setInnerProgress:(CGFloat)progress;
- (void)setOuterProgress:(CGFloat)progress;

@end
