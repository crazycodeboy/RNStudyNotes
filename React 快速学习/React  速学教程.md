# React Native之React速学教程 

------
结构：  
## What's React 


## Get Started
### 使用React 
### ReactDOM.render()


## JSX 
### HTML标签 与 React组件 对比

### JavaScript 表达式
#### 属性表达式
#### 子节点表达式

### 注释

### JSX延展属性  
#### 不要试图去修改组件的属性  
#### 延展属性（Spread Attributes）


## Component  


## 组件的属性(props)  
### [遍历对象的属性]


## Reactive state
### 初始化state 
### 更新 state 


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




## What's React 
React是一个用于组建用户界面的JavaScript库，让你以更简单的方式来创建交互式用户界面。    

1. 当数据改变时，React将高效的更新和渲染需要更新的组件。声明性视图使你的代码更可预测，更容易调试。
2. 构建封装管理自己的状态的组件，然后将它们组装成复杂的用户界面。由于组件逻辑是用JavaScript编写的，而不是模板，所以你可以轻松地通过您的应用程序传递丰富的数据，并保持DOM状态。
3. 一次学习随处可写，学习React，你不仅可以将它用于Web开发，也可以用于React Native来开发Android和iOS应用。  


## Get Started

使用React之前需要在页面引入如下js库 。  
- react.js  
- react-dom.js  
- browser.min.js  

