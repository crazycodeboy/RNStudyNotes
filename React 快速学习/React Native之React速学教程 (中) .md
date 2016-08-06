# React Native之React速学教程(中) 

------
分上下两篇：

结构： 


## [Component Lifecycle]
### 组件的详细说明  
#### render
#### getInitialState
#### getDefaultProps
#### [PropTypes]
#### mixins
#### statics
#### displayName

### 组件的生命周期
#### 组件的生命周期分成三个状态：  
#### Mounting(装载)
#### Updating (更新)
#### Unmounting(移除)

-------



## 组件的详细说明  
当通过调用 React.createClass() 来创建组件的时候，每个组件必须提供render方法，并且也可以包含其它的在这里描述的生命周期方法。  

### render
`ReactComponent render()`   
`render()` 方法是必须的。  
当该方法被回调的时候，会检测 `this.props` 和 `this.state`，并返回一个单子级组件。该子级组件可以是虚拟的本地 DOM 组件（比如 <div /> 或者 `React.DOM.div()`），也可以是自定义的复合组件。  
你也可以返回 `null` 或者 `false` 来表明不需要渲染任何东西。实际上，React 渲染一个`<noscript> `标签来处理当前的差异检查逻辑。当返回 `null` 或者 `false` 的时候，`this.getDOMNode()` 将返回 `null`。   

**注意：**  

`render() `函数应该是纯粹的，也就是说该函数不修改组件 `state`，每次调用都返回相同的结果，不读写 DOM 信息，也不和浏览器交互（例如通过使用 `setTimeout`）。如果需要和浏览器交互，在 `componentDidMount()` 中或者其它生命周期方法中做这件事。保持 `render()` 纯粹，可以使服务器端渲染更加切实可行，也使组件更容易被理解。  


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
`propTypes` 对象用于验证传入到组件的 `props`。  更多关于混合的信息，可参考[可重用的组件](https://facebook.github.io/react/docs/reusable-components.html)。

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
`mixin` 数组允许使用混合来在多个组件之间共享行为。更多关于混合的信息，参考[可重用的组件](https://facebook.github.io/react/docs/reusable-components.html#mixins)。  

>心得：由于ES6不再支持mixins，所以不建议在使用mixins，我们可以用另外一种方式来替代mixins，请参考：[使用高阶组件替代Mixins]()。

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
`displayName` 字符串用于输出调试信息。JSX 自动设置该值；[参考JSX 深入](https://facebook.github.io/react/docs/jsx-in-depth.html#the-transform)。

## [组件的生命周期(Component Lifecycle)](https://facebook.github.io/react/docs/working-with-the-browser.html#component-lifecycle)

在iOS中`UIViewController`提供了`(void)viewWillAppear:(BOOL)animated`, `- (void)viewDidLoad`,`(void)viewWillDisappear:(BOOL)animated`等生命周期方法，在Android中`Activity`则提供了` onCreate()`,`onStart()`,`onResume()	`,`onPause()`,`onStop()`,`onDestroy()`等生命周期方法，这些生命周期方法展示了一个界面从创建到销毁的一生。  

那么在React 中组件(Component)也是有自己的生命周期方法的。  

![component-lifecycle](/Users/penn/Documents/RNStudyNotes/React 快速学习/images/component-lifecycle.jpg)

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
