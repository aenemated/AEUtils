//
//  ViewController.m
//  Utils
//
//  Created by Trent Hamilton on 6/3/16.
//  Copyright © 2016 Trent Hamilton. All rights reserved.
//

#import "ViewController.h"
#import "AEPieProgress.h"
#import "AEConcentricSpinner.h"

@interface ViewController () {
    AEPieProgress* pieProgress;
    float innerProgress;
    float outerProgress;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // concentric spinner
    AEConcentricSpinner* spinner = [[AEConcentricSpinner alloc] initWithFrame:CGRectMake(30.0, 30.0, 20.0, 20.0) andColor:[UIColor blueColor] andStrokeWidth:1.5];
    [self.view addSubview:spinner];
    
    // pie progress!
    pieProgress = [[AEPieProgress alloc] initWithFrame:CGRectMake(100.0, 30.0, 40.0, 40.0) withBackgroundColor:[UIColor colorWithWhite:0.0 alpha:.5] andInnerColor:[UIColor redColor] andOuterColor:[UIColor whiteColor] andOuterWidth:3.0];
    [self.view addSubview:pieProgress];
    
    // for testing
    innerProgress = 0.0;
    outerProgress = 0.0;
    [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(testProgress) userInfo:nil repeats:YES];
}

- (void)testProgress {
    outerProgress += .01;
    innerProgress += .01;
    
    if (innerProgress >= 1.0) {
        innerProgress = .01;
    }
    
    [pieProgress setOuterProgress:outerProgress];
    [pieProgress setInnerProgress:innerProgress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
