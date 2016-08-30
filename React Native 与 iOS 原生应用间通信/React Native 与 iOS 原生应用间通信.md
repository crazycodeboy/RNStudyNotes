### React-Native 与 iOS原生项目间通信
---

如果你已经搭建好 React-Native （后面简称为RN）开发环境的话，你可以通过以下命令行快速的创建一个RN项目，并运行起来。

```
react-native init AwesomeProject
cd AwesomeProject
react-native run-ios
```
但是，如果我们想在现有的项目中集成 RN 该怎么做呢？又怎么在原生 iOS 项目中调用 RN 组件？以及 RN 中怎么调用原生的UI组件、原生模块呢？

####1. 集成 React-Native 到 iOS 原生项目
开发 iOS 应用时，一般都会使用 CocoaPods 管理第三方开源类库，这里同样使用 CocoaPods 集成 RN，如果你的项目中不想使用 CocoaPods 的话，你可以参考[这里][0]，手动添加依赖到到原生项目中。

1. 创建一个文件夹 RNProject
1. 创建 package.json 文件
	- 在 RNProject 中 添加 package.json 文件
	- 编辑 package.json 文件，并保存
	
		```
		{
  			"name": "RNProject",
  			"version": "0.0.1",
  			"private": true,
  			"scripts": {
    			"start": "node node_modules/react-native/local-cli/cli.js start"
  			},
  			"dependencies": {
    			"react": "15.3.0",
    			"react-native": "0.32.0"
  			}
		}
		```
1. 安装 Packages

	```
	// 执行 npm install 之后，将会安装 package.json 中添加的依赖包到 node_modules/ 中
	// Tip：记得在 .gitignore 里面添加了 node_modules/ ，不然提交到版本控制仓库的时候会有好多文件。
		
	$ npm install
	```
1. 添加原生项目到根目录下	
1. 在 Podfile 添加依赖

	```
	platform:ios, '7.0'
	inhibit_all_warnings!
	
	target "Project" do
	
	pod 'React', :path => '../node_modules/react-native', :subspecs => [
		'Core',
		'RCTText',
		'RCTImage',
		'RCTWebSocket'
	]
	end
	```
	```
	Tip:
	React 默认只添加 Core 这一个子模块，如果想要使用其他模块（Text，Image等等），需要在 subspecs 中手动添加。如果使用没有添加的模块，运行时会报错：`Native Module cannot be null`.
	默认添加模块：'Core'
	其他依赖：ios, "7.0"
	所有子模块：
	'Core' 
	'ART'  
	'RCTActionSheet' 
	'RCTAdSupport' 
	'RCTAnimation'  
	'RCTCameraRoll'  
	'RCTGeolocation' 
	'RCTImage'  
	'RCTNetwork'   
	'RCTPushNotification'  
	'RCTSettings'  
	'RCTText'  
	'RCTVibration'  
	'RCTWebSocket'   
	'RCTLinkingIOS'   
	'RCTTest'
	```

1. pod 安装

	```
	$ pod install
	```


简单几部就完成了在原生项目里继承 RN，但是，虽说集成成功了，可是我们还不知道怎么相互调用，接下来，我们一起看看怎么在 iOS 原生界面中调用 RN 界面。

####2. iOS 原生界面调用 React-Native 界面

通过初始化RCTRootView，来载入使用 RN 开发的界面，对应的在 js 代码中，我们会有一个 index.ios.js 文件，这里在 AppRegistry.registerComponent 时传入的参数为 'Module'， 那么我们在初始化 RCTRootView 的时候传入的 moduleName 也为 'Module'，以及我们在设置 jsCodeLocation 时传入的 BundleRoot 为 @"index.ios"。

- JS 代码

	```
	'use strict';

	import {AppRegistry} from 'react-native';
	import Root from './js/root';

	AppRegistry.registerComponent('Module', () => Root);

	```

- OC 代码

	```
	#import "RNViewController.h"
	#import "RCTBundleURLProvider.h"
	#import "RCTRootView.h"
	
	@interface RNViewController ()

	@end

	@implementation RNViewController

	- (void)viewDidLoad {
    	[super viewDidLoad];
    	
    	[RCTBundleURLProvider sharedSettings].jsLocation = @"127.0.0.1";
    	NSURL *jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
    	// 初始化RCTRootView，来载入JavaScript并渲染View
    	// initialProperties 调用 JS 代码需要传入的参数
    	RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"Module" initialProperties:@{@"key1" : @"initialProperties"} launchOptions:nil];
    	rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    	self.view = rootView;
	}
	@end
	```
	
####2. React-Native 调用原生模块
如果React Native还不支持某个你需要的原生特性，这个时候就需要自己实现该特性的封装。

##### 桥接原生模块
首先我们需要创建一个类，然后导入头文件 `#import "RCTBridgeModule.h"` ,这个类需要实现 `RCTBridgeModule` 协议。

