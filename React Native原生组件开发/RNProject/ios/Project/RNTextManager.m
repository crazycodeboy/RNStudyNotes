//
//  RNTextManager.m
//  Project
//
//  Created by ksudi on 16/8/30.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import "RNTextManager.h"
#import "RNText.h"

@interface RNTextManager ()<RNTextDelegate>

@end

@implementation RNTextManager

RCT_EXPORT_MODULE()

- (UIView *)view {
    RNText *text = [[RNText alloc] init];
    text.delegate = self;
    return text;
}

- (void)text:(RNText *)text valueChange:(NSString *)value {
    if (!text.onChange) {
        return;
    }
    NSDictionary *params = @{
                             @"value" : value
                             };
    text.onChange(params);
}

RCT_EXPORT_VIEW_PROPERTY(onChange, RCTBubblingEventBlock)

RCT_EXPORT_VIEW_PROPERTY(value, NSString)

@end
