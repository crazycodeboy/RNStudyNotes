/**
 * React Native iOS原生模块开发
 * Author: CrazyCodeBoy
 * 技术博文：http://www.devio.org
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */


#import "ImageCrop.h"
#import "Crop.h"

@interface ImageCrop ()
@property(strong,nonatomic)Crop *crop;
@end

@implementation ImageCrop


RCT_EXPORT_MODULE();

- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}
RCT_EXPORT_METHOD(selectWithCrop:(NSInteger)aspectX aspectY:(NSInteger)aspectY resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    UIViewController *root = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    while (root.presentedViewController != nil) {
      root = root.presentedViewController;
    }
  NSString*aspectXStr=[NSString stringWithFormat: @"%ld",aspectX];
  NSString*aspectYStr=[NSString stringWithFormat: @"%ld",aspectY];
  [[self _crop:root] selectImage:@{@"aspectX":aspectXStr,@"aspectY":aspectYStr} successs:^(NSDictionary *resultDic) {
    resolve(resultDic);
  } failure:^(NSString *message) {
    reject(@"fail",message,nil);
  }];
}
-(Crop*)_crop:(UIViewController*)vc{
  if(self.crop==nil){
    self.crop=[[Crop alloc] initWithViewController:vc];
  }
  return self.crop;
}

@end
