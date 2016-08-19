
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
