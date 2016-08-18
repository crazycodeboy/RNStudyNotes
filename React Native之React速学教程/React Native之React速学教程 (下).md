# React Native之React速学教程(下) 

本文出自[《React Native学习笔记》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。

React Native是基于React的，在开发React Native过程中少不了的需要用到React方面的知识。虽然官方也有相应的Document，但篇幅比较多，学起来比较枯燥。
通过《React Native之React速学教程》你可以对React有更系统和更深入的认识。为了方便大家学习，我将《React Native之React速学教程》分为[上](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%8A\).md)、[中](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%AD\)%20.md)、[下](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%8B\).md)三篇，大家可以根据需要进行阅读学习。  

## 概述

本篇为《React Native之React速学教程》的最后一篇。本篇将带着大家一起认识ES6，学习在开发中常用的一些ES6的新特性，以及ES6与ES5的区别，解决大家在学习React /React Native过程中对于ES6与ES5的一些困惑。  

## ES6的特性  

### 何为ES6？  
ES6全称ECMAScript 6.0，ES6于2015年6月17日发布，ECMAScript是ECMA制定的标准化脚本语言。目前JavaScript使用的ECMAScript版本为ECMAScript-262。  

下面我为大家列举了ES6新特性中对我们开发影响比较大的六方面的特性。  

### 1.类（class）

对熟悉Java，object-c，c#等纯面向对象语言的开发者来说，都会对class有一种特殊的情怀。ES6 引入了class（类），让JavaScript的面向对象编程变得更加简单和易于理解。  

```javascript
  class Animal {
    // 构造方法，实例化的时候将会被调用，如果不指定，那么会有一个不带参数的默认构造函数.
    constructor(name,color) {
      this.name = name;
      this.color = color;
    }
    // toString 是原型对象上的属性
    toString() {
      console.log('name:' + this.name + ',color:' + this.color);

    }
  }
   
 var animal = new Animal('dog','white');//实例化Animal
 animal.toString();

 console.log(animal.hasOwnProperty('name')); //true
 console.log(animal.hasOwnProperty('toString')); // false
 console.log(animal.__proto__.hasOwnProperty('toString')); // true

 class Cat extends Animal {
  constructor(action) {
    // 子类必须要在constructor中指定super 方法，否则在新建实例的时候会报错.
    // 如果没有置顶consructor,默认带super方法的constructor将会被添加、
    super('cat','white');
    this.action = action;
  }
  toString() {
    console.log(super.toString());
  }
 }

 var cat = new Cat('catch')
 cat.toString();
 
 // 实例cat 是 Cat 和 Animal 的实例，和Es5完全一致。
 console.log(cat instanceof Cat); // true
 console.log(cat instanceof Animal); // true
```

### 2.模块(Module) 
ES5不支持原生的模块化，在ES6中，模块将作为重要的组成部分被添加进来。模块的功能主要由 export 和 import 组成。每一个模块都有自己单独的作用域，模块之间的相互调用关系是通过 export 来规定模块对外暴露的接口，通过import来引用其它模块提供的接口。同时还为模块创造了命名空间，防止函数的命名冲突。   

#### 导出(export)    

ES6允许在一个模块中使用export来导出多个变量或方法。  

**导出变量**   

```javascript
//test.js
export var name = 'Rainbow'
```

>心得：ES6不仅支持变量的导出，也支持常量的导出。 `export const sqrt = Math.sqrt;//导出常量` 

ES6将一个文件视为一个模块，上面的模块通过 export 向外输出了一个变量。一个模块也可以同时往外面输出多个变量。  

```javascript
 //test.js
 var name = 'Rainbow';
 var age = '24';
 export {name, age};
```

**导出函数** 

```javascript
// myModule.js
export function myModule(someArg) {
  return someArg;
}  
```

#### 导入(import)    

定义好模块的输出以后就可以在另外一个模块通过import引用。

```javascript
import {myModule} from 'myModule';// main.js
import {name,age} from 'test';// test.js
``` 
  
>心得:一条import 语句可以同时导入默认方法和其它变量。`import defaultMethod, { otherMethod } from 'xxx.js';`



### 3.箭头（Arrow）函数
这是ES6中最令人激动的特性之一。`=>`不只是关键字function的简写，它还带来了其它好处。箭头函数与包围它的代码共享同一个`this`,能帮你很好的解决this的指向问题。有经验的JavaScript开发者都熟悉诸如`var self = this;`或`var that = this`这种引用外围this的模式。但借助`=>`，就不需要这种模式了。   

### 箭头函数的结构  
箭头函数的箭头=>之前是一个空括号、单个的参数名、或用括号括起的多个参数名，而箭头之后可以是一个表达式（作为函数的返回值），或者是用花括号括起的函数体（需要自行通过return来返回值，否则返回的是undefined）。

