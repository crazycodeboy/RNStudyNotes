# React Native之React速学教程(上)
本文出自[《React Native学习笔记》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。

React Native是基于React的，在开发React Native过程中少不了的需要用到React方面的知识。虽然官方也有相应的Document，但篇幅比较多，学起来比较枯燥。
通过《React Native之React速学教程》你可以对React有更系统和更深入的认识。为了方便大家学习，我将《React Native之React速学教程》分为[上](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%8A\).md)、[中](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%AD\)%20.md)、[下](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%8B\).md)三篇，大家可以根据需要进行阅读学习。  

## 概述

本篇为《React Native之React速学教程》的第一篇。本篇将从React的特点、如何使用React、JSX语法、组件(Component）以及组件的属性，状态等方面进行讲解。  


## What's React 
React是一个用于组建用户界面的JavaScript库，让你以更简单的方式来创建交互式用户界面。    

1. 当数据改变时，React将高效的更新和渲染需要更新的组件。声明性视图使你的代码更可预测，更容易调试。
2. 构建封装管理自己的状态的组件，然后将它们组装成复杂的用户界面。由于组件逻辑是用JavaScript编写的，而不是模板，所以你可以轻松地通过您的应用程序传递丰富的数据，并保持DOM状态。
3. 一次学习随处可写，学习React，你不仅可以将它用于Web开发，也可以用于React Native来开发Android和iOS应用。  

不是模板却比模板更加灵活：  

![Component](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/images/Component.jpg)  

>心得：上图是[GitHub Popular](https://github.com/crazycodeboy/GitHubPopular)的首页截图，这个页面是通过不同的组件组装而成的，组件化的开发模式，使得代码在更大程度上的到复用，而且组件之间对的组装很灵活。  


## Get Started

使用React之前需要在页面引入如下js库 。  
- react.js  
- react-dom.js  
- browser.min.js  

上面一共列举了三个库： react.js 、react-dom.js 和 browser.min.js ，它们必须首先加载。其中，react.js 是 React 的核心库，react-dom.js 是提供与 DOM 相关的功能，browser.min.js 的作用是将 JSX 语法转为 JavaScript 语法，这一步很消耗时间，实际上线的时候，应该将它放到服务器完成。  
你可以从[React官网](https://facebook.github.io/react/downloads.html)下载这些库，也可以将其下载到本地去使用。 

>心得：在做React Native开发时，这些库作为React Native核心库已经被初始化在node_modules目录下，所以不需要单独下载。  

### 使用React 
解压从上述地址下载的压缩包，在根目录中创建一个包含以下内容的 “helloworld.html” 。  

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Hello React!</title>
    <script src="build/react.js"></script>
    <script src="build/react-dom.js"></script>
    <script src="https://npmcdn.com/babel-core@5.8.38/browser.min.js"></script>
  </head>
  <body>
    <div id="example"></div>
    <script type="text/babel">
      ReactDOM.render(
        <h1>Hello, world!</h1>,
        document.getElementById('example')
      );
    </script>
  </body>
</html>
```

在 JavaScript 代码里写着 XML 格式的代码称为 JSX，下文会介绍。为了把 JSX 转成标准的 JavaScript，我们用`<script type="text/babel">`标签，然后通过Babel转换成在浏览器中真正执行的内容。  

### ReactDOM.render()
ReactDOM.render 是 React 的最基本方法，用于将模板转为 HTML 语言，并插入指定的 DOM 节点。
```html
ReactDOM.render(
  <h1>Hello, world!</h1>,
  document.getElementById('example')
);
```  
上述代码的作用是将`<h1>Hello, world!</h1>`插入到元素id为example的容器中。   


## JSX  
JSX 是一个看起来很像 XML 的 JavaScript 语法扩展。
每一个XML标签都会被JSX转换工具转换成纯JavaScript代码，使用JSX，组件的结构和组件之间的关系看上去更加清晰。  
JSX并不是React必须使用的，但React官方建议我们使用 JSX , 因为它能定义简洁且我们熟知的包含属性的树状结构语法。 
    

**Usage:**  
  
```html 
React.render(//使用JSX
    <div>
        <div>
            <div>content</div>
        </div>
    </div>,
    document.getElementById('example')
); 
React.render(//不使用JSX
    React.createElement('div', null,
        React.createElement('div', null,
            React.createElement('div', null, 'content')
        )
    ),
    document.getElementById('example')
);
```   

### HTML标签 与 React组件 对比

React 可以渲染 HTML 标签 (strings) 或 React 组件 (classes)。   
要渲染 HTML 标签，只需在 JSX 里使用小写字母开头的标签名。

```html 
var myDivElement = <div className="foo" />;
React.render(myDivElement, document.body);
```

要渲染 React 组件，只需创建一个大写字母开头的本地变量。

```html 
var MyComponent = React.createClass({/*...*/});
var myElement = <MyComponent someProperty={true} />;
React.render(myElement, document.body);
```

>提示：    
>- React 的 JSX 里约定分别使用首字母大、小写来区分本地组件的类和 HTML 标签。    
>- 由于 JSX 就是 JavaScript，一些标识符像 class 和 for 不建议作为 XML 属性名。作为替代，  React DOM 使用 className 和 htmlFor 来做对应的属性。  

### JavaScript 表达式

#### 属性表达式
要使用 JavaScript 表达式作为属性值，只需把这个表达式用一对大括号 ({}) 包起来，不要用引号 ("")。

```html
// 输入 (JSX):
var person = <Person name={window.isLoggedIn ? window.name : ''} />;
// 输出 (JS):
var person = React.createElement(
  Person,
  {name: window.isLoggedIn ? window.name : ''}
);
```
#### 子节点表达式
同样地，JavaScript 表达式可用于描述子结点：

```html
// 输入 (JSX):
var content = <Container>{window.isLoggedIn ? <Nav /> : <Login />}</Container>;
// 输出 (JS):
var content = React.createElement(
  Container,
  null,
  window.isLoggedIn ? React.createElement(Nav) : React.createElement(Login)
);
```

### 注释
JSX 里添加注释很容易；它们只是 JS 表达式而已。你只需要在一个标签的子节点内(非最外层)用 {} 包围要注释的部分。

```html
class ReactDemo extends Component {
  render() {
    return (     
      <View style={styles.container}>
        {/*标签子节点的注释*/}
        <Text style={styles.welcome}
          //textAlign='right'
          textShadowColor='yellow'
          /*color='red'
          textShadowRadius='1'*/
          >
          React Native!
        </Text>
      </View>
    );
  }
}
```

>心得：在标签节点以外注释，和通常的注释是一样的，多行用“/**/” 单行用“//”；

### JSX延展属性  

#### 不要试图去修改组件的属性  
不推荐做法：   

```html
  var component = <Component />;
  component.props.foo = x; // 不推荐
  component.props.bar = y; // 不推荐
```

这样修改组件的属性，会导致React不会对组件的属性类型（propTypes）进行的检查。从而引发一些预料之外的问题。

推荐做法：  

```html
var component = <Component foo={x} bar={y} />;
```


#### 延展属性（Spread Attributes）

你可以使用 JSX 的新特性 - 延展属性：  

```html
  var props = {};
  props.foo = x;
  props.bar = y;
  var component = <Component {...props} />;
```

传入对象的属性会被复制到组件内。

它能被多次使用，也可以和其它属性一起用。注意顺序很重要，后面的会覆盖掉前面的。

```html
  var props = { foo: 'default' };
  var component = <Component {...props} foo={'override'} />;
  console.log(component.props.foo); // 'override'
```

上文出现的... 标记被叫做延展操作符（spread operator）已经被 ES6 数组 支持。


## Component  
React 允许将代码封装成组件（component），然后像插入普通 HTML 标签一样，在网页中插入这个组件。 

```html
var HelloMessage = React.createClass({
  render: function() {
    return <h1>Hello {this.props.name}</h1>;
  }
});
ReactDOM.render(
  <HelloMessage name="John" />,
  document.getElementById('example')
);
```
上面代码中，变量 HelloMessage 就是一个组件类。模板插入 `<HelloMessage /> `时，会自动生成 HelloMessage 的一个实例。所有组件类都必须有自己的 render 方法，用于输出组件。

>注意 

- 组件类的第一个字母必须大写。
- 组件类只能包含一个顶层标签。  

 
## 组件的属性(props)  
我们可以通过`this.props.xx`的形式获取组件对象的属性，对象的属性可以任意定义，但要避免与JavaScript关键字冲突。  

### 遍历对象的属性： 
`this.props.children`会返回组件对象的所有属性。  
React 提供一个工具方法 React.Children 来处理 this.props.children 。我们可以用 `React.Children.map`或`React.Children.forEach` 来遍历子节点。   
**React.Children.map**  

```html
array React.Children.map(object children, function fn [, object thisArg])
```     
该方法会返回一个array。  
**React.Children.forEach**    

```html
React.Children.forEach(object children, function fn [, object thisArg])
```  
**Usage：**  

```html
var NotesList = React.createClass({
  render: function() {
    return (
      <ol>
      {
        React.Children.map(this.props.children, function (child) {
          return <li>{child}</li>;
        })
      }
      </ol>
    );
  }
});
ReactDOM.render(
  <NotesList>
    <span>hello</span>
    <span>world</span>
  </NotesList>,
  document.body
);
```

### [PropTypes](https://facebook.github.io/react/docs/top-level-api.html#react.proptypes)  
组件的属性可以接受任意值，字符串、对象、函数等等都可以。有时，我们需要一种机制，验证别人使用组件时，提供的参数是否符合要求。  
组件类的PropTypes属性，就是用来验证组件实例的属性是否符合要求。

```html
var MyTitle = React.createClass({
  propTypes: {
    title: React.PropTypes.string.isRequired,
  },
  render: function() {
     return <h1> {this.props.title} </h1>;
   }
});
```
上面的Mytitle组件有一个title属性。PropTypes 告诉 React，这个 title 属性是必须的，而且它的值必须是字符串。现在，我们设置 title 属性的值是一个数值。

```html
var data = 123;
ReactDOM.render(
  <MyTitle title={data} />,
  document.body
);
```

这样一来，title属性就通不过验证了。控制台会显示一行错误信息。

```Warning: Failed propType: Invalid prop `title` of type `number` supplied to `MyTitle`, expected `string`.```  

更多的PropTypes设置，可以查看[官方文档](https://facebook.github.io/react/docs/reusable-components.html)。  
此外，getDefaultProps 方法可以用来设置组件属性的默认值。

```html
var MyTitle = React.createClass({
  getDefaultProps : function () {
    return {
      title : 'Hello World'
    };
  },
  render: function() {
     return <h1> {this.props.title} </h1>;
   }
});
ReactDOM.render(
  <MyTitle />,
  document.body
);
```
上面代码会输出`"Hello World"`。   


## ref 属性(获取真实的DOM节点)
组件并不是真实的 DOM 节点，而是存在于内存之中的一种数据结构，叫做虚拟 DOM （virtual DOM）。只有当它插入文档以后，才会变成真实的 DOM 。根据 React 的设计，所有的 DOM 变动，都先在虚拟 DOM 上发生，然后再将实际发生变动的部分，反映在真实 DOM上，这种算法叫做 DOM diff ，它可以极大提高网页的性能表现。

但是，有时需要从组件获取真实 DOM 的节点，这时就要用到 ref 属性。  

```html
var MyComponent = React.createClass({
  handleClick: function() {
    this.refs.myTextInput.focus();
  },
  render: function() {
    return (
      <div>
        <input type="text" ref="myTextInput" />
        <input type="button" value="Focus the text input" 		  onClick={this.handleClick} />
      </div>
    );
  }
});
ReactDOM.render(
  <MyComponent />,
  document.getElementById('example')
);
```

上面代码中，组件 MyComponent 的子节点有一个文本输入框，用于获取用户的输入。这时就必须获取真实的 DOM 节点，虚拟 DOM 是拿不到用户输入的。为了做到这一点，文本输入框必须有一个 ref 属性，然后 this.refs.[refName] 就会返回这个真实的 DOM 节点。  
需要注意的是，由于 this.refs.[refName] 属性获取的是真实 DOM ，所以必须等到虚拟 DOM 插入文档以后，才能使用这个属性，否则会报错。上面代码中，通过为组件指定 Click 事件的回调函数，确保了只有等到真实 DOM 发生 Click 事件之后，才会读取 this.refs.[refName] 属性。  
React 组件支持很多事件，除了 Click 事件以外，还有 KeyDown 、Copy、Scroll 等，完整的事件清单请查看[官方文档](https://facebook.github.io/react/docs/events.html#supported-events)。

### ref属性不只是string  
ref属性不仅接受string类型的参数，而且它还接受一个function作为callback。这一特性让开发者对ref的使用更加灵活。   
     

```javascript
 render: function() {
    return (
      <TextInput
        ref={function(input) {
          if (input != null) {
            input.focus();
          }
        }} />
    );
  },
```   
在ES6中我们可以使用箭头函数来为组件的ref设置一个callback。  

```javascript
  render() {
    return <TextInput ref={(c) => this._input = c} />;
  },
  componentDidMount() {
    this._input.focus();
  },
```
需要提醒大家的是，只有在组件的render方法被调用时，ref才会被调用，组件才会返回ref。如果你在调用this.refs.xx时render方法还没被调用，那么你得到的是undefined。

>心得：ref属性在开发中使用频率很高，使用它你可以获取到任何你想要获取的组件的对象，有个这个对象你就可以灵活地做很多事情，比如：读写对象的变量，甚至调用对象的函数。  


## state
上文讲到了props，因为每个组件只会根据props 渲染了自己一次，props 是不可变的。为了实现交互，可以使用组件的 state 。this.state 是组件私有的，可以通过`getInitialState()`方法初始化，通过调用 `this.setState()` 来改变它。当 state 更新之后，组件就会重新渲染自己。    
render() 方法依赖于 this.props 和 this.state ，框架会确保渲染出来的 UI 界面总是与输入（ this.props 和 this.state ）保持一致。

### 初始化state   
通过`getInitialState() `方法初始化state，在组件的生命周期中仅执行一次，用于设置组件的初始化 state 。
```html
 getInitialState:function(){
    return {favorite:false};
  }
```

### 更新 state 
通过`this.setState()`方法来更新state，调用该方法后，React会重新渲染相关的UI。  
`this.setState({favorite:!this.state.favorite});`

**Usage:**  
  
```html
var FavoriteButton=React.createClass({
  getInitialState:function(){
    return {favorite:false};
  },
  handleClick:function(event){
    this.setState({favorite:!this.state.favorite});
  },
  render:function(){
    var text=this.state.favorite? 'favorite':'un favorite';
    return (
      <div type='button' onClick={this.handleClick}>
        You {text} this. Click to toggle.
      </div>
    );
  }
});
```
上面代码是一个 FavoriteButton 组件，它的 getInitialState 方法用于定义初始状态，也就是一个对象，这个对象可以通过 this.state 属性读取。当用户点击组件，导致状态变化，this.setState 方法就修改状态值，每次修改以后，自动调用 this.render 方法，再次渲染组件。  

>心得：由于 this.props 和 this.state 都用于描述组件的特性，可能会产生混淆。一个简单的区分方法是，this.props 表示那些一旦定义，就不再改变的特性，而 this.state 是会随着用户互动而产生变化的特性。

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



