//
//  ViewController1.m
//  Project
//
//  Created by 庄彪 on 16/8/29.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import "ViewController1.h"
#import "RNViewController.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    self.title = @"界面2";
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.bounds];
    label.text = @"点一下";
    label.font = [UIFont boldSystemFontOfSize:40];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RNViewController *vc = [[RNViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