```javascript
// 箭头函数的例子
()=>1
v=>v+1
(a,b)=>a+b
()=>{
    alert("foo");
}
e=>{
    if (e == 0){
        return 0;
    }
    return 1000/e;
}
```

>心得：不论是箭头函数还是bind，每次被执行都返回的是一个新的函数引用，因此如果你还需要函数的引用去做一些别的事情（譬如卸载监听器），那么你必须自己保存这个引用。  

#### 卸载监听器时的陷阱

>**错误的做法**

```javascript
class PauseMenu extends React.Component{
    componentWillMount(){
        AppStateIOS.addEventListener('change', this.onAppPaused.bind(this));
    }
    componentWillUnmount(){
        AppStateIOS.removeEventListener('change', this.onAppPaused.bind(this));
    }
    onAppPaused(event){
    }
}
```

>**正确的做法**

```javascript
class PauseMenu extends React.Component{
    constructor(props){
        super(props);
        this._onAppPaused = this.onAppPaused.bind(this);
    }
    componentWillMount(){
        AppStateIOS.addEventListener('change', this._onAppPaused);
    }
    componentWillUnmount(){
        AppStateIOS.removeEventListener('change', this._onAppPaused);
    }
    onAppPaused(event){
    }
}
```

除上述的做法外，我们还可以这样做：

```javascript
class PauseMenu extends React.Component{
    componentWillMount(){
        AppStateIOS.addEventListener('change', this.onAppPaused);
    }
    componentWillUnmount(){
        AppStateIOS.removeEventListener('change', this.onAppPaused);
    }
    onAppPaused = (event) => {
        //把方法直接作为一个arrow function的属性来定义，初始化的时候就绑定好了this指针
    }
}
```

>需要注意的是：不论是bind还是箭头函数，每次被执行都返回的是一个新的函数引用，因此如果你还需要函数的引用去做一些别的事情（譬如卸载监听器），那么你必须自己保存这个引用。

### 4.ES6不再支持Mixins
在ES5下，我们经常使用mixin来为组件添加一些新的方法，如： 
  
```javascript
var SetIntervalMixin = {
  componentWillMount: function() {
    this.intervals = [];
  },
  setInterval: function() {
    this.intervals.push(setInterval.apply(null, arguments));
  },
  componentWillUnmount: function() {
    this.intervals.forEach(clearInterval);
  }
};
var TickTock = React.createClass({
  mixins: [SetIntervalMixin], // Use the mixin
  getInitialState: function() {
    return {seconds: 0};
  },
  ...
```

但，很不幸的是，ES6不支持使用Mixins了，不过我们可以使用，增强组件来替代Mixins。

```javascript
//Enhance.js
import { Component } from "React";

export var Enhance = ComposedComponent => class extends Component {
    constructor() {
        this.state = { data: null };
    }
    componentDidMount() {
        this.setState({ data: 'Hello' });
    }
    render() {
        return <ComposedComponent {...this.props} data={this.state.data} />;
    }
};
//HigherOrderComponent.js
import { Enhance } from "./Enhance";

class MyComponent {
    render() {
        if (!this.data) return <div>Waiting...</div>;
        return <div>{this.data}</div>;
    }
}

export default Enhance(MyComponent); // Enhanced component
```
用一个“增强组件”，来为某个类增加一些方法，并且返回一个新类，这无疑能实现mixin所实现的大部分需求。

