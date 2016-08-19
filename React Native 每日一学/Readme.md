
# React Native 每日一学(Learn a little every day)  

汇聚知识，分享精华。  
>如果你是一名React Native爱好者，或者有一颗热爱钻研新技术的心，喜欢分享技术干货、项目经验、以及你在React Naive学习研究或实践中的一些经验心得等等，欢迎投稿《React Native 每日一学》栏目。   
如果你是一名Android、iOS、或前端开发人员，有者一颗积极进取的心，欢迎关注《React Native 每日一学》。本栏目汇聚React Native开发的技巧，知识点，经验等。  

## 列表  
1. [D1:React Native 读取本地的json文件 (2016-8-18)](#d1react-native-读取本地的json文件-2016-8-18)
2. [D2:React Native import 文件的小技巧 (2016-8-19)](#d2react-native-import-文件的小技巧-2016-8-19)


```
模板：   
D1:标题 (日期)
------
概述
### 子标题
内容  
### 子标题
内容   
另外：记得在列表中添加链接 
```
D3:React Native 真机调试 (2016-8-22)
------ 
开发中真机调试时必不可少的,有些功能和问题模拟器是无法重现的,所以就需要配合真机测试,接下来就说下安卓和iOS的真机调试,不难,但是有很多细节需要注意

###iOS 真机调试
1. ``必须`` 保证调试用电脑的和你的设备处于相同的 ``WiFi ``网络环境中下
2. 打开Xcode,找到 AppDelegate.m 文件
3. 更改 jsCodeLocation 中的 localhost 改成你电脑的局域网IP地址
4. IP地址点击左面右上角WIFi图标,找到打开网络偏好设置,状态栏下就可以看见了
5. 在Xcode中,选择你的手机作为目标设备,Run运行就可以了
![React Native 真机调试的json文件-1]

###Android 真机调试
1. 在 Android 设备上打开 USB debugging 并连接上电脑启动调试。

2. 在真机上运行的方法与在模拟器上运行一致，都是通过 react-native run-android 来安装并且运行你的 React Native 应用。

3. 如果不是 Android 5.0+ (API 21) ，那么就没办法通过 adb reverse 进行调试，需要通过 WiFi 来连接上你的开发者服务器
4. 让调试用电脑和你的手机必须处于相同的 WiFi 网络中下 打开震动菜单 (摇动设备)->前往 Dev Settings->选择 Debug server host for device->输入调试用电脑的局域网IP->点击 Reload JS

注:因为本人不是安卓开发,所以参考[http://my.oschina.net/imot/blog/512808](http://my.oschina.net/imot/blog/512808)

###细节
其实还是有些坑的,这里只说iOS
如开始所说,必须是同一网络下,有时电脑同时开着Wifi和插着网线,建议把网线拔掉,但是也不排除可以,没有试过,还有就是

``jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];``

这一句千万不能注释,需要注意的就这几点,很简单

D2:React Native import 文件的小技巧 (2016-8-19)
------  
开发中经常需要 import 其他 js 文件，如果需要同时导入一些相关的 js 文件时，可以创建一个索引文件方便引用。  

### 第一步：创建index.js   
在 index.js 中 import 相关的 js 文件

```
'use strict';

import * as Type from './network/EnvironmentConst';
import Request from './network/RequestManager';
import AppContext from './network/AppContext';
import ApiServiceFactory from './network/ApiServiceFactory';

module.exports = {
    ApiServiceFactory,
    Type,
    Request,
    AppContext
};
```

### 第二步：使用   
如果需要使用这些类，只需要导入index文件就可以了~

```
import {Request, ApiServiceFactory, AppContext, Type} from '../expand/index';
```


D1:React Native 读取本地的json文件 (2016-8-18)
------  
自 React Native 0.4.3，你可以以导入的形式，来读取本地的json文件，导入的文件可以作为一个js对象使用。      

### 第一步：导入json文件   

```javascript
var langsData = require('../../../res/data/langs.json');
```

ES6/ES2015     

```javascript
import langsData from '../../../res/data/langs.json'
```

### 第二步：使用   
如果`langs.json`的路径正确切没有格式错误，那么现在你可以操作`langsData`对象了。  

### Usage  

**读取`langs.json`**  

![React Native 读取本地的json文件-1](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%20%E6%AF%8F%E6%97%A5%E4%B8%80%E5%AD%A6/images/D1/React%20Native%20%E8%AF%BB%E5%8F%96%E6%9C%AC%E5%9C%B0%E7%9A%84json%E6%96%87%E4%BB%B6-1.png)

**使用`langs.json`**    

![React Native 读取本地的json文件-2](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%20%E6%AF%8F%E6%97%A5%E4%B8%80%E5%AD%A6/images/D1/React%20Native%20%E8%AF%BB%E5%8F%96%E6%9C%AC%E5%9C%B0%E7%9A%84json%E6%96%87%E4%BB%B6-2.png)  

@[How to fetch data from local JSON file on react native?](http://stackoverflow.com/questions/29452822/how-to-fetch-data-from-local-json-file-on-react-native)
