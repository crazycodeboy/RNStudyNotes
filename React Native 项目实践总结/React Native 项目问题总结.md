#React Native学习总结
##React Native是什么？
React Native是一个框架，一个中间层，通过这套框架我们可以完成IOS和Android的开发。
##布局FlexBox
问题1:使用top时在iOS设备上布局没有问题,在Andorid上会出现位置偏移错位

解决:使用margin-top就没有问题,因为margin的相对定位，是指相对相邻元素的定位。top这些在绝对定位的前提下，这个绝对定位，相对父级元素的绝对定位。

问题2:设置不同的flexDirection,居中总是不确定使用alignItems还是justifyContent

解决:justifyContent 根据flexDirection而居中,比如row,就是水平居中,column就是垂直居中,alignItems就是相反
___
___
##图片加载
网络资源

`<Image source={{uri:'http://xxxxx/png'}}  />`

本地静态资源

`<Image source={require('image!lealogo')} />`

问题1:需要使用共能的方法或组件,然后根据不同的图片传人相应的参数,遇到加载本地图片的格式问题

解决:先定义一个如:type的变量,在使用组件的时候

`<cell source={这里就是你的本地图片路径比如 require('image!lealogo')}></cell>`

注意:等于号后面要使用{}

在方法内部这样写:`<Image source={this.props.source}/>`

例子:

```
//调用
<Cell title='客服电话' source={require('./img/personal_service.png')}></Cell>
<Cell title='设置' source={require('./img/personal_setting.png')}></Cell>

var Cell = React.createClass({
    render: function(){
        return (
            <View style={styles.cell_item}>
                <Image source={this.props.source} style={{marginLeft:10}}/>
                <Text style={{flex:1,left:10}}>{this.props.title}</Text>
                <Image style={{marginRight:10}} source={require('./img/personal_more.png')}/>
            </View>
        );
    }
});
```
___
___
##第三方库
问题:在个人界面,头像选择弹出一个alerView,并且实现跳转相机或相册然后选择图片回调等,如果自己实现会很麻烦而且耗时,这里我们使用第三方react-native-image-picker是一个不错的选择

解决:首先安装 npm install react-native-image-picker@latest --save,然后将node_modules中的RNImagePicker.xcodeproj添加到xcode工程中,在添加依赖等,然后运行,这里集成的时候遇到问题就是报找不文件,路径不对,最后把node_modules删除,重新npm install解决问题,使用的时候根据Options参数结合需求相应的配置即可

github地址:[react-native-image-picker](https://github.com/marcshilling/react-native-image-picker)
___
___
##React Native原生模块调用(iOS)
问题:在项目中遇到地图,拨打电话,清除缓存等iOS与Andiorid机制不同的功能,就需要调用原生的界面或功能,这里说下React Native与iOS混编,Andiorid也是大同小异

解决:

1 创建原生模块，实现“RCTBridgeModule”协议

`#import <Foundation/Foundation.h>`

` #import "RCTBridgeModule.h"`

`@interface KSDMapManager : NSObject <RCTBridgeModule>`

`@end`

2 导出模块，导出方法

`@implementation KSDMapManager`

//导出模块

`RCT_EXPORT_MODULE();`

```
RCT_EXPORT_METHOD(gotoIM:(RCTResponseSenderBlock)callback)
{
   __weak typeof(self) weakSelf = self;
  self.callback = callback;
  UIViewController *controller = (UIViewController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
  KSDMapLocationViewController *mapVc = [[KSDMapLocationViewController alloc] init];
  mapVc.handle = ^(NSString *address) {
    weakSelf.itemValue = address;
    NSArray *events = [[NSArray alloc] initWithObjects:self.itemValue, nil];
    callback(events);
  }; 
  [controller presentViewController:mapVc animated:YES completion:nil];
}
```
3 js文件中调用

//创建原生模块实例

var KSDMapManager = NativeModules.KSDMapManager;

//方法调用

```
KSDMapManager.gotoIM(
          (events)=>{
            this._inputReceiveAddress(events);
            console.log(events);
          })       
```
___
___
##热部署
###配置
H5的一大特点就是热部署,React Native同样也可以,本项目使用的是CodePush

首先安装客户端,创建CodePush账户,然后会调到浏览器让选择,这里我选择的是GitHub的账号,然后授权以后就会给一个秘钥,将此秘钥复制粘贴到命令行,最后`code-push app add <MyAppName>`到这里账号就配置完毕

接下来安装CodePush插件,然后将react-native-code-push文件夹中CodePush.xcodeproj直接拉入项目中Libraries中,添加依赖等,然后在AppDelegate中添加

```
#ifdef DEBUG
//  [RCTBundleURLProvider sharedSettings].jsLocation = @"192.168.1.120";
  //  [RCTBundleURLProvider sharedSettings].jsLocation = @"192.168.7.120";
  jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
#else
  jsCodeLocation = [CodePush bundleURL];
#endif
```

在命令行下使用code-push deployment ls <AppName> --displayKeys 查出Staging的值，在info.plist文件中添加CodePushDeploymentKey并且把Staging的值填入。 注意在Info.plist中将Bundle versions string, short的值修改为1.0.0,到此所有配置完毕

###调用
在需要改变的js文件中引入import codePush from "react-native-code-push";

在componentDidMount调用sync方法，当你的App启动的时候会在后台更新

```
componentDidMount(){
    codePush.sync();
  }
```
到此位置，所有的基本配置已经全部完成了，可以运行起你的程序啦，不过注意是Release不是Debug

###发布更新
将你修改的js文件打包为二进制文件，放入指定的地方（当前位置为根目录）。

`react-native bundle --platform ios --entry-file index.ios.js --bundle-output codepush.js --dev false`

将二进制文件push到staging 环境中

`code-push release ksd_geren_rn index.ios.js 1.0.0`

`code-push release ksd_geren_rn codepush.js 1.0.0`

###热部署成功---------------[完整配置链接点击这里](http://blog.csdn.net/u011151353/article/details/50688681)
___
