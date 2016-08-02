React Native调试技巧  

## Developer Menu

Developer Menu是React Native给开发者定制的一个开发者菜单，来帮助开发者调试React Native应用。 
>提示：生产环境release (production) 下Developer Menu是不可用的。

### 如何开启Developer Menu  

#### 在模拟器上开启Developer Menu

#####  Android模拟器： 

可以通过`Command⌘ + M `快捷键来快速打开Developer Menu。也可以通过模拟器上的菜单键来打开。  
>高版本的模拟器通常没有菜单键的，不过Nexus S上是有菜单键的，如果想使用菜单键，可以创建一个Nexus S的模拟器。  

#####  iOS模拟器： 

可以通过`Command⌘ + D`快捷键来快速打开Developer Menu。   

#### 在真机上开启Developer Menu：

在真机上你可以通过摇动手机来开启Developer Menu。  

#### 预览图
![Developer Menu.jpg](/Users/penn/Documents/RNStudyNotes/React Native调试技巧/images/Developer Menu.jpg)

## Reloading JavaScript

在只是修改了js代码的情况下，如果要预览修改结果，你不需要重新编译你的应用。在这种情况下，你只需要告诉React Native重新加载js即可。  

>提示：如果你修改了native 代码或修改了Images.xcassets、res/drawable中的文件，重新加载js是不行的，这时你需要重新编译你的项目了。 


### Reload js
Reload js即将你项目中js代码部分重新生成bundle，然后传输给模拟器或手机。  
在Developer Menu中有`Reload`选项，单击`Reload`让React Native重新加载js。对于iOS模拟器你也可以通过`Command⌘ + R `快捷键来加载js，对于Android模拟器可以通过双击`r`键来加载js。  
>如果`Command⌘ + R `无法使你的iOS模拟器加载js，则可以通过选中Hardware menu中Keyboard选项下的 "Connect Hardware Keyboard" 。

### 小技巧：Automatic reloading

#### Enable Live Reload
![Enable Live Reload](/Users/penn/Desktop/Enable Live Reload.gif)

React Native旨在为开发者带来一个更好的开发体验。如果你觉得上文的加载js代码方式太low了或者不够方便，那么有没有一种更简便加载js代码的方式呢？  
答案是肯定的。    
在 Developer Menu中你会看到"Enable Live Reload" 选项，该选项提供了React Native动态加载的功能。当你的js代码发生变化后，React Native会自动生成bundle然后传输到模拟器或手机上，是不是觉得很方便。    

#### Hot Reloading 
![Hot Reloading](/Users/penn/Desktop/ Hot Reloading .gif)
另外，Developer Menu中还有一项需要特别介绍的，就是"Hot Reloading"热加载，如果说Enable Live Reload解放了你的双手的话，那么Hot Reloading不但解放了你的双手而且还解放了你的时间。  当你每次保存代码时Hot Reloading功能便会生成此次修改代码的增量包，然后传输到手机或模拟器上以实现热加载。相比 Enable Live Reload需要每次都返回到启动页面，Enable Live Reload则会在保持你的程序状态的情况下，就可以将最新的代码部署到设备上，听起来是不是很疯狂呢。  

>提示：当你做布局的时候启动Enable Live Reload功能你就可以实时的预览布局效果了，这可以和用AndroidStudio或AutoLayout做布局的实时预览相媲美。

## Errors and Warnings 

在development模式下，js部分的Errors 和 Warnings会直接打印在手机或模拟器屏幕上，以红屏和黄屏展示。 

### Errors  

React Native程序运行时出现的Errors会被直接显示在屏幕上，以红色的背景显示，并会打印出错误信息。  你也可以通过` console.error()`来手动触发Errors。

![Errors](/Users/penn/Documents/RNStudyNotes/React Native调试技巧/images/Errors.png)

### Warnings  
 
React Native程序运行时出现的Warnings也会被直接显示在屏幕上，以黄色的背景显示，并会打印出警告信息。  你也可以通过` console.warn()`来手动触发Warnings。
你也可以通过`console.disableYellowBox = true`来手动禁用Warnings的显示，或者通过`console.ignoredYellowBox = ['Warning: ...'];`来忽略相应的Warning。  

![Warnings](/Users/penn/Documents/RNStudyNotes/React Native调试技巧/images/Warnings.png)

>提示：在生产环境release (production)下Errors和Warnings功能是不可用的。  


## Chrome Developer Tools  
你可以向调试JavaScript代码一样来调试你的React Native程序。   

### 如何通过 Chrome调试React Native程序  
你可以通过以下步骤来调试你的React Native程序：  

#### 第一步：启动远程调试   
在Developer Menu下单击"Debug JS Remotely" 启动JS远程调试功能。此Chrome会被打开，同时会创建一个“http://localhost:8081/debugger-ui.” Tab页。  
![http-//localhost-8081/debugger-ui](/Users/penn/Documents/RNStudyNotes/React Native调试技巧/images/http-::localhost-8081:debugger-ui.png)

#### 第二步：打开Chrome开发者工具
在该“http://localhost:8081/debugger-ui.”Tab页下打开开发者工具。打开Chrome菜单->选择更多工具->选择开发者工具。你也可以通过快捷键(Command⌘ + Option⌥ + I on Mac, Ctrl + Shift + I on Windows)打开。

![打开开发者工具](/Users/penn/Documents/RNStudyNotes/React Native调试技巧/images/打开开发者工具.png)

打开Chrome开发着工具之后你会看到如下界面：  
![打开Chrome开发着工具](/Users/penn/Documents/RNStudyNotes/React Native调试技巧/images/打开Chrome开发着工具.png)   

### 真机调试  

#### 在iOSS上

打开"RCTWebSocketExecutor.m "文件，将“localhost”改为你的电脑的ip，然后在Developer Menu下单击"Debug JS Remotely" 启动JS远程调试功能。

#### 在Android上   
方式一：   
在Android5.0以上设备上，将手机通过usb连接到你的电脑，然后通过adb命令行工具运行如下命令来设置端口转发。   
`adb reverse tcp:8081 tcp:8081`  

方式二：  
你也可以通过在“Developer Menu”下的“Dev Settings”中设置你的电脑ip来进行调试。  

### 小技巧：

#### 查看js文件    
如果你想在开发者工具上预览你的js文件，可以在打开Sources tab下的debuggerWorker.js选项卡，该选项卡下回显示当前调试项目的所有js文件。 
  
![查看js文件](/Users/penn/Documents/RNStudyNotes/React Native调试技巧/images/查看js文件.png)


#### 断点其实很简单   


#### 不要忽略控制台


ToDo：

* Developer Menu 
* 模拟机调试
	* iOS
	* Android 
* 真机调试  
	* iOS
	* Android 
* 技巧 