```
// CalendarManager.h
#import "RCTBridgeModule.h"

@interface CalendarManager : NSObject <RCTBridgeModule>
@end
```
在类的实现部分，需要包含 `RCT_EXPORT_MODULE()` 宏，这个宏也可以添加一个参数用来指定在Javascript中访问这个模块的名字。如果你不指定，默认就会使用这个Objective-C类的名字。

```
// CalendarManager.m
@implementation CalendarManager

RCT_EXPORT_MODULE(); //CalendarManager
//RCT_EXPORT_MODULE(Calendar);

@end

```

##### 导出方法给 JS 调用
如果想要在 RN 中调用原生的方法，需要这 OC 代码中声明 `RCT_EXPORT_METHOD()`，导出到 JS 的方法名是 OC 的方法名的第一个部分，桥接到 JS 的方法返回值类型必须是 void。RN 的桥接操作是异步的，所以要返回结果给 JS，你必须通过回调或者触发事件来进行。传入的参数类型有以下几种：

- string (NSString)
- number (NSInteger, float, double, CGFloat, NSNumber)
- boolean (BOOL, NSNumber)
- array (NSArray) 包含本列表中任意类型
- object (NSDictionary) 包含string类型的键和本列表中任意类型的值
- function (RCTResponseSenderBlock)

这样我们就可以写一个简单的方法来让 JS 调用了。


```
RCT_EXPORT_METHOD(addEvent:(NSString *)name location:(NSString *)location)
{
  RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);
}
```

##### 回掉函数
如果我们需要在 OC 代码中返回结果给 JS， 我们可以通过传递一个回掉函数到原生代码中。`RCTResponseSenderBlock` 只接受一个参数——传递给 JS 回调函数的参数数组。

```
RCT_EXPORT_METHOD(findEvents:(RCTResponseSenderBlock)callback)
{
  NSArray *events = ...
  callback(@[params, params2 ...]);
}
```

##### 设置原生模块执行操作的线程
如果你在原生模块中需要更改 UI 或者必须在主线程的话，可以实现 `- (dispatch_queue_t)methodQueue` 方法

```
- (dispatch_queue_t)methodQueue
{
  return dispatch_get_main_queue();
}
```
同样的也可以返回自定义的独立队列。如果返回的有 `methodQueue` 那么原生模块的所有方法都会在当前 `methodQueue`执行。

##### 导出常量
原生模块可以导出一些常量，这些常量在 JS 端随时都可以访问。用这种方法来传递一些静态数据，可以避免通过 bridge 进行一次来回交互。常量仅仅在初始化的时候导出了一次，所以即使你在运行期间改变常量返回的值，也不会影响到 JS 环境下所得到的结果。

```
- (NSDictionary *)constantsToExport
{
  return @{ @"firstDayOfTheWeek": @"Monday" };
}
```
```
console.log(CalendarManager.firstDayOfTheWeek);
```

**枚举常量**

用NS_ENUM定义的枚举类型必须要先扩展对应的RCTConvert方法才可以作为函数参数传递。

```
typedef NS_ENUM(NSInteger, UIStatusBarAnimation) {
    UIStatusBarAnimationNone,
    UIStatusBarAnimationFade,
    UIStatusBarAnimationSlide,
};
```

```
@implementation RCTConvert (StatusBarAnimation)
  RCT_ENUM_CONVERTER(UIStatusBarAnimation, (@{ @"statusBarAnimationNone" : @(UIStatusBarAnimationNone),
                                               @"statusBarAnimationFade" : @(UIStatusBarAnimationFade),
                                               @"statusBarAnimationSlide" : @(UIStatusBarAnimationSlide)}),
                      UIStatusBarAnimationNone, integerValue)
@end
```

```
- (NSDictionary *)constantsToExport
{
  return @{ @"statusBarAnimationNone" : @(UIStatusBarAnimationNone),
            @"statusBarAnimationFade" : @(UIStatusBarAnimationFade),
            @"statusBarAnimationSlide" : @(UIStatusBarAnimationSlide) }
};

RCT_EXPORT_METHOD(updateStatusBarAnimation:(UIStatusBarAnimation)animation
                                completion:(RCTResponseSenderBlock)callback)
```

##### 给 JS 发送事件
即使没有被 JS 调用，本地模块也可以给 JS 发送事件通知。最直接的方式是使用 `eventDispatcher:`

```
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation CalendarManager

@synthesize bridge = _bridge;

- (void)calendarEventReminderReceived:(NSNotification *)notification
{
  NSString *eventName = notification.userInfo[@"name"];
  [self.bridge.eventDispatcher sendAppEventWithName:@"EventReminder"
                                               body:@{@"name": eventName}];
}

@end
```

在 JS 中可以这样订阅事件：

```
var { NativeAppEventEmitter } = require('react-native');

var subscription = NativeAppEventEmitter.addListener(
  'EventReminder',
  (reminder) => console.log(reminder.name)
);
...
// 千万不要忘记忘记取消订阅, 通常在componentWillUnmount函数中实现。
subscription.remove();
```


####3. React-Native 调用原生UI组件


[0]: http://www.lcode.org/react-native-integrating/