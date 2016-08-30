//
//  RNTestManager.h
//  Project
//
//  Created by ksudi on 16/8/30.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RCTBridgeModule.h>
#import <RCTEventEmitter.h>

@interface RNTestManager : NSObject <RCTBridgeModule>

@end

@interface RCTBridge (RCTEventEmitter)

- (RCTEventEmitter *)eventEmitter;

@end