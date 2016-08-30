//
//  RNTestManager.m
//  Project
//
//  Created by ksudi on 16/8/30.
//  Copyright © 2016年 ksudi. All rights reserved.
//

#import "RNTestManager.h"
#import <RCTConvert.h>
#import <RCTEventDispatcher.h>


typedef NS_ENUM(NSInteger, RNTestManagerType) {
    RNTestManagerTypeNone,
    RNTestManagerTypeDefault,
    RNTestManagerTypeCustome,
};

@interface RNTestManager ()

/*! @brief  <#Description#> */
@property (assign, nonatomic) RNTestManagerType type;

/*! @brief  <#Description#> */
//@property (strong, nonatomic) RCTEventEmitter *event;

@end


@implementation RNTestManager

@synthesize bridge = _bridge;

- (instancetype)init {
    if (self = [super init]) {
        self.type = -1;
    }
    return self;
}

//RCT_EXPORT_MODULE();
RCT_EXPORT_MODULE(Test);

//
RCT_EXPORT_METHOD(print:(NSString *)text) {
    NSLog(@"%@", text);
}

// 回掉
RCT_EXPORT_METHOD(add:(NSInteger)numA andNumB:(NSInteger)numB result:(RCTResponseSenderBlock)callback) {
    callback(@[@(numA + numB)]);
}

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

- (NSDictionary *)constantsToExport {
    return @{
             @"defaultValue": @"default value",
             @"testManagerTypeNone" : @(RNTestManagerTypeNone),
             @"testManagerTypeDefault" : @(RNTestManagerTypeDefault),
             @"testManagerTypeCustome" : @(RNTestManagerTypeCustome)
             };
}

RCT_EXPORT_METHOD(updateTestManagerType:(RNTestManagerType)type
                  completion:(RCTResponseSenderBlock)callback) {
    NSLog(@"%@", @(type));
    [self changeType:type];
    callback(@[@(type), @"success"]);
}

- (void)changeType:(RNTestManagerType)type {
    if (type != self.type) {
        self.type = type;
        
//        [self.bridge.eventEmitter sendEventWithName:@"typeChange" body:@{
//                                                                         @"type" : @(self.type)
//                                                                         }];
        [self.bridge.eventDispatcher sendAppEventWithName:@"typeChange"
                                                     body:@{
                                                            @"type" : @(self.type)
                                                            }];
    }
}

//- (RCTEventEmitter *)event {
//    if (nil == _event) {
//        _event = [[RCTEventEmitter alloc] init];
//        [_event startObserving];
//    }
//    return _event;
//}

//- (void)dealloc {
//    [self.event stopObserving];
//    self.event = nil;
//}

@end

@implementation RCTConvert (TestManagerType)
RCT_ENUM_CONVERTER(RNTestManagerType, (
                                       @{ @"testManagerTypeNone" : @(RNTestManagerTypeNone),
                                          @"testManagerTypeDefault" : @(RNTestManagerTypeDefault),
                                          @"testManagerTypeCustome" : @(RNTestManagerTypeCustome)}),
                   RNTestManagerTypeNone, integerValue)
@end




@implementation RCTBridge (RCTEventEmitter)

- (RCTEventEmitter *)eventEmitter
{
    return [self moduleForClass:[RCTEventEmitter class]];
}

@end
