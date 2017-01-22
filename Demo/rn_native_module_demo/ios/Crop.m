/**
 * React Native iOS原生模块开发
 * Author: CrazyCodeBoy
 * 技术博文：http://www.devio.org
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */

#import "Crop.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface Crop ()
@property(strong,nonatomic)NSDictionary*option;
@end

@implementation Crop
-(instancetype)initWithViewController:(UIViewController *)vc{
  self=[super init];
  self.viewController=vc;
  return self;
}

-(void)selectImage:(NSDictionary*)option successs:(PickSuccess)success failure:(PickFailure)failure{
  self.pickSuccess=success;
  self.pickFailure=failure;
  self.option=option;
  UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
  pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  pickerController.delegate = self;
  pickerController.allowsEditing = YES;
  [self.viewController presentViewController:pickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
  UIImage*image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
  image=[self scaleToSize:image size:CGSizeMake([[self.option objectForKey:@"aspectX"]integerValue], [[self.option objectForKey:@"aspectY"]integerValue])];
  if(image){
    [self writeToFileWithImage:image outPut:[self getTempFile:[self getFileName:info]] handler:^(NSString *path) {
      [picker dismissViewControllerAnimated:YES completion:nil];
      self.pickSuccess(@{@"imageUrl": path});
    }];
    
  }else{
    self.pickFailure(@"获取照片失败");
    [picker dismissViewControllerAnimated:YES completion:nil];
  }
  
}
#pragma mark 裁剪照片
-(UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size
{
  //并把他设置成当前的context
  UIGraphicsBeginImageContext(size);
  //绘制图片的大小
  [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
  //从当前context中创建一个改变大小后的图片
  UIImage *endImage=UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  return endImage;
}
#pragma mark 将image写入沙盒
-(void)writeToFileWithImage:(UIImage*)image outPut:(NSString*)imagePath handler:(void(^)(NSString *path))handler{
  NSData *data= UIImageJPEGRepresentation(image, 1);
  [data writeToFile:imagePath atomically:YES];
  dispatch_async(dispatch_get_main_queue(), ^{
    handler(imagePath);
  });
  
}
#pragma mark 将指定url对于的图片写入沙盒
-(void)writeToFileWithUrl:(NSURL*)url outPut:(NSString*)imagePath handler:(void(^)(NSString *path))handler{
  ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
  if (url) {
    [assetLibrary assetForURL:url resultBlock:^(ALAsset *asset) {
      ALAssetRepresentation *rep = [asset defaultRepresentation];
      Byte *buffer = (Byte*)malloc((unsigned long)rep.size);
      NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:((unsigned long)rep.size) error:nil];
      NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
      [data writeToFile:imagePath atomically:YES];
      dispatch_async(dispatch_get_main_queue(), ^{
        handler(imagePath);
      });
    } failureBlock:^(NSError *error) {
      dispatch_async(dispatch_get_main_queue(), ^{
        handler(@"获取图片失败");
      });
    }];
  }
}
#pragma mark 获取临时文件路径
-(NSString*)getTempFile:(NSString*)fileName{
  NSString *imageContent=[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingString:@"/temp"];
  NSFileManager * fileManager = [NSFileManager defaultManager];
  if (![fileManager fileExistsAtPath:imageContent]) {
    [fileManager createDirectoryAtPath:imageContent withIntermediateDirectories:YES attributes:nil error:nil];
  }
  return [imageContent stringByAppendingPathComponent:fileName];
}
-(NSString*)getFileName:(NSDictionary*)info{
  NSString *fileName;
  NSString *tempFileName = [[NSUUID UUID] UUIDString];
  fileName = [tempFileName stringByAppendingString:@".jpg"];
  return fileName;
}
@end
