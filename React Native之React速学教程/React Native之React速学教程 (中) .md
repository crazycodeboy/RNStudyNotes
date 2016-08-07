# React Native之React速学教程(中) 

本文出自[《React Native学习笔记》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。

React Native是基于React的，在开发React Native过程中少不了的需要用到React方面的知识。虽然官方也有相应的Document，但篇幅比较多，学起来比较枯燥。
通过《React Native之React速学教程》你可以对React有更系统和更深入的认识。为了方便大家学习，我将《React Native之React速学教程》分为[上](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%8A\).md)、[中](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%AD\)%20.md)、[下](https://github.com/crazycodeboy/RNStudyNotes/blob/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B%20\(%E4%B8%8B\).md)三篇，大家可以根据需要进行阅读学习。  

## 概述

本篇为《React Native之React速学教程》的第二篇。本篇将从组件(Component)的详细说明、组件的生命周期(Component Lifecycle)、isMounted是个反模式等方面进行讲解，让大家对组件(Component)有个更系统以及更深入的认识。  



## 组件的详细说明  
当通过调用 React.createClass() 来创建组件的时候，每个组件必须提供render方法，并且也可以包含其它的在这里描述的生命周期方法。  

### render
`ReactComponent render()`   
`render()` 方法是必须的。  
当该方法被回调的时候，会检测 `this.props` 和 `this.state`，并返回一个单子级组件。该子级组件可以是虚拟的本地 DOM 组件（比如 \<div /> 或者 `React.DOM.div()`），也可以是自定义的复合组件。  
你也可以返回 `null` 或者 `false` 来表明不需要渲染任何东西。实际上，React 渲染一个`<noscript> `标签来处理当前的差异检查逻辑。当返回 `null` 或者 `false` 的时候，`this.getDOMNode()` 将返回 `null`。   

**注意：**  

`render() `函数应该是纯粹的，也就是说该函数不修改组件的 `state`，每次调用都返回相同的结果，不读写 DOM 信息，也不和浏览器交互（例如通过使用 `setTimeout`）。如果需要和浏览器交互，在 `componentDidMount()` 中或者其它生命周期方法中做这件事。保持 `render()` 纯粹，可以使服务器端渲染更加切实可行，也使组件更容易被理解。  


>心得：不要在`render()`函数中做复杂的操作，更不要进行网络请求，数据库读写，I/O等操作。


### getInitialState
`object getInitialState()`
初始化组件状态，在组件挂载之前调用一次。返回值将会作为 `this.state `的初始值。  

>心得：通常在该方法中对组件的状态进行初始化。  


### getDefaultProps
`object getDefaultProps()`  
设置组件属性的默认值，在组件类创建的时候调用一次，然后返回值被缓存下来。如果父组件没有指定 `props` 中的某个键，则此处返回的对象中的相应属性将会合并到 `this.props` （使用 in 检测属性）。     
**Usage:**  

```
getDefaultProps() {
    return {
      title: '',
      popEnabled:true
    };
  },
```
**注意**  
该方法在任何实例创建之前调用，因此不能依赖于 `this.props`。另外，`getDefaultProps()` 返回的任何复杂对象将会在实例间共享，而不是每个实例拥有一份拷贝。  

>心得：该方法在你封装一个自定义组件的时候经常用到，通常用于为组件初始化默认属性。   



### [PropTypes](https://facebook.github.io/react/docs/top-level-api.html#react.proptypes) 
`object propTypes`  
`propTypes` 对象用于验证传入到组件的 `props`。  可参考[可重用的组件](https://facebook.github.io/react/docs/reusable-components.html)。

**Usage:**   

```html
var NavigationBar=React.createClass({
  propTypes: {
    navigator:React.PropTypes.object,
    leftButtonTitle: React.PropTypes.string,
    leftButtonIcon: Image.propTypes.source,
    popEnabled:React.PropTypes.bool,
    onLeftButtonClick: React.PropTypes.func,
    title:React.PropTypes.string,
    rightButtonTitle: React.PropTypes.string,
    rightButtonIcon:Image.propTypes.source,
    onRightButtonClick:React.PropTypes.func
  },
```

>心得：在封装组件时，对组件的属性通常会有类型限制，如：组件的背景图片，需要`Image.propTypes.source`类型，propTypes便可以帮你完成你需要的属性类型的检查。

### mixins
`array mixins`  
`mixin` 数组允许使用混合来在多个组件之间共享行为。更多关于混合的信息，可参考[Reusable Components](https://facebook.github.io/react/docs/reusable-components.html#mixins)。  

>心得：由于ES6不再支持mixins，所以不建议在使用mixins，我们可以用另外一种方式来替代mixins，请参考：[React Native之React速学教程(下)-ES6不再支持Mixins]()。

### statics

`object statics`  
`statics` 对象允许你定义静态的方法，这些静态的方法可以在组件类上调用。例如：

```html
var MyComponent = React.createClass({
  statics: {
    customMethod: function(foo) {
      return foo === 'bar';
    }
  },
  render: function() {
  }
});
MyComponent.customMethod('bar');  // true
```

在这个块儿里面定义的方法都是静态的，你可以通过`ClassName.funcationName`的形式调用它。  
**注意**  
这些方法不能获取组件的 `props` 和 `state`。如果你想在静态方法中检查 `props` 的值，在调用处把 `props` 作为参数传入到静态方法。

### displayName
`string displayName`  
`displayName` 字符串用于输出调试信息。JSX 自动设置该值；可参考[JSX in Depth](https://facebook.github.io/react/docs/jsx-in-depth.html#the-transform)。

#### isMounted

`boolean isMounted()`，当组件被渲染到DOM，该方法返回true，否则返回false。该方法通常用于异步任务完成后修改state前的检查，以避免修改一个没有被渲染的组件的state。   

>心得：开发中不建议大家isMounted，大家可以使用另外一种更好的方式来避免修改没有被渲染的DOM，请下文的[isMounted 是个反模式]()。

## [组件的生命周期(Component Lifecycle)](https://facebook.github.io/react/docs/working-with-the-browser.html#component-lifecycle)

在iOS中`UIViewController`提供了`(void)viewWillAppear:(BOOL)animated`, `- (void)viewDidLoad`,`(void)viewWillDisappear:(BOOL)animated`等生命周期方法，在Android中`Activity`则提供了` onCreate()`,`onStart()`,`onResume()	`,`onPause()`,`onStop()`,`onDestroy()`等生命周期方法，这些生命周期方法展示了一个界面从创建到销毁的一生。  

那么在React 中组件(Component)也是有自己的生命周期方法的。  

![component-lifecycle](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E4%B9%8BReact%E9%80%9F%E5%AD%A6%E6%95%99%E7%A8%8B/images/component-lifecycle.jpg)

### 组件的生命周期分成三个状态：  

- Mounting：已插入真实 DOM
- Updating：正在被重新渲染
- Unmounting：已移出真实 DOM

> 心得：你会发现这些React 中组件(Component)的生命周期方法从写法上和iOS中`UIViewController`的生命周期方法很像，React 为每个状态都提供了两种处理函数，will 函数在进入状态之前调用，did 函数在进入状态之后调用。  

### Mounting(装载)

- `getInitialState()`: 在组件挂载之前调用一次。返回值将会作为 this.state 的初始值。
- `componentWillMount()`：服务器端和客户端都只调用一次，在初始化渲染执行之前立刻调用。
- `componentDidMount()`：在初始化渲染执行之后立刻调用一次，仅客户端有效（服务器端不会调用）。

### Updating (更新)

- componentWillReceiveProps(object nextProps) 在组件接收到新的 props 的时候调用。在初始化渲染的时候，该方法不会调用。

用此函数可以作为 react 在 prop 传入之后， render() 渲染之前更新 state 的机会。老的 props 可以通过 this.props 获取到。在该函数中调用 this.setState() 将不会引起第二次渲染。

- shouldComponentUpdate(object nextProps, object nextState): 在接收到新的 props 或者 state，将要渲染之前调用。

该方法在初始化渲染的时候不会调用，在使用 forceUpdate 方法的时候也不会。如果确定新的 props 和 state 不会导致组件更新，则此处应该 返回 false。   

>心得：重写次方你可以根据实际情况，来灵活的控制组件当 props 和 state 发生变化时是否要重新渲染组件。   


- componentWillUpdate(object nextProps, object nextState)：在接收到新的 props 或者 state 之前立刻调用。

在初始化渲染的时候该方法不会被调用。使用该方法做一些更新之前的准备工作。   
>注意：你不能在该方法中使用 this.setState()。如果需要更新 state 来响应某个 prop 的改变，请使用 `componentWillReceiveProps`。

- componentDidUpdate(object prevProps, object prevState): 在组件的更新已经同步到 DOM 中之后立刻被调用。

该方法不会在初始化渲染的时候调用。使用该方法可以在组件更新之后操作 DOM 元素。

### Unmounting(移除) 

- componentWillUnmount：在组件从 DOM 中移除的时候立刻被调用。

在该方法中执行任何必要的清理，比如无效的定时器，或者清除在 componentDidMount 中创建的 DOM 元素。

## isMounted是个反模式

isMounted通常用于避免修改一个已经被卸载的组件的状态，因为调用一个没有被装载的组件的`setState()`方法，系统会抛出异常警告。  

```javascript
if(this.isMounted()) { //不推荐
  this.setState({...});
}
```

上面做法有点反模式，`isMounted()`起到作用的时候也就是组件被卸载之后还有异步操作在进行的时候，这就意味着一个被销毁的组件还持有着一些资源的引用，这会导致系统性能降低甚至内存溢出。      


React 在设计的时候通过`setState()`被调用时做了一些检查，来帮助开发者发现被卸载的组件还持有一些资源的引用的情况。如何你使用了`isMounted()`，也就是跳过的React的检查，也就无法发现被卸载的组件还持有资源的问题。       


既然isMounted()是反模式，那么有没有可替代方案呢？    
我们可以通过在设置一个变量来表示组件的装载和卸载的状态，当`componentDidMount`被调用时该变量为true，当
`componentWillUnmount`被调用时，该变量为false，这样该变量就可以当`isMounted()`来使用。但还不够，到目前为止，我们只是通过变量来替代`isMounted()`，还没有做任何的优化，接下来我们需要在`componentWillUnmount`被调用时取消所有的异步回调，主动释放所有资源，这样就能避免被卸载的组件还持有资源的引用的情况，从而减少了内存溢出等情况的发生。   

```javascript
class MyComponent extends React.Component {
  componentDidMount() {
    mydatastore.subscribe(this);
  }
  render() {
    ...
  }
  componentWillUnmount() {
    mydatastore.unsubscribe(this);
  }
}
```
使用可取消的Promise做异步操作。  


```javascript
const cancelablePromise = makeCancelable(
  new Promise(r => component.setState({...}}))
);
cancelablePromise
  .promise
  .then(() => console.log('resolved'))
  .catch((reason) => console.log('isCanceled', reason.isCanceled));
cancelablePromise.cancel(); // Cancel the promise
```

可取消的Promise。

```javascript
const makeCancelable = (promise) => {
  let hasCanceled_ = false;
  const wrappedPromise = new Promise((resolve, reject) => {
    promise.then((val) =>
      hasCanceled_ ? reject({isCanceled: true}) : resolve(val)
    );
    promise.catch((error) =>
      hasCanceled_ ? reject({isCanceled: true}) : reject(error)
    );
  });
  return {
    promise: wrappedPromise,
    cancel() {
      hasCanceled_ = true;
    },
  };
};
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
