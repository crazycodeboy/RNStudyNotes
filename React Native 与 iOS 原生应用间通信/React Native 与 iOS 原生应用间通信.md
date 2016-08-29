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
    	RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation moduleName:@"Module" initialProperties:@{@"key1" : @"initialProperties"} launchOptions:nil];
    	rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];
    	self.view = rootView;
	}
	@end
	```
####2. React-Native 调用原生模块
如果React Native还不支持某个你需要的原生特性，这个时候就需要自己实现该特性的封装。

####3. React-Native 调用原生UI组件


[0]: http://www.lcode.org/react-native-integrating/