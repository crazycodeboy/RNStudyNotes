//
//  AppDelegate.m
//  Project
//
//  Created by 庄彪 on 16/8/29.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = rootNav;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
