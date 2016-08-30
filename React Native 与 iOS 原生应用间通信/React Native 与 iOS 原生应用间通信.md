### React-Native 与 iOS原生项目间通信
---

如果你已经搭建好 React-Native （后面简称为RN）开发环境的话，你可以通过以下命令行快速的创建一个 RN 项目，并运行起来。

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
	$ npm start
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
	更多详细内容，可以查看 `/node_modules/react-native/React.podspec` 文件
	```

1. pod 安装

	```
	$ pod install
	```

**其他**

	Tip: 如果报错 could not connect to development server
	
	1. 是否 npm start
	
	2. 是否Xcode7,在info.plist 文件中添加
	<key>NSAppTransportSecurity</key>
	<dict>
    	<key>NSExceptionDomains</key>
    	<dict>
        	<key>localhost</key>
        	<dict>
            	<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
            	<true/>
        	</dict>
    	</dict>
	</dict>
	或者
	<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    
    3.是否设置正确的IP地址，如果是真机的话请确保手机与电脑在同一局域网。


简单几部就完成了在原生项目里集成 RN，但是，虽说集成成功了，可是我们还不知道怎么相互调用，接下来，我们一起看看怎么在 iOS 原生界面中调用 RN 界面。

####2. iOS 原生界面调用 React-Native 界面

通过初始化 `RCTRootView`，来载入使用 RN 开发的界面，对应的在 js 代码中，我们会有一个 index.ios.js 文件，这里在 `AppRegistry.registerComponent` 时传入的参数为 'Module'， 那么我们在初始化 RCTRootView 的时候传入的 moduleName 也为 'Module'，以及我们在设置 jsCodeLocation 时传入的 BundleRoot 为 @"index.ios"。

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
    	
    	// initialProperties 参数是传递给 JS 的数据，在 JS 中可以通过 `this.props.key1` 获取到传入的值。
    	
    	RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"Module" initialProperties:@{@"key1" : @"initialProperties"} launchOptions:nil];
    	rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    	self.view = rootView;
	}
	@end
	```
####2. React-Native 调用原生模块
如果React Native还不支持某个你需要的原生特性，这个时候就需要自己实现该特性的封装。

#### 桥接原生模块
首先我们需要创建一个类，然后导入头文件 `#import <RCTBridgeModule.h>` ,这个类需要实现 `RCTBridgeModule` 协议。

```
#import <Foundation/Foundation.h>
#import <RCTBridgeModule.h>

@interface RNTestManager : NSObject <RCTBridgeModule>

@end
```
在类的实现部分，需要包含 `RCT_EXPORT_MODULE()` 宏，这个宏也可以添加一个参数用来指定在 JS 中访问这个模块的名字。如果你不指定，默认就会使用这个 OC 类的名字。

```
#import "RNTestManager.h"

@implementation RNTestManager

//RCT_EXPORT_MODULE();
RCT_EXPORT_MODULE(Test); //注意这里不要加引号和 @ ，直接写模块的名字就可以了。

@end
```

#### 导出方法给 JS 调用
如果想要在 RN 中调用原生的方法，需要这 OC 代码中声明 `RCT_EXPORT_METHOD()`，导出到 JS 的方法名是 OC 的方法名的第一个部分，桥接到 JS 的方法返回值类型必须是 void。RN 的桥接操作是异步的，所以如果要返回结果给 JS，你必须通过回调或者触发事件来进行。传入的参数类型有以下几种：

- string (NSString)
- number (NSInteger, float, double, CGFloat, NSNumber)
- boolean (BOOL, NSNumber)
- array (NSArray) 包含本列表中任意类型
- object (NSDictionary) 包含string类型的键和本列表中任意类型的值
- function (RCTResponseSenderBlock)

我们在 OC 实现 RCT_EXPORT_METHOD，这样我们就可以写一个简单的方法来让 JS 调用了。

