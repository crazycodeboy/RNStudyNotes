//
//  RNText.m
//  Project
//
//  Created by ksudi on 16/8/30.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import "RNText.h"

@interface RNText ()

/*! @brief  <#Description#> */
@property (strong, nonatomic) UILabel *label;

@end

@implementation RNText

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
        [self setupChangeAction];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

#pragma mark - Publice Methods


#pragma mark - Private Methods

- (void)setupChangeAction {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.value = @" 5 S ~~~";
        if ([self.delegate respondsToSelector:@selector(text:valueChange:)]) {
            [self.delegate text:self valueChange:self.label.text];
        }
    });
}

#pragma mark - Delegate


#pragma mark - DataSource


#pragma mark - Event Response


#pragma mark - Getters
- (UILabel *)label {
    if (nil == _label) {
        _label = [[UILabel alloc] init];
        _label.text = @"Hello";
    }
    return _label;
}

#pragma mark Setters

- (void)setValue:(NSString *)value {
    _value = [value copy];
    self.label.text = _value;
}

@end
