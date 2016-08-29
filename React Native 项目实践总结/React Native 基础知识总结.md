## React Native 基础知识总结



### Component
Component：组件，使用`extends React.Component`创建的类为组件。?
 `componentWillMount()`还可以用` constructor `来代替：

```javascript
	class Label extends React.Component{
	  constructor(props) {
          super(props);  
      }
	    render(){
	    }
	}
```

### props与state

##### props属性：
组件可以定义初始值，自己不可更改props属性值，只允许从父组件中传递过来：

```javascript
	// 父组件
	class ParentComponent extends React.Component{
	    render(){
	        return(<Child name="name">);
	    }
	}
	
	// 子组件
	class Child extends React.Component{
	    render(){
	        return(<Text>{this.props.name}</Text>);
	    }
	}
```
	
父组件向子组件传递name="name"的props属性，在子组件中使用this.props.name引用此属性。

属性类型``` prop type ```和默认属性 ```default prop ```可以通过类中的 ```static ```来声明：

```javascript
class Demo extends React.Component {
	   // 默认props
	  static defaultProps = {
        autoPlay: false,
        maxLoops: 10,
	  }
  	   // propTypes用于验证转入的props，当向 props 传入无效数据时，JavaScript 控制台会抛出警告
	  static propTypes = {
        autoPlay: React.PropTypes.bool.isRequired,
        maxLoops: React.PropTypes.number.isRequired,
        posterFrameSrc: React.PropTypes.string.isRequired,
	  }
	  state = {
        loopsRemaining: this.props.maxLoops,
	  }
	}
```

##### state属性：
组件用来改变自己状态的属性，通常使用```setState({key:value})```来改变属性值触发界面刷新，不能使用```this.state.xxx```来直接改变。
在开发中，一般不会在定时器函数（setInterval、setTimeout等）中来操作state。典型的场景是在接收到服务器返回的新数据，或者在用户输入数据之后。

对于经常改变的数据且需要刷新界面显示，可以使用state。对于不需要改变的属性值可以使用props。React Native建议由顶层的父组件定义state值，并将state值作为子组件的props属性值传递给子组件，这样可以保持单一的数据传递。


	
###生命周期

我们把组件从```装载```，到```渲染```，再到```卸载```当做一次生命周期，也就是组件的生存状态从```装载```开始到```卸载```为止，期间可以根据属性的变化进行多次渲染。
生命周期的三种状态：
-	Mounting：装载
1.componentWillMount()
2.componentDidMount()
-	Updating：渲染
1.componentWillReceiveProps()
2.shouldComponentUpdate()
3.componentWillUpdate()
4.componentDidUpdate()
-	Unmounting：卸载
componentWillUnmount()

```javascript
componentWillMount()，组件开始装载之前调用，在一次生命周期中只会执行一次。  
componentDidMount()，组件完成装载之后立即调用，在一次生命周期中只会执行一次。在这里开始就可以对组件进行各种操作了，比如在组件装载完成后要显示的时候执行动画。  
componentWillUpdate(object nextProps, object nextState)，当新的props或者state被接受时,组件属性更新之前调用,这个方法不会被初始渲染调用。不能在这个方法里使用 this.setState()。如果你要响应一个prop变化来更新state,使用componentWillReceiveProps 来替代。

componentDidUpdate(object prevProps, object prevState)，组件属性更新之后调用，每次属性更新都会调用，这个方法不会被初始渲染调用。   
componentWillUnmount()，组件卸载之前调用，在这个方法里执行一些必要的清理操作,比如timers。
```

#####  组件属性更改时会调用以下方法，在一次生命周期中可以执行多次：

```javascript
	componentWillReceiveProps(object nextProps)，已加载组件收到新的props时被调用.这个方法不会为最初的渲染调用。
	
	shouldComponentUpdate(object nextProps, object nextState)，组件判断是否重新渲染时调用，当新的props或者state被收到,在渲染前被调用.这个方法不会在最初的渲染被调用。
```

并没有类似的 ```componentWillReceiveState ()```的方法。一个即将到来的 prop 转变可能会导致一个 state 变化,但是反之不是。如果你需要实现一个对 state 变化相应的操作，使用 ```componentWillUpdate()```。


如果 shouldComponentUpdate () 返回false, render() 会在下次state变化前被完全跳过。另外componentWillUpdate () 和 componentDidUpdate()  将不会被调用。

默认情况下shouldComponentUpdate()  总是返回 true 来阻止当 state 突变时的细微bug。
	
	
### 页面跳转

初始化第一个页面：

