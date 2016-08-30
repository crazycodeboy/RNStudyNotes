//
//  RNText.h
//  Project
//
//  Created by ksudi on 16/8/30.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RCTComponent.h>
@class RNText;

@protocol RNTextDelegate <NSObject>

- (void)text:(RNText *)text valueChange:(NSString *)value;

@end

@interface RNText : UIView

@property (copy, nonatomic) NSString *value;

@property (weak, nonatomic) id<RNTextDelegate> delegate;

@property (copy, nonatomic) RCTBubblingEventBlock onChange;

@end