上面一共列举了三个库： react.js 、react-dom.js 和 browser.min.js ，它们必须首先加载。其中，react.js 是 React 的核心库，react-dom.js 是提供与 DOM 相关的功能，browser.min.js 的作用是将 JSX 语法转为 JavaScript 语法，这一步很消耗时间，实际上线的时候，应该将它放到服务器完成。  
你可以从[React官网](https://facebook.github.io/react/downloads.html)下载这些库，也可以将其下载到本地去使用。 

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

在 JavaScript 代码里写着 XML 格式的代码称为 JSX，下文会介绍。为了把 JSX 转成标准的 JavaScript，我们用 <script type="text/babel"> 标签，然后通过Babel转换成在浏览器中真正执行的内容。  

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
每一个XML标签都会被JSX转换工具转换成纯Javascript代码，使用JSX，组件的结构和组件之间的关系看上去更加清晰。  
JSX并不是React必须使用的，但React官方建议我们使用 JSX , 因为它能定义简洁且我们熟知的包含属性的树状结构语法。 
  
>提示：    
>- React 的 JSX 里约定分别使用首字母大、小写来区分本地组件的类和 HTML 标签。    
>- 由于 JSX 就是 JavaScript，一些标识符像 class 和 for 不建议作为 XML 属性名。作为替代，  React DOM 使用 className 和 htmlFor 来做对应的属性。  

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

>提示：React 的 JSX 里约定分别使用首字母大、小写来区分本地组件的类和 HTML 标签。   

>注意:
由于 JSX 就是 JavaScript，一些标识符像 class 和 for 不建议作为 XML 属性名。作为替代，React DOM 使用 className 和 htmlFor 来做对应的属性。

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
JSX 里添加注释很容易；它们只是 JS 表达式而已。你只需要在一个标签的子节点内(非最外层)小心地用 {} 包围要注释的部分。

```html
var content = (
  <Nav>
    {/* 一般注释, 用 {} 包围 */}
    <Person
      /* 多
         行
         注释 */
      name={window.isLoggedIn ? window.name : ''} // 行尾注释
    />
  </Nav>
);
```

### JSX延展属性  

#### 不要试图去修改组件的属性  
不推荐做法：   

```html
  var component = <Component />;
  component.props.foo = x; // 不好
  component.props.bar = y; // 同样不好
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

上文出现的... 标记被叫做延展操作符（spread operator）已经被 ES6 数组 支持。相关的还有 ES7 规范草案中的 Object 剩余和延展属性（Rest and Spread Properties）。我们利用了这些还在制定中标准中已经被支持的特性来使 JSX 拥有更优雅的语法。


## Component  
React 允许将代码封装成组件（component），然后像插入普通 HTML 标签一样，在网页中插入这个组件。 
```javascrift
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

**注意** 
- 组件类的第一个字母必须大写。
- 组件类只能包含一个顶层标签。  

## 组件的属性(props)  




 
## React in React Native 



## 参考  


##  About

---





## 使用React 






## 组件的属性(props)  
我们可以通过`this.props.xx`的形式获取组件对象的属性，对象的属性可以任意定义，但要避免与JavaScript关键字冲突。  
### [遍历对象的属性](http://www.ruanyifeng.com/blog/2015/03/react.html)： 
`this.props.children`会返回组件对象的所有属性。  
React 提供一个工具方法 React.Children 来处理 this.props.children 。我们可以用 `React.Children.map`或`React.Children.forEach` 来遍历子节点。   
**React.Children.map**  
```javascrift
array React.Children.map(object children, function fn [, object thisArg])
```     
该方法会返回一个array。  
**React.Children.forEach**    
```javascrift
React.Children.forEach(object children, function fn [, object thisArg])
```  
**eg：**  
```javascrift
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
```javascrift
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
```javascrift
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
```javascrift
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
```javascrift
var MyComponent = React.createClass({
  handleClick: function() {
    this.refs.myTextInput.focus();
  },
  render: function() {
    return (
      <div>
        <input type="text" ref="myTextInput" />
        <input type="button" value="Focus the text input" onClick={this.handleClick} />
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


## Reactive state
上文讲到了props，因为每个组件只会根据props 渲染了自己一次，props 是不可变的。为了实现交互，可以使用组件的 state 。this.state 是组件私有的，可以通过`getInitialState()`方法初始化，通过调用 `this.setState()` 来改变它。当 state 更新之后，组件就会重新渲染自己。    
render() 方法依赖于 this.props 和 this.state ，框架会确保渲染出来的 UI 界面总是与输入（ this.props 和 this.state ）保持一致。

### 初始化state   
通过`getInitialState() `方法初始化state，在组件的生命周期中仅执行一次，用于设置组件的初始化 state 。
```javascrift
 getInitialState:function(){
    return {favorite:false};
  }
```
### 更新 state 
通过`this.setState()`方法来更新state,调用该方法后，React会重新渲染相关的UI。  
`this.setState({favorite:!this.state.favorite});`

**Usage:**  
  
```javascrift
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
由于 this.props 和 this.state 都用于描述组件的特性，可能会产生混淆。一个简单的区分方法是，this.props 表示那些一旦定义，就不再改变的特性，而 this.state 是会随着用户互动而产生变化的特性。

## [Component Lifecycle](https://facebook.github.io/react/docs/working-with-the-browser.html#component-lifecycle)(组件的详细说明与生命周期 )
### 组件的详细说明  
当通过调用 React.createClass() 来创建组件的时候，每个组件必须提供render方法，并且也可以包含其它的在这里描述的生命周期方法。  
#### render
`ReactComponent render()`   
`render()` 方法是必须的。  
当该方法被回调的时候，会检测 `this.props` 和 `this.state`，并返回一个单子级组件。该子级组件可以是虚拟的本地 DOM 组件（比如 <div /> 或者 `React.DOM.div()`），也可以是自定义的复合组件。  
你也可以返回 `null` 或者 `false` 来表明不需要渲染任何东西。实际上，React 渲染一个 <noscript> 标签来处理当前的差异检查逻辑。当返回 `null` 或者 `false` 的时候，`this.getDOMNode()` 将返回 `null`。   
**提示**  
`render() `函数应该是纯粹的，也就是说该函数不修改组件 `state`，每次调用都返回相同的结果，不读写 DOM 信息，也不和浏览器交互（例如通过使用 `setTimeout`）。如果需要和浏览器交互，在 `componentDidMount()` 中或者其它生命周期方法中做这件事。保持 `render()` 纯粹，可以使服务器端渲染更加切实可行，也使组件更容易被理解。  
#### getInitialState
`object getInitialState()`
在组件挂载之前调用一次。返回值将会作为 `this.state `的初始值。  
#### getDefaultProps
`object getDefaultProps()`  
在组件类创建的时候调用一次，然后返回值被缓存下来。如果父组件没有指定 `props` 中的某个键，则此处返回的对象中的相应属性将会合并到 `this.props` （使用 in 检测属性）。  
**注意**  
该方法在任何实例创建之前调用，因此不能依赖于 `this.props`。另外，`getDefaultProps()` 返回的任何复杂对象将会在实例间共享，而不是每个实例拥有一份拷贝。  
#### [PropTypes](http://reactjs.cn/react/docs/reusable-components.html) 
`object propTypes`  
`propTypes` 对象允许验证传入到组件的 `props`。  更多关于混合的信息，参考[可重用的组件](http://reactjs.cn/react/docs/component-specs.html#proptypes)。
#### mixins
`array mixins`  
`mixin` 数组允许使用混合来在多个组件之间共享行为。更多关于混合的信息，参考[可重用的组件](http://reactjs.cn/react/docs/component-specs.html#mixins)。  
#### statics
`object statics`  
`statics` 对象允许你定义静态的方法，这些静态的方法可以在组件类上调用。例如：
```javascrift
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
在这个块儿里面定义的方法都是静态的，你可以通过ClassName.funcationName的形式调用它。  
**注意**  
这些方法不能获取组件的 `props` 和 `state`。如果你想在静态方法中检查 `props` 的值，在调用处把 `props` 作为参数传入到静态方法。

#### displayName
`string displayName`  
`displayName` 字符串用于输出调试信息。JSX 自动设置该值；[参考JSX 深入](http://reactjs.cn/react/docs/jsx-in-depth.html#react-composite-components)。
### 组件的生命周期
#### 组件的生命周期分成三个状态：  
- Mounting：已插入真实 DOM
- Updating：正在被重新渲染
- Unmounting：已移出真实 DOM

React 为每个状态都提供了两种处理函数，will 函数在进入状态之前调用，did 函数在进入状态之后调用。  
#### Mounting(装载)
- `getInitialState()`: 在组件挂载之前调用一次。返回值将会作为 this.state 的初始值。
- `componentWillMount()`：服务器端和客户端都只调用一次，在初始化渲染执行之前立刻调用。
- `componentDidMount()`：在初始化渲染执行之后立刻调用一次，仅客户端有效（服务器端不会调用）。

#### Updating (更新)
- componentWillReceiveProps(object nextProps) 在组件接收到新的 props 的时候调用。在初始化渲染的时候，该方法不会调用。

用此函数可以作为 react 在 prop 传入之后， render() 渲染之前更新 state 的机会。老的 props 可以通过 this.props 获取到。在该函数中调用 this.setState() 将不会引起第二次渲染。
- shouldComponentUpdate(object nextProps, object nextState): 在接收到新的 props 或者 state，将要渲染之前调用。

该方法在初始化渲染的时候不会调用，在使用 forceUpdate 方法的时候也不会。如果确定新的 props 和 state 不会导致组件更新，则此处应该 返回 false。
- componentWillUpdate(object nextProps, object nextState)：在接收到新的 props 或者 state 之前立刻调用。

在初始化渲染的时候该方法不会被调用。使用该方法做一些更新之前的准备工作。`注意：`你不能在该方法中使用 this.setState()。如果需要更新 state 来响应某个 prop 的改变，请使用 `componentWillReceiveProps`。
- componentDidUpdate(object prevProps, object prevState): 在组件的更新已经同步到 DOM 中之后立刻被调用。

该方法不会在初始化渲染的时候调用。使用该方法可以在组件更新之后操作 DOM 元素。
#### Unmounting(移除) 
- componentWillUnmount：在组件从 DOM 中移除的时候立刻被调用。

在该方法中执行任何必要的清理，比如无效的定时器，或者清除在 componentDidMount 中创建的 DOM 元素。

## Ajax 
组件的数据来源，通常是通过 Ajax 请求从服务器获取，可以在 componentDidMount 方法中进行 Ajax 请求，等到请求成功，再用 this.setState 方法重新渲染 UI 。
```javascript
var UserGist = React.createClass({
  getInitialState: function() {
    return {
      username: '',
      lastGistUrl: ''
    };
  },

  componentDidMount: function() {
    $.get(this.props.source, function(result) {
      var lastGist = result[0];
      if (this.isMounted()) {
        this.setState({
          username: lastGist.owner.login,
          lastGistUrl: lastGist.html_url
        });
      }
    }.bind(this));
  },

  render: function() {
    return (
      <div>
        {this.state.username}'s last gist is
        <a href={this.state.lastGistUrl}>here</a>.
      </div>
    );
  }
});

ReactDOM.render(
  <UserGist source="https://api.github.com/users/octocat/gists" />,
  document.body
);
```
上面代码使用 jQuery 完成 Ajax 请求，这是为了便于说明。React 本身没有任何依赖，完全可以不用jQuery，而使用其他库。  
我们甚至可以把一个Promise对象传入组件。
```javascript
ReactDOM.render(
  <RepoList
    promise={$.getJSON('https://api.github.com/search/repositories?q=javascript&sort=stars')}
  />,
  document.body
);
```
上面代码从Github的API抓取数据，然后将Promise对象作为属性，传给RepoList组件。  
如果Promise对象正在抓取数据（pending状态），组件显示"正在加载"；如果Promise对象报错（rejected状态），组件显示报错信息；如果Promise对象抓取数据成功（fulfilled状态），组件显示获取的数据。
```javascript
var RepoList = React.createClass({
  getInitialState: function() {
    return { loading: true, error: null, data: null};
  },

  componentDidMount() {
    this.props.promise.then(
      value => this.setState({loading: false, data: value}),
      error => this.setState({loading: false, error: error}));
  },

  render: function() {
    if (this.state.loading) {
      return <span>Loading...</span>;
    }
    else if (this.state.error !== null) {
      return <span>Error: {this.state.error.message}</span>;
    }
    else {
      var repos = this.state.data.items;
      var repoList = repos.map(function (repo) {
        return (
          <li>
            <a href={repo.html_url}>{repo.name}</a> ({repo.stargazers_count} stars) <br/> {repo.description}
          </li>
        );
      });
      return (
        <main>
          <h1>Most Popular JavaScript Projects in Github</h1>
          <ol>{repoList}</ol>
        </main>
      );
    }
  }
});
```

@[React's official site](https://facebook.github.io/react/)  
@[React 中文网](http://reactjs.cn/react/index.html)  