```
RCT_EXPORT_METHOD(print:(NSString *)text) {
    NSLog(@"%@", text);
}
```

```
// JS 部分这样调用
Test.print("Hello World");

//Xcode控制台输出
2016-08-30 11:12:16.420 Project[6679:147285] Hello World
```

#### 回掉函数
如果我们需要在 OC 代码中返回结果给 JS， 我们可以通过传递一个回掉函数到原生代码中。`RCTResponseSenderBlock` 只接受一个参数——传递给 JS 回调函数的参数数组。

```
RCT_EXPORT_METHOD(add:(NSInteger)numA andNumB:(NSInteger)numB result:(RCTResponseSenderBlock)callback) {
    callback(@[@(numA + numB)]);
}
```

```
// JS 部分这样调用
Test.add(1, 2, (result) => {
                        alert('1 + 2 = ' + result);
                    });
```

#### 设置原生模块执行操作的线程
如果你在原生模块中需要更改 UI 或者必须在主线程的话，可以实现 `- (dispatch_queue_t)methodQueue` 方法

```
- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}
```
同样的也可以返回自定义的独立队列。如果返回的有 `methodQueue` 那么原生模块的所有方法都会在当前 `methodQueue` 执行。

#### 导出常量
原生模块可以导出一些常量，这些常量在 JS 端随时都可以访问。用这种方法来传递一些静态数据，可以避免通过 bridge 进行一次来回交互。常量仅仅在初始化的时候导出了一次，所以即使你在运行期间改变常量返回的值，也不会影响到 JS 环境下所得到的结果。

```
- (NSDictionary *)constantsToExport {
    return @{
             @"defaultValue": @"default value"
             };
}
```

```
// JS 部分这样调用 Test.defaultValue
alert(Test.defaultValue);
```
**枚举常量**

用NS_ENUM定义的枚举类型必须要先扩展对应的 `RCTConvert` 方法才可以作为函数参数传递。添加头文件 `#import <RCTConvert.h>`

```
typedef NS_ENUM(NSInteger, RNTestManagerType) {
    RNTestManagerTypeNone,
    RNTestManagerTypeDefault,
    RNTestManagerTypeCustome,
};
```

```
@implementation RCTConvert (TestManagerType)
RCT_ENUM_CONVERTER(RNTestManagerType, (
                                       @{ @"testManagerTypeNone" : @(RNTestManagerTypeNone),
                                          @"testManagerTypeDefault" : @(RNTestManagerTypeDefault),
                                          @"testManagerTypeCustome" : @(RNTestManagerTypeCustome)}),
                   RNTestManagerTypeNone, integerValue)
@end
```

```
- (NSDictionary *)constantsToExport {
    return @{
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
```

#### 给 JS 发送事件
即使没有被 JS 调用，本地模块也可以给 JS 发送事件通知。最直接的方式是使用 `eventDispatcher:`，导入 `#import <RCTEventDispatcher.h>`

```
#import "RCTBridge.h"
#import "RCTEventDispatcher.h"

@implementation RNTestManager

@synthesize bridge = _bridge;

- (void)changeType:(RNTestManagerType)type {
    if (type != self.type) {
        self.type = type;
        [self.bridge.eventDispatcher sendAppEventWithName:@"typeChange"
                                                     body:@{
                                                            @"type" : @(self.type)
                                                            }];
    }
}

@end
```

在 JS 中可以这样订阅事件：

```
import { NativeAppEventEmitter } from 'react-native';

componentDidMount() {
    this.subscription = NativeAppEventEmitter.addListener(
                        'typeChange',
                        (result)  => alert(result.type)
                    );
}

componentWillUnmount() {
    this.subscription.remove();
}
```


####3. React-Native 调用原生UI组件
RN 开发中已经封装了大部分常用的组件，但有些组件需要我们自定义，如果在原生中有已经封装好的组件的话，我们可以在 RN 中封装和植入已有的组件。