```javascript
	import SeatPageComponent from './SeatPageComponent';
	import MainPageComponent from './MainPageComponent';
	import TrainListComponent from './TrainListComponent';
	
	class MainPage extends React.Component {
	    render() {
	        let defaultName = 'MainPageComponent';
	        let defaultComponent = MainPageComponent;
	        return (
	            <Navigator
	                // 指定默认页面
	                initialRoute={{ name: defaultName, component: defaultComponent }}
	                // 配置页面间跳转动画
	                configureScene={(route) => {
	                    return Navigator.SceneConfigs.VerticalDownSwipeJump;
	                }}
	                // 初始化默认页面
	                renderScene={(route, navigator) => {
	                    let Component = route.component;
	                    // 将navigator作为props传递到下一个页面
	                    return <Component {...route.params} navigator={navigator} />
	                }} />
	        );
	    }
	}
	
```

跳转到下一页面：

```javascript
	jumpToNext(){
	      const { navigator } = this.props;// 由上一个页面传递过来
	      if(navigator) {
	          navigator.push({
	              name: 'SeatPageComponent',
	              component: SeatPageComponent,// 下一个页面
	          });
	      }
	}
```

返回上一个页面：

```javascript
	 _back(){
	     const { navigator } = this.props;
	     if(navigator) {
	         navigator.pop();
	     }
	 }
```
	
页面间通信

例如：从A页面打开B页面
A通过route.params将参数传递给B：

```javascript
	jumpToNext(){ 
	    const { navigator } = this.props;// 由上一个页面传递过来
	    if(navigator) { 
	        navigator.push({ 
	            name: 'SeatPageComponent', 
	            component: SeatPageComponent,// 下一个页面 
	            params: { // 需要传递个下一个页面的参数,第二个页面使用this.props.xxx获取参数
	                id: 123,
	                title: this.state.title, 
	            },
	        });
	     }
	}
```
	
A通过route.params传递回调方法或者A的引用来让B将数据传回给A：

```javascript
	// A页面
	jumpToNext(){ 
	    const { navigator } = this.props;// 由上一个页面传递过来
	    if(navigator) { 
	        let that = this;// this作用域，参见下文函数绑定
	        navigator.push({ 
	            name: 'SeatPageComponent', 
	            component: SeatPageComponent,// 下一个页面 
	            params: { // 需要传递个下一个页面的参数,第二个页面使用this.props.xxx获取参数
	                title: '测试',
	                getName: function(name) {that.setState({ name: name })}
	            },
	        });
	     }
	}
	
	// B页面
	 _back(){
	     const { navigator } = this.props;
	     if(this.props.getName){
	         this.props.getName('测试');
	     }
	     if(navigator) {
	         navigator.pop();
	     }
	 }
```


### flexbox布局
##### 什么是flexbox布局
React中引入了flexbox概念,flexbox是属于web前端领域CSS的一种布局方案，是2009年W3C提出了一种新的布局方案，可以简便、完整、响应式地实现各种页面布局。
RN利用flexBox模型布局, 也就是在手机屏幕上对组件进行排列.利用flexBox模型,开发者可以开发出动态宽高的自适应的UI布局。

##### flexbox中的样式主要有以下几类:
1.	位置及宽、高相关的样式键
2.	容器属性,决定子组件排列规则的键
3.	元素属性,决定组件显示规则的键
4.	边框、空隙与填充

#####布局样式 
- position
 ```relative```(默认) 表示当前描述的位置是相对定位，不可以使用``` bottom```和```right```。```top```和```left```表示当前组件距离上一个同级组件的最上(左)距离
 ```absolute``` 表示当前描述的位置是绝对定位，``` top``` 、```bottom```、``` left```、 ```right```，描述当前组件的位置距离父组件最（上下、左、右)的距离
- width
 ```width```、```height```、```maxHeight```、```maxWidth```、```minHeight```、```minWidth``` 组件的宽和高是可以动态改变的,所以可以设置宽和高的最大和最小值 
- flexDirection
 ```row```：横向排列，<b>主轴</b>为水平方向；
 ```?column```：竖直排列，<b>主轴</b>为垂直方向。 
- flexWrap
 ```?wrap ```?和 ```?nowrap ```?(默认值)?，当水平或垂直布局时，如果子View放不下可选 ```?wrap ```?实现自动换行,
- justifyContent 
子布局在主轴方向位置  enum(```flex- start```,```flex-end```,```center```,```space-between```,```space-around```)
- alignItems
  子布局在侧轴方向位置 enum(```flex-start```,```flex-end```,```center```,```stretch``` )
- flex
 权重，默认值是0当它的值为1时，子组件将自动缩放以适应父组件剩下的空白空间。
- alignSelf
 忽略它的父组件样式中的```alignItems```的取值，而对该组件使用```alignSelf```键对应的规则。
enum(```auto```,```flex-start```,```flex-end```,```center```,```stretch```)
- padding
- margin


![盒子模型示意图](http://upload-images.jianshu.io/upload_images/1132780-3e6d1a45fb4550ce.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


