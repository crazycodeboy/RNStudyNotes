//
//  ViewController.m
//  Project
//
//  Created by 庄彪 on 16/8/29.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import "ViewController.h"
#import "RNViewController.h"
#import "RNDetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"界面1";
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"点一下";
    label.font = [UIFont boldSystemFontOfSize:40];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RNViewController *vc = [[RNViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

//    RNDetailViewController *vc = [[RNDetailViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
}

@end
