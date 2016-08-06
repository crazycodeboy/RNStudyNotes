# React Native之React速学教程(下) 

------
分上下两篇：

结构： 

## ES6 VS ES5

新版本的React /React Native使用了ES6标准，下面就让我们一起了解一下基于ES6的React/React Native相比ES5有哪些不同。  

>心得：很多React/React Native的初学者经常会被ES6问题迷惑：官方建议我们ES6，但是网上搜到的很多教程和例子都是基于ES5版本的，所以很多人感觉无法下手，下面就让我们一起认识ES6与ES5在React/React Native开发上有哪些不同和需要注意的地方。

### 何为ES6？  
ES6全称ECMAScript 6.0，ES6于2015年6月17日发布，ECMAScript是ECMA制定的标准化脚本语言。目前JavaScript使用的ECMAScript版本为ECMAScript-262。    

### 在定义方面的不同  

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

在ES6里，我们通过定义一个继承自React.Component的class来定义一个组件类，像这样：

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

##### ES5

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

##### ES6  

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

##### ES5
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

##### ES6  
  
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


### 在导入(import)与导出(export)组件上的不同  
@https://segmentfault.com/a/1190000002904199
@http://bbs.reactnative.cn/topic/15/react-react-native-%E7%9A%84es5-es6%E5%86%99%E6%B3%95%E5%AF%B9%E7%85%A7%E8%A1%A8
#### 导入组件  
在ES5里，如果使用CommonJS标准，引入React包基本通过require进行，代码类似这样：


#### ES5


#### ES6  


### 类（class）
@https://segmentfault.com/a/1190000002904199

### 箭头（Arrow）


## 使用高阶组件替代Mixins


## [isMounted is an Antipattern](https://facebook.github.io/react/blog/2015/12/16/ismounted-antipattern.html)
-------





## ES6 Classes




## ES5 VS ES6


### [isMounted is an Antipattern](https://facebook.github.io/react/blog/2015/12/16/ismounted-antipattern.html)

## 技巧

### ES6的箭头函数  
()=>{}
### 函数也可以这样写
test(){
}
vs
test:function(){
}

 
## React in React Native 

### 创建组件的两种方式

## 参考  


##  About

---





## 使用React 






@[React's official site](https://facebook.github.io/react/)  
@[React 中文网](http://reactjs.cn/react/index.html)  
