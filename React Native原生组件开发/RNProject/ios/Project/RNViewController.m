//
//  RNViewController.m
//  Project
//
//  Created by 庄彪 on 16/8/29.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import "RNViewController.h"
#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"


@interface RNViewController ()

@end

@implementation RNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RCTBundleURLProvider sharedSettings].jsLocation = @"127.0.0.1";
    NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"Module"
                                                 initialProperties:@{@"key1" : @"initialProperties"}
                                                     launchOptions:nil];
    rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    self.view = rootView;
}


@end
