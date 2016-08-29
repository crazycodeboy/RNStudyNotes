### React-Native 与 iOS原生项目交互
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
	
####2. iOS 原生界面调用 React-Native 界面
	
####2. React-Native 调用原生UI组件

####3. React-Native 调用原生UI模块


[0]: http://www.lcode.org/react-native-integrating/