#### 植入原生组件
首先我们创建一个类继承自 `RCTViewManager`，并在实现部分添加 `RCT_EXPORT_MODULE()` 宏，然后实现 `- (UIView *)view`方法；

```
#import <RCTViewManager.h>

@interface RNTextManager : RCTViewManager

@end

```

```
#import "RNTextManager.h"
#import "RNText.h"

@implementation RNTextManager

RCT_EXPORT_MODULE()

- (UIView *)view {
    return [[RNText alloc] init];
}

@end

```

这样我们就可以在 JS 中调用原生UI组件了，

```
//RNText.js
import { requireNativeComponent } from 'react-native';

module.exports = requireNativeComponent('RNText', null);

//home.js
<View style={{flex: 1, backgroundColor: '#ffffee'}}>
	<RNText style={{flex: 1}}/>
</View>
```

#### 导出组件属性
一般需要导出的原生组件都有一些定义的属性，所以我们需要封装一些原生属性供 JS 使用。

```
// RNTextManager.m
RCT_EXPORT_VIEW_PROPERTY(value, NSString)

// RNText.h
@interface RNText : UIView

@property (copy, nonatomic) NSString *value;

@end

```

我们在 JS 中就可以这样调用了

```
<RNText value="HaHaHa~~~" style={{flex: 1}}/>
```

为了方便在 JS 中直接使用，不用查看 OC 代码获取属性名和类型，我们可以封装一个 RN 组件

```
//RNText.js
import React, { Component, PropTypes } from 'react';
import { requireNativeComponent } from 'react-native';

var UIText = requireNativeComponent('RNText', RNText);

export default class RNText extends Component {
  static propTypes = {
    value: PropTypes.string
  };

  static defaultProps = {
  }

  render() {
      return <UIText {...this.props} />;
  }
}
```

#### 事件
如果你添加了一个二维码扫描的组件，那么当扫描二维码成功之后，我们需要把扫描结果传递给 JS，或者其他需要处理来自原生组件的事件。这时，我们就需要在继承自 `RCTViewManager` 的类中声明一个事件处理函数(`RCTBubblingEventBlock`)的属性，来委托我们提供的所有视图，然后把事件属性传递给 JS。

```
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

```

```
// RNText.m

...

- (void)setupChangeAction {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.value = @" 5 S ~~~";
        if ([self.delegate respondsToSelector:@selector(text:valueChange:)]) {
            [self.delegate text:self valueChange:self.label.text];
        }
    });
}

...

```

```
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
```

当 `RNText` 组件初始化 5s 后，会把当前组件和值传递给组件的代理 `RNTextManager`，然后在代理方法中调用 `onChange` 传递数据。如果我们在 JS 中实现 `onChange` 回掉函数，就可以通过 `obj.nativeEvent` 可以获取到传递的字典，然后通过 `obj.nativeEvent.value` 就可以获取到传递过去的 value 的值。在 JS 封装的组件中，我们可以添加一个属性回掉函数，传递处理后的数据，方便外部 JS 的使用。

```
//RNText.js
import React, { Component, PropTypes } from 'react';
import { requireNativeComponent } from 'react-native';

var UIText = requireNativeComponent('RNText', RNText);

export default class RNText extends Component {
  static propTypes = {
      value: PropTypes.string,
      onValueChange: PropTypes.func
  };

  static defaultProps = {
  }

  render() {
      return <UIText {...this.props} onChange={(obj) => {
          this.props.onValueChange(obj.nativeEvent.value);
      }} />;
  }
}

//home.js
<RNText value="HaHaHa~~~" 
		onValueChange={(value) => {
                        alert(value);
                    }}
        style={{flex: 1}}/>
```


为了方便理解，我这里写了一个简单的[Demo][1]，没有上传 node_modules 文件夹以及 Pods 文件夹，下载下来记得 
`npm install` `pod install`


[0]: http://www.lcode.org/react-native-integrating/
[1]: ./RNProject