另外，网上也有很多其他的方案，如[react-mixin](https://github.com/brigand/react-mixin)。


### 5.ES6不再有自动绑定  

在ES5中，React.createClass会把所有的方法都bind一遍，这样可以提交到任意的地方作为回调函数，而this不会变化。但在ES6中没有了自动绑定，也就是说，你需要通过bind或者箭头函数来手动绑定this引用。

```javascript
// 通过使用 bind() 来绑定`this`
<div onClick={this.tick.bind(this)}>
// 也可通过使用箭头函数来实现
<div onClick={() => this.tick()}>  
```
>心得： 因为无论是箭头函数还是bind()每次被执行都返回的是一个新的函数引用，所以，推荐大家在组件的构造函数中来绑定`this`。

>```javascript
constructor(props) {
  super(props);
  this.state = {count: props.initialCount};
  this.tick = this.tick.bind(this);//在构造函数中绑定`this`
}
// 使用
<div onClick={this.tick}>
```

### 6.static关键字

在ES6中我们可以通过static关键字来定义一个类函数。  

```javascript
class People {
    constructor(name) { //构造函数
          this.name = name;
    }
    sayName() {
          console.log(this.name);
    }
    static formatName(name) //将formatName定义为类方法
        return name[0].toUpperCase() + name.sustr(1).toLowerCase();
    }
}
```

```javascript
console.log(People.formatName("tom")); //使用类方法formatName
```



## ES6 VS ES5（ES6与ES5的区别）

新版本的React /React Native使用了ES6标准，下面就让我们一起了解一下基于ES6的React/React Native相比ES5有哪些不同。  

>心得：很多React/React Native的初学者经常会被ES6问题迷惑：官方建议我们ES6，但是网上搜到的很多教程和例子都是基于ES5版本的，所以很多人感觉无法下手，下面就让我们一起认识ES6与ES5在React/React Native开发上有哪些不同和需要注意的地方。
  
下面是我们需要知道的ES6与ES5在4大方面上的区别。
  
### 1.在定义方面的不同  

在定义组件，方法，属性等方面，ES6与ES5是有所不同的，下面就让我们一起看一下有哪些不同。    

>心得：因为向下兼容的原因，你在开发过程中可使用ES6也可以使用ES5的规范，但为了代码的风格一致性，建议尽量减少混写。  

#### 定义组件
      
>**ES5**  

在ES5里，通常通过React.createClass来定义一个组件类，像这样：

```javascript
var Photo = React.createClass({
    render: function() {
        return (
            <Image source={this.props.source} />
        );
    },
});
```

>**ES6**  

在ES6里，我们通过继承React.Component 来定义一个组件类，像这样：

```javascript
class Photo extends React.Component {
    render() {
        return (
            <Image source={this.props.source} />
        );
    }
}
```

#### 定义方法   
相比ES5，ES6在方法定义上语法更加简洁，从上面的例子里可以看到，给组件定义方法不再用 名字: function()的写法，而是直接用名字()，在方法的最后也不能有逗号了。

>**ES5**  

```javascript
var Photo = React.createClass({
    test: function(){
    },
    render: function() {
        return (
            <Image source={this.props.source} />
        );
    },
});
```

>**ES6**  

```javascript
class Photo extends React.Component {
    test() {
    }
    render() {
        return (
            <Image source={this.props.source} />
        );
    }
}
```

#### 定义组件的属性类型和默认属性

>**ES5**  

在ES5里，属性类型和默认属性分别通过propTypes成员和getDefaultProps方法来实现。  

```javascript
var Video = React.createClass({
    getDefaultProps: function() {
        return {
            autoPlay: false,
            maxLoops: 10,
        };
    },
    propTypes: {
        autoPlay: React.PropTypes.bool.isRequired,
        maxLoops: React.PropTypes.number.isRequired,
        posterFrameSrc: React.PropTypes.string.isRequired,
        videoSrc: React.PropTypes.string.isRequired,
    },
    render: function() {
        return (
            <View />
        );
    },
});
```

>**ES6**  
  
在ES6里，可以统一使用static成员来实现。

```javascript
class Video extends React.Component {
    static defaultProps = {
        autoPlay: false,
        maxLoops: 10,
    };  // 注意这里有分号
    static propTypes = {
        autoPlay: React.PropTypes.bool.isRequired,
        maxLoops: React.PropTypes.number.isRequired,
        posterFrameSrc: React.PropTypes.string.isRequired,
        videoSrc: React.PropTypes.string.isRequired,
    };  // 注意这里有分号
    render() {
        return (
            <View />
        );
    } // 注意这里既没有分号也没有逗号
}
```

也有人这么写，虽然不推荐，但读到代码的时候你应当能明白它的意思：

```javascript
class Video extends React.Component {
    render() {
        return (
            <View />
        );
    }
}
Video.defaultProps = {
    autoPlay: false,
    maxLoops: 10,
};
Video.propTypes = {
    autoPlay: React.PropTypes.bool.isRequired,
    maxLoops: React.PropTypes.number.isRequired,
    posterFrameSrc: React.PropTypes.string.isRequired,
    videoSrc: React.PropTypes.string.isRequired,
};
```

>心得:对React开发者而言，static在一些老版本的浏览器上是不支持的。React Native开发者可以不用担心这个问题。


### 2.在导入(import)与导出(export)组件上的不同  


#### 导入组件  

>**ES5**  

在ES5里，如果使用CommonJS标准，引入React包基本通过require进行，代码类似这样：

```javascript
var React = require("react");
var {
    Component,
    PropTypes
} = React;  //引用React抽象组件
```

```javascript
var ReactNative = require("react-native");
var {
    Image,
    Text,
} = ReactNative;  //引用具体的React Native组件
```

```javascript
var AboutPage=require('./app/AboutPage') //引入app目录下AboutPage组件，即AboutPag.js
var PopularPage=require('./app/PopularPage') //引入app目录下PopularPage组件，即PopularPage.js
var FavoritePage=require('./app/FavoritePage') //引入app目录下FavoritePage组件，即FavoritePage.js
```

>**ES6**  

在ES6里，没有了require，而是使用import来导入组件，有点像Java的写法。  

```javascript
import React, { 
    Component,
    PropTypes,
} from 'react';//引用React抽象组件
```

```javascript
import {
    Image,
    Text
} from 'react-native' //引用具体的React Native组件
```

```javascript
import AboutPage from './app/AboutPage' //引入app目录下AboutPage组件，即AboutPag.js
import PopularPage from './app/PopularPage' //引入app目录下PopularPage组件，即PopularPage.js
import FavoritePage  from './app/FavoritePage' //引入app目录下FavoritePage组件，即FavoritePage.js
```

另外，ES6支持将组件导入作为一个对象，使用“ * as”修饰即可。  

```javascript
//引入app目录下AboutPage组件作为一个对象，接下来就可使用“AboutPage.”来调用AboutPage的方法及属性了。  
import  * as AboutPage from './app/AboutPage' 
```

>心得：使用“ * as ”修饰后，导入的组件直接被实例化成一个对象，可以使用“.”语法来调用组件的方法和属性，和没有“ * as ”修饰是有本质区别的，使用的时候要特别注意。  

#### 导出组件  

>**ES5**  
在ES5里，要导出一个类给别的模块用，一般通过module.exports来导出：

```javascript
var MyComponent = React.createClass({
    ...
});
module.exports = MyComponent;
```

>**ES6**  
在ES6里，通常用export default来实现相同的功能：

```javascript
export default class MyComponent extends Component{
    ...
}
```


### 3.在初始化state上的不同   

>**ES5**  

```javascript
var Video = React.createClass({
    getInitialState: function() {
        return {
            loopsRemaining: this.props.maxLoops,
        };
    },
})
```

>**ES6**  
ES6下，有两种写法：

```javascript
class Video extends React.Component {
    state = {
        loopsRemaining: this.props.maxLoops,
    }
}
```

不过我们推荐更易理解的在构造函数中初始化（这样你还可以根据需要做一些计算）：

```javascript
class Video extends React.Component {
    constructor(props){
        super(props);
        this.state = {
            loopsRemaining: this.props.maxLoops,
        };
    }
}
```

### 4.在方法作为回调上的不同   
在开发工作中，经常会使用到回调，如按钮的单击回调等，这也是在很多编程语言中都会经常出现的情况。ES6与ES5在使用回调方面是有区别的。   

>**ES5**  

```javascript
var PostInfo = React.createClass({
    handleOptionsButtonClick: function(e) {
        // Here, 'this' refers to the component instance.
        this.setState({showOptionsModal: true});
    },
    render: function(){
        return (
            <TouchableHighlight onPress={this.handleOptionsButtonClick}>
                <Text>{this.props.label}</Text>
            </TouchableHighlight>
        )
    },
});
```
在ES5中，React.createClass会把所有的方法都bind一遍，这样可以提交到任意的地方作为回调函数，而this不会变化。但官方现在逐步认为这反而是不标准、不易理解的。

在ES6下，你需要通过bind来绑定this引用，或者使用箭头函数（它会绑定当前scope的this引用）：  


>**ES6**  

```javascript
class PostInfo extends React.Component{
    handleOptionsButtonClick(e){
        this.setState({showOptionsModal: true});
    }
    render(){
        return (
            <TouchableHighlight 
                onPress={this.handleOptionsButtonClick.bind(this)}
                //onPress={e=>this.handleOptionsButtonClick(e)}//这种方式和上面的效果是一样的
                >
                <Text>{this.props.label}</Text>
            </TouchableHighlight>
        )
    },·
}
```
               
## 参考  
[React's official site](https://facebook.github.io/react/)  
[React on ES6+](https://babeljs.io/blog/2015/06/07/react-on-es6-plus)

## About
本文出自[《React Native学习笔记》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。    
了解更多，可以[关注我的GitHub](https://github.com/crazycodeboy/)   
@[http://jiapenghui.com](http://jiapenghui.com)  

推荐阅读
----
* [React Native 学习笔记](https://github.com/crazycodeboy/RNStudyNotes)   
* [Reac Native布局详细指南](https://github.com/crazycodeboy/RNStudyNotes/tree/master/React Native布局/React Native布局详细指南/React Native布局详细指南.md)   
* [React Native调试技巧与心得](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E8%B0%83%E8%AF%95%E6%8A%80%E5%B7%A7%E4%B8%8E%E5%BF%83%E5%BE%97/React%20Native%E8%B0%83%E8%AF%95%E6%8A%80%E5%B7%A7%E4%B8%8E%E5%BF%83%E5%BE%97.md)
*  [React Native发布APP之签名打包APK](https://github.com/crazycodeboy/RNStudyNotes/tree/master/React%20Native%E5%8F%91%E5%B8%83APP%E4%B9%8B%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85APK)    
*  [React Native应用部署、热更新-CodePush最新集成总结](https://github.com/crazycodeboy/RNStudyNotes/tree/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93)
