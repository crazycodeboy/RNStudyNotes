//
//  RNDetailViewController.m
//  Project
//
//  Created by ksudi on 16/8/30.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import "RNDetailViewController.h"
#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"

@interface RNDetailViewController ()

@end

@implementation RNDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RCTBundleURLProvider sharedSettings].jsLocation = @"127.0.0.1";
    NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"module.ios" fallbackResource:nil];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"customModule"
                                                 initialProperties:@{@"key1" : @"detail"}
                                                     launchOptions:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    self.view = rootView;
}
@end
