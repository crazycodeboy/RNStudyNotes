
# React Native 每日一学(Learn a little every day)  

汇聚知识，分享精华。  
>如果你是一名React Native爱好者，或者有一颗热爱钻研新技术的心，喜欢分享技术干货、项目经验、以及你在React Naive学习研究或实践中的一些经验心得等等，欢迎投稿《React Native 每日一学》栏目。   
如果你是一名Android、iOS、或前端开发人员，有者一颗积极进取的心，欢迎关注《React Native 每日一学》。本栏目汇聚React Native开发的技巧，知识点，经验等。  

## 列表  
1. [D1:React Native 读取本地的json文件 (2016-8-18)](#d1react-native-读取本地的json文件-2016-8-18)
2. [D2:React Native import 文件的小技巧 (2016-8-19)](#d2react-native-import-文件的小技巧-2016-8-19)
3. [D3:React Native 真机调试 (2016-8-22)](#d3react-native-真机调试-2016-8-22)
4. [D4:React Native 函数的绑定 (2016-8-23)](#d4react-native-函数的绑定-2016-8-23)
5. [D5:React Native setNativeProps使用 (2016-8-24)](#d5react-native-setnativeprops使用2016-8-24)
6. [D6:ref属性不只是string（2016-8-25)](#d6ref属性不只是string2016-8-25)
7. [D7:解构赋值（Destructuring assignment）(2016-8-26)](#d7解构赋值destructuring-assignment2016-8-26)
8. [D8:React-Native 原生模块调用(iOS) (2016-8-29)](#d8react-native-原生模块调用ios-2016-8-29)
9. [D9:动态属性名&字符串模板(2016-8-30)](#d9动态属性名字符串模板2016-8-30)
10. [D10:优化切换动画卡顿的问题(2016-8-31)](#d10优化切换动画卡顿的问题2016-8-31)
11. [D11:AsyncStorage存储key管理小技巧(2016-9-1)](#d11asyncstorage存储key管理小技巧---)
12. [D12:延展操作符(Spread operator)(2016-9-2)](#d12延展操作符spread-operator2016-9-2)
13. [D13:React Native学习资料整理(2016-9-5)](#d13react-native学习资料整理2016-9-5)
14. [D14:React Native Android跳入RN界面(2016-9-7)](#d14react-native-android跳入rn界面2016-9-7)
15. [D15:为Promise插上可取消的翅膀(2016-9-8)](#d15为promise插上可取消的翅膀2016-9-8)
16. [D16:Image组件遇到的宽高问题(2016-9-9)](#d16image组件遇到的宽高问题2016-9-9)
17. [D17:数据类型优化(2016-9-12)](#d17数据类型优化2016-9-12)
18. [D18:TextInput高度自增长(2016-9-19)](#d18textinput高度自增长2016-9-19)
19. [D19:ListView滚动平滑(2016-9-20)](#d19listview滚动平滑2016-9-20)
20. [D20:ReactMethod的参数类型(2016-9-21)](#d20reactmethod的参数类型2016-9-21)
21. [D21:React Native 和iOS Simulator 那点事(2016-9-22)](#d21react-native-和ios-simulator-那点事2016-9-22)
22. [D22:如何判断对象是否有某个属性(2016-9-23)](#d22如何判断对象是否有某个属性2016-9-23)
23. [D23:生命周期回调函数总结(2016-9-26)](#d23生命周期回调函数总结2016-9-26)

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

D23:生命周期回调函数总结(2016-9-26)
------
就和iOS开发一样,RN中的组件也有生命周期,所谓生命周期，就是一个对象从开始生成到最后消亡所经历的状态,生命周期大家肯定都很熟悉,此篇把生命周期的回调函数做一个总结
###总结
```
生命周期                   调用次数         能否使用 setSate()
getDefaultProps           1(全局调用一次)  否
getInitialState           1              否
componentWillMount        1              是
render                    >=1            否
componentDidMount         1              是
componentWillReceiveProps >=0            是
shouldComponentUpdate     >=0            否
componentWillUpdate       >=0            否
componentDidUpdate        >=0            否
componentWillUnmount      1              否
```

D22:如何判断对象是否有某个属性(2016-9-23)
------
- 使用in关键字 该方法可以判断对象的自有属性和继承来的属性是否存在。
	
	```
	var o={x:1};
	"x" in o; //true，自有属性存在
	"y" in o; //false
	"toString" in o; //true，是一个继承属性
	```
	
- 使用对象的hasOwnProperty()方法 该方法只能判断自有属性是否存在，对于继承属性会返回false。
	
	```
	var o={x:1};
	o.hasOwnProperty("x"); 　　 //true，自有属性中有x
	o.hasOwnProperty("y"); 　　 //false，自有属性中不存在y
	o.hasOwnProperty("toString"); //false，这是一个继承属性，但不是自有属性
	```
	
- 用undefined判断 自有属性和继承属性均可判断。
	
	```
	var o={x:1};
	o.x!==undefined; //true
	o.y!==undefined; //false
	o.toString!==undefined //true
	```
- 在条件语句中直接判断
	
	```
	var o={};
	if(o.x) o.x+=1; //如果x是undefine,null,false," ",0或NaN,它将保持不变
	```


D21:React Native 和iOS Simulator 那点事(2016-9-22)
----

### 问题1：使用React Native时按cmd+r无法reload js，cmd+d无法唤起 React Native开发菜单？  

不知大家是否有过这样的经历，用 React Native开发应用正不亦乐乎的时候，突然发现，cmd+r，cmd+d快捷键在iOS Simulator上不起作用了，一时抓狂，不知道问题出在哪。

其实这个问题主要是由于iOS Simulator和键盘之间断开了连接导致的，也就是说iOS Simulator不在接受键盘的事件了（也不是完全不是受，至少cmd+shift+h它还是会响应的）。   

那么你肯定会问了，刚才还好好的，怎么突然间就断开连接了呢，我也没做什么啊？   

这是因为在iOS Simulator的Hardware菜单下的“Connect hardware keyboard”功能有个打开和关闭的快捷键“shift+cmd+k”,想想刚才是不是使用了这组快捷键了呢。   

![Connect hardware keyboard](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%20%E9%97%AE%E9%A2%98%E5%8F%8A%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88%E5%90%88%E9%9B%86/React%20Native%20%E5%92%8CiOS%20Simulator%20%E9%82%A3%E7%82%B9%E4%BA%8B/images/Connect%20hardware%20keyboard.png)   

>解决办法：将“Connect hardware keyboard”重新勾选上就好了。   

### 问题2：iOS Simulator的动画变得非常慢？   

为了方便开发者调试动画，iOS官方为iOS Simulator添加了一个可以“放慢动画”的功能叫“Slow Animation”，以方便开发者能更好的调试动画。   

![Slow Animation](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%20%E9%97%AE%E9%A2%98%E5%8F%8A%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88%E5%90%88%E9%9B%86/React%20Native%20%E5%92%8CiOS%20Simulator%20%E9%82%A3%E7%82%B9%E4%BA%8B/images/Slow%20Animation.png)

这个功能确实在调试动画的时候起了不少的作用，但不知情的开发者，当不小心打开了“Slow Animation”功能之后，发现APP所有的动画都变得非常慢，一时不解，是不是程序出什么问题了？难道摊上性能方面的事了？      

>解决办法：取消勾选iOS Simulator(模拟器)的Debug菜单下“Slow Animation”功能即可。





D20:ReactMethod的参数类型(2016-9-21)
------
`@ReactMethod`方法中传的参数必须是JavaScript和Java相互对应的。

```javascript
Boolean -> Bool
Integer -> Number
Double -> Number
Float -> Number
String -> String
Callback -> function
ReadableMap -> Object
ReadableArray -> Array
```

D19:ListView滚动平滑(2016-9-20)
------
ListView设计的时候，当需要动态加载非常大的数据的时候，下面的方法性能优化的方法可以让我们的ListView滚动的时候更加平滑：

- 只更新渲染数据变化的那一行  ，`rowHasChanged`方法会告诉ListView组件是否需要重新渲染当前那一行。
- 选择渲染的频率 ，默认情况下面每一个`event-loop`(事件循环)只会渲染一行(可以同pageSize自定义属性设置)。这样可以把大的工作量进行分隔，提供整体渲染的性能。

D18:TextInput高度自增长(2016-9-19)
------
自定义组件

	class AutoExpandingTextInput extends Component{
		 render() {
	        return (
	            <TextInput {...this.props}  //将组件定义的属性交给TextInput
	                multiline={true}
	                onChange={this.onChange}
	                onContentSizeChange={this.onContentSizeChange}
	                style={[styles.textInputStyle,{height:Math.max(35,this.state.height)}]}
	                value={this.state.text}
	            />
	        );
	    }
	}

然后引用：

		 render() {
	        return (
	            <View style={styles.container}>
	                <AutoExpandingTextInput
	                    style={styles.textInputStyle}
	                    onChangeText={this._onChangeText}
	                />
	            </View>
	        );
     

D17:数据类型优化(2016-9-12)
------
经常会遇到页面需要加载和渲染数据,有时刷新数据是state中的值没有修改,但是遇到this.setState(),界面就会被重新渲染,因为react-native的生命周期就是,当你调用setState时，总是会触发render的方法。
###优化1
可以使用shouldComponentUpdate生命周期方法，此方法作用是在props或 者state改变且接收到新的值时，则在要render方法之前调用。此方法在初始化渲染的时候不会调用，在使用forceUpdate方法的时候也不会。所以在这个方法中我们可以增加些判断规则来避免当state或者props没有改变时所造成的重新render.

```
shouldComponentUpdate(dataProps,dataState) {
  return dataProps.value !== this.props.value;
}
```

###优化2
如果是一个列表的话这样判断就有问题,这里即使使用了shouldComponentUpdate中的判断，但却一直返回true，导致还会执行render。所以必须对对象所有的键值进行进行比较才能确认是否相等。这里推荐使用facebook自家的immutablejs。一个不可变数据类型的库。使用后可以直接使用以下的写法达到我们之前的目的。immutablejs其他的具体用法请见:[Immutable 详解及 React 中实践](http://www.w3ctech.com/topic/1595)优化后代码如下:

```
export default class KSD extends Component {
    constructor(props) {
        super(props);
        this.state = {
            data: Immutable.formJS({
                value:{
                    value1:'value1',
                    value2:'value2',
                    value3:'value3'
                }
            })
        }
    }
    shouldComponentUpdate(dataProps,dataState) {
        return(
          return dataProps.data !== this.props.data;
        )
    }
}
```

D16:Image组件遇到的宽高问题(2016-9-9)
------
开发中使用Image组件展示图片，在某些机型上有时并不能得到正确的宽高,设置`resizeMode`无效，此时可以设置宽高属性为`null`这样就可以正常显示了。

|                 宽度不正确       |             宽度正确          |
|--------------------------------|------------------------------|
|![宽度不正确](./images/D16/1.png) |	![宽度正确](./images/D16/2.png)|

更多相关问题[Stack Overflow][1]  [Github][2]


D15:为Promise插上可取消的翅膀(2016-9-8)
------
`Promise`是React Native开发过程中用于异步操作的最常用的API，但Promise没有提供用于取消异步操作的方法。为了实现可取消的异步操作，我们可以为Promise包裹一层可取消的外衣。    

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

然后可以这样使用取消操作：   

```javascript
const somePromise = new Promise(r => setTimeout(r, 1000));//创建一个异步操作
const cancelable = makeCancelable(somePromise);//为异步操作添加可取消的功能
cancelable
  .promise
  .then(() => console.log('resolved'))
  .catch(({isCanceled, ...error}) => console.log('isCanceled', isCanceled));
// 取消异步操作
cancelable.cancel();   
```

**了解更多：[React Native 性能优化之可取消的异步操作](https://github.com/crazycodeboy/RNStudyNotes/tree/master/React%20Native%20%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96/React%20Native%20%E6%80%A7%E8%83%BD%E4%BC%98%E5%8C%96%E4%B9%8B%E5%8F%AF%E5%8F%96%E6%B6%88%E7%9A%84%E5%BC%82%E6%AD%A5%E6%93%8D%E4%BD%9C)**


D14:React Native Android跳入RN界面(2016-9-7)
------
步骤：
1.新建一个类继承`Activity`，并实现`DefaultHardwareBackBtnHandler`接口
2.new一个`ReactRootView`，并build 一个`ReactInstanceManager`
3.`setContentView(mReactRootView);`
```java
	  mReactRootView = new ReactRootView(this);
        mReactInstanceManager = ReactInstanceManager.builder()
                .setApplication(getApplication())
                .setBundleAssetName("index.android.bundle")
                .setJSMainModuleName("index.android")
                .addPackage(new MainReactPackage())
                .setUseDeveloperSupport(true)
                .setInitialLifecycleState(LifecycleState.RESUMED)
                .build();
        Bundle bundle = new Bundle();
        bundle.putString("enter","KsudiReward");
        mReactRootView.startReactApplication(mReactInstanceManager,                      "KsudiCircle", bundle);

        setContentView(mReactRootView);
```
其中`KsudiCircle`是RN入口 注册的组件名称，bundle为原生带入RN的属性值

D13:React Native学习资料整理(2016-9-5)
------
收集整理了一些学习指南，包含 教程、开源app和资源网站等的链接,如果需要查阅资料或找寻第三方库,大家可以去查找

###资源整合

[RNStudyNotes
 ★350 ](https://github.com/crazycodeboy/RNStudyNotes)作者的学习笔记,欢迎star,每天不定时更新

[awesome-react-native
 ★7037](https://github.com/jondot/awesome-react-native)  Awesome React Native系列,有最全的第三方组件(推荐!)

[react-native-guide
 ★5777](https://github.com/reactnativecn/react-native-guide) React-Native学习指南,开源App和组件
 
 [React Native 高质量学习资料汇总](http://www.jianshu.com/p/454f2e6f28e9)  @author ASCE1885整理
 
 [React Native 从入门到原理](http://www.jianshu.com/p/978c4bd3a759) 作者@bestswifter
 
 [深入浅出ES6](www.infoq.com/cn/es6-in-depth/)深入浅出ES6专栏合集迷你书

D12:延展操作符(Spread operator)(2016-9-2)
------
通常我们在封装一个组件时，会对外公开一些 props 用于实现功能。大部分情况下在外部使用都应显示的传递 props 。但是当传递大量的props时，会非常繁琐，这时我们可以使用 `...(延展操作符,用于取出参数对象的所有可遍历属性)` 来进行传递。

### 一般情况下我们应该这样写
```
<CustomComponent type='normal' number={2} />
```

### 使用 ... ，等同于上面的写法

```
var params = {

		type: 'normal',

		number: 2

	}

<CustomComponent {...params} />
```

### 配合解构赋值避免传入一些不需要的参数

```
var params = {
	name: '123',
	title: '456',
	type: 'aaa'
}

var { type, ...other } = params;

<CustomComponent type='normal' number={2} {...other} />
//等同于
<CustomComponent type='normal' number={2} name='123' title='456' />
```


D11:AsyncStorage存储key管理小技巧   
------

### 场景  

AsyncStorage是React Native推荐的数据存储方式。当我们需要根据条件从本地查询出多条记录时，你会想到来一个`select * from xx where xx`。但是很不幸的告诉你，AsyncStorage
是不支持sql的，因为AsyncStorage是Key-Value存储系统。

**那么如何才能快速的从众多记录中将符合条件的记录查询出来呢？**    
请往下看... 

###  AsyncStorage key管理   

为了方便查询多条符合规则的记录，我们可以在保存数据前，对这条数据进行分类，然后记录下这条记录的key。下次再查询该数据前，只需要先查询之前保存的key，然后通过
`static multiGet(keys, callback?) `API，将符合规则的数据一并查询出来。   

### 用例  

>保存数据   

**第一步：保存数据**

```javascript
  saveFavoriteItem(key,vaule,callback) {
    AsyncStorage.setItem(key,vaule,(error,result)=>{
      if (!error) {//更新Favorite的key
        this.updateFavoriteKeys(key,true);
      }
    });
  }
```

**第二步：更新key**  

```javascript
/**
   * 更新Favorite key集合
   * @param isAdd true 添加,false 删除
   * **/
  updateFavoriteKeys(key,isAdd){
    AsyncStorage.getItem(this.favoriteKey,(error,result)=>{
      if (!error) {
        var favoriteKeys=[];
        if (result) {
          favoriteKeys=JSON.parse(result);
        }
        var index=favoriteKeys.indexOf(key);
        if(isAdd){
          if (index===-1)favoriteKeys.push(key);
        }else {
          if (index!==-1)favoriteKeys.splice(index, 1);
        }
        AsyncStorage.setItem(this.favoriteKey,JSON.stringify(favoriteKeys));
      }
    });
  }
```    

>查询批量数据   

**第一步：查询key**   

```javascript
getFavoriteKeys(){//获取收藏的Respository对应的key
    return new Promise((resolve,reject)=>{
      AsyncStorage.getItem(this.favoriteKey,(error,result)=>{
        if (!error) {
          try {
            resolve(JSON.parse(result));
          } catch (e) {
            reject(error);
          }
        }else {
          reject(error);
        }
      });
    });
  }
```

**第二步：根据key查询数据**    

```javascript
AsyncStorage.multiGet(keys, (err, stores) => {
            try {
              stores.map((result, i, store) => {
                // get at each store's key/value so you can work with it
                let key = store[i][0];
                let value = store[i][1];
                if (value)items.push(JSON.parse(value));
              });
              resolve(items);
            } catch (e) {
              reject(e);
            }
          });
 ```

>**以上是我在使用AsyncStorage进行批量数据查询的一些思路，大家根据实际情况进行调整。**   




D10:优化切换动画卡顿的问题(2016-8-31)
------
使用API InteractionManager，它的作用就是可以使本来JS的一些操作在动画完成之后执行，这样就可确保动画的流程性。当然这是在延迟执行为代价上来获得帧数的提高。
```javascript
	InteractionManager.runAfterInteractions(()=>{
		//...耗时较长的同步任务...
		//更新state也需要时间
		this.setState({
			...
		})
		//获取某些数据，需要长时间等待
		this.fetchData(arguements)
	})
```
D9:动态属性名&字符串模板(2016-8-30)
------
在 ES6+ 中，我们不仅可以在对象字面量属性的定义中使用表达式，还有使用使用字符串模板：

	class Form extends React.Component {
	  onChange(inputName, e) {
    	this.setState({
      	[`${inputName}Value`]: e.target.value,
    	});
	  }
	}

D8:React-Native 原生模块调用(iOS) (2016-8-29)
------
在项目中遇到地图,拨打电话,清除缓存等iOS与Andiorid机制不同的功能,就需要调用原生的界面或模块,这里说下React Native调用iOS原生模块,Andiorid也是大同小异
###1.创建原生模块，实现“RCTBridgeModule”协议
```
#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"

@interface KSDMapManager : NSObject <RCTBridgeModule>

@end
```
###2 导出模块，导出方法
```
@implementation KSDMapManager
//导出模块
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(gotoIM:(RCTResponseSenderBlock)callback)
{
   __weak typeof(self) weakSelf = self;
  self.callback = callback;
  
  UIViewController *controller = (UIViewController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
  KSDMapLocationViewController *mapVc = [[KSDMapLocationViewController alloc] init];
  mapVc.handle = ^(NSString *address) {
    weakSelf.itemValue = address;
    NSArray *events = [[NSArray alloc] initWithObjects:self.itemValue, nil];
    callback(events);
  }; 
  [controller presentViewController:mapVc animated:YES completion:nil];
}

```

###3 js文件中调用
```
//创建原生模块实例
var KSDMapManager = NativeModules.KSDMapManager;
//方法调用
KSDMapManager.gotoIM(
          (events)=>{
            this._inputReceiveAddress(events);
            console.log(events);
          })       

```

D7:解构赋值（[Destructuring assignment][0]）(2016-8-26)
------
解构赋值语法是JavaScript的一种表达式，可以方便的从数组或者对象中快速提取值赋给定义的变量。

### 获取数组中的值
从数组中获取值并赋值到变量中，变量的顺序与数组中对象顺序对应。

```
var foo = ["one", "two", "three", "four"];

var [one, two, three] = foo;
console.log(one); // "one"
console.log(two); // "two"
console.log(three); // "three"

//如果你要忽略某些值，你可以按照下面的写法获取你想要的值
var [first, , , last] = foo;
console.log(first); // "one"
console.log(last); // "four"

//你也可以这样写
var a, b; //先声明变量

[a, b] = [1, 2];
console.log(a); // 1
console.log(b); // 2
```

如果没有从数组中的获取到值，你可以为变量设置一个默认值。

```
var a, b;

[a=5, b=7] = [1];
console.log(a); // 1
console.log(b); // 7
```

通过解构赋值可以方便的交换两个变量的值。

```
var a = 1;
var b = 3;

[a, b] = [b, a];
console.log(a); // 3
console.log(b); // 1

```

### 获取对象的值
从对象中获取对象属性的值，在声明变量的时候要与对象的属性名保持一致。

```
var o = {p: 42, q: true};
var {p, q} = o;

console.log(p); // 42
console.log(q); // true

//你也可以这样写
var a, b;

({a, b} = {a:1, b:2});

console.log(a); // 1
console.log(b); // 2
```

可以从一个对象中获取对象属性的值并赋值给与对象属性名不同的变量。

```
var o = {p: 42, q: true};
var {p: foo, q: bar} = o;
 
console.log(foo); // 42 
console.log(bar); // true  
```
和获取数组中的值一样，从对象中获取属性的值也可以设置一个默认值。

```
var {a=10, b=5} = {a: 3};

console.log(a); // 3
console.log(b); // 5
``` 



D6:ref属性不只是string（2016-8-25)
----

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



D5:React Native setNativeProps使用（2016-8-24)
----

有时候我们需要直接改动组件并触发局部的刷新，但不使用`state`或是`props`。
`setNativeProps` 方法可以理解为web的直接修改dom。使用该方法修改 `View` 、 `Text` 等 RN自带的组件 ，则不会触发组件的 `componentWillReceiveProps` 、 `shouldComponentUpdate` 、`componentWillUpdate` 等组件生命周期中的方法。

### 使用例子
 
 ```javascript
  class MyButton extends React.Component({
	setNativeProps(nativeProps) {
	     this._root.setNativeProps({   //这里输入你要修改的组件style
	     	height:48,
	     	backgroundColor:'red'
	     });
	},
	render() {
	     return (
	     	<View ref={component => this._root = component} {...this.props} style={styles.button}>
	 	     <Text>{this.props.label}</Text>
	 	</View>
	     )
	},
  });
 ```
 
### 避免和`render`方法的冲突

如果要更新一个由`render`方法来维护的属性，则可能会碰到一些出人意料的bug。因为每一次组件重新渲染都可能引起属性变化，这样一来，之前通过`setNativeProps`所设定的值就被完全忽略和覆盖掉了。


D4:React Native 函数的绑定 (2016-8-23)
----
在ES6的class中函数不再被自动绑定，你需要手动去绑定它们。

第一种在构造函数里绑定。

	  constructor(props) {
    	super(props); 
    	// Set up initial state
    	this.state = {
      		text: props.initialValue || 'placeholder' 
    };
        // Functions must be bound manually with ES6 classes
    	this.handleChange = this.handleChange.bind(this); 
另一种方式就是在你使用的地方通过内联来绑定:

	// Use `.bind`:
	 render() { 
    	return (
     	 <input onChange={this.handleChange.bind(this)}
       	 value={this.state.text} /> 
    );
	}
	// Use an arrow function:
	render() {
		 return (
			<input onChange={() => 	this.handleChange()} 
      	value={this.state.text} />
	);
以上任意一种都可以，然而在效率上却不行了。每一次调用render(可以说是非常频繁！)一个新的函数都会被创建。与在构造函数里只绑定一次相比就慢一些。

最终的选择是使用箭头函数直接替换函数在类中的声明，像这样：

	// the normal way
	// requires binding elsewhere
	handleChange(event) {
	  	this.setState({
    	text: event.target.value
		});
	}
	// the ES7 way
	// all done, no binding required
	handleChange = (event) => { 
	  this.setState({
    text: event.target.value
	  });
	}
通过这种方式，你不需要绑定任何东西。这都已经通过神奇的箭头函数被搞定了。像期望的那样，函数内部的this将会指向组件实例。
参考：[http://www.jianshu.com/p/a4c23654932e](http://www.jianshu.com/p/a4c23654932e)

D3:React Native 真机调试 (2016-8-22)
------ 
开发中真机调试是必不可少的,有些功能和问题模拟器是无法重现的,所以就需要配合真机测试,接下来就说下安卓和iOS的真机调试,不难,但是有很多细节需要注意

###iOS 真机调试
1. ``必须`` 保证调试用电脑的和你的设备处于相同的 ``WiFi ``网络环境中下
2. 打开Xcode,找到 AppDelegate.m 文件
3. 更改 jsCodeLocation 中的 localhost 改成你电脑的局域网IP地址
4. IP地址点击左面右上角WIFi图标,找到打开网络偏好设置,状态栏下就可以看见了
5. 在Xcode中,选择你的手机作为目标设备,Run运行就可以了
![React Native 真机调试的json文件-1](https://raw.githubusercontent.com/WT-Road/RNStudyNotes/master/React%20Native%20%E6%AF%8F%E6%97%A5%E4%B8%80%E5%AD%A6/images/D1/React%20Native%20%E7%9C%9F%E6%9C%BA%E8%B0%83%E8%AF%95%E7%9A%84json%E6%96%87%E4%BB%B6-1.png)

###Android 真机调试
1. 在 Android 设备上打开 USB debugging 并连接上电脑启动调试。

2. 在真机上运行的方法与在模拟器上运行一致，都是通过 react-native run-android 来安装并且运行你的 React Native 应用。

3. 如果不是 Android 5.0+ (API 21) ，那么就没办法通过 adb reverse 进行调试，需要通过 WiFi 来连接上你的开发者服务器
4. 让调试用电脑和你的手机必须处于相同的 WiFi 网络中下 打开震动菜单 (摇动设备)->前往 Dev Settings->选择 Debug server host for device->输入调试用电脑的局域网IP->点击 Reload JS

注:因为本人不是安卓开发,所以参考[http://my.oschina.net/imot/blog/512808](http://my.oschina.net/imot/blog/512808)

###细节
其实还是有些坑的,这里只说iOS 如开始所说,必须是同一网络下,有时电脑同时开着Wifi和插着网线,建议把网线拔掉,但是也不排除可以,没有试过,还有就是

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





[0]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment


# React Native 每日一学(Learn a little every day)  

汇聚知识，分享精华。  
>如果你是一名React Native爱好者，或者有一颗热爱钻研新技术的心，喜欢分享技术干货、项目经验、以及你在React Naive学习研究或实践中的一些经验心得等等，欢迎投稿《React Native 每日一学》栏目。   
如果你是一名Android、iOS、或前端开发人员，有者一颗积极进取的心，欢迎关注《React Native 每日一学》。本栏目汇聚React Native开发的技巧，知识点，经验等。  

## 列表  
1. [D1:React Native 读取本地的json文件 (2016-8-18)](#d1react-native-读取本地的json文件-2016-8-18)
2. [D2:React Native import 文件的小技巧 (2016-8-19)](#d2react-native-import-文件的小技巧-2016-8-19)
3. [D3:React Native 真机调试 (2016-8-22)](#d3react-native-真机调试-2016-8-22)
4. [D4:React Native 函数的绑定 (2016-8-23)](#d4react-native-函数的绑定-2016-8-23)
5. [D5:React Native setNativeProps使用 (2016-8-24)](#d5react-native-setnativeprops使用2016-8-24)
6. [D6:ref属性不只是string（2016-8-25)](#d6ref属性不只是string2016-8-25)
7. [D7:解构赋值（Destructuring assignment）(2016-8-26)](#d7解构赋值destructuring-assignment2016-8-26)
8. [D8:React-Native 原生模块调用(iOS) (2016-8-29)](#d8react-native-原生模块调用ios-2016-8-29)

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

D8:React-Native 原生模块调用(iOS) (2016-8-29)
------
在项目中遇到地图,拨打电话,清除缓存等iOS与Andiorid机制不同的功能,就需要调用原生的界面或模块,这里说下React Native调用iOS原生模块,Andiorid也是大同小异
###1.创建原生模块，实现“RCTBridgeModule”协议
```
#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"

@interface KSDMapManager : NSObject <RCTBridgeModule>

@end
```
###2 导出模块，导出方法
```
@implementation KSDMapManager
//导出模块
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(gotoIM:(RCTResponseSenderBlock)callback)
{
   __weak typeof(self) weakSelf = self;
  self.callback = callback;
  
  UIViewController *controller = (UIViewController*)[[[UIApplication sharedApplication] keyWindow] rootViewController];
  KSDMapLocationViewController *mapVc = [[KSDMapLocationViewController alloc] init];
  mapVc.handle = ^(NSString *address) {
    weakSelf.itemValue = address;
    NSArray *events = [[NSArray alloc] initWithObjects:self.itemValue, nil];
    callback(events);
  }; 
  [controller presentViewController:mapVc animated:YES completion:nil];
}

```

###3 js文件中调用
```
//创建原生模块实例
var KSDMapManager = NativeModules.KSDMapManager;
//方法调用
KSDMapManager.gotoIM(
          (events)=>{
            this._inputReceiveAddress(events);
            console.log(events);
          })       

```

D7:解构赋值（[Destructuring assignment][0]）(2016-8-26)
------
解构赋值语法是JavaScript的一种表达式，可以方便的从数组或者对象中快速提取值赋给定义的变量。

### 获取数组中的值
从数组中获取值并赋值到变量中，变量的顺序与数组中对象顺序对应。

```
var foo = ["one", "two", "three", "four"];

var [one, two, three] = foo;
console.log(one); // "one"
console.log(two); // "two"
console.log(three); // "three"

//如果你要忽略某些值，你可以按照下面的写法获取你想要的值
var [first, , , last] = foo;
console.log(first); // "one"
console.log(last); // "four"

//你也可以这样写
var a, b; //先声明变量

[a, b] = [1, 2];
console.log(a); // 1
console.log(b); // 2
```

如果没有从数组中的获取到值，你可以为变量设置一个默认值。

```
var a, b;

[a=5, b=7] = [1];
console.log(a); // 1
console.log(b); // 7
```

通过解构赋值可以方便的交换两个变量的值。

```
var a = 1;
var b = 3;

[a, b] = [b, a];
console.log(a); // 3
console.log(b); // 1

```

### 获取对象的值
从对象中获取对象属性的值，在声明变量的时候要与对象的属性名保持一致。

```
var o = {p: 42, q: true};
var {p, q} = o;

console.log(p); // 42
console.log(q); // true

//你也可以这样写
var a, b;

({a, b} = {a:1, b:2});

console.log(a); // 1
console.log(b); // 2
```

可以从一个对象中获取对象属性的值并赋值给与对象属性名不同的变量。

```
var o = {p: 42, q: true};
var {p: foo, q: bar} = o;
 
console.log(foo); // 42 
console.log(bar); // true  
```
和获取数组中的值一样，从对象中获取属性的值也可以设置一个默认值。

```
var {a=10, b=5} = {a: 3};

console.log(a); // 3
console.log(b); // 5
``` 



D6:ref属性不只是string（2016-8-25)
----

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



D5:React Native setNativeProps使用（2016-8-24)
----

有时候我们需要直接改动组件并触发局部的刷新，但不使用`state`或是`props`。
`setNativeProps` 方法可以理解为web的直接修改dom。使用该方法修改 `View` 、 `Text` 等 RN自带的组件 ，则不会触发组件的 `componentWillReceiveProps` 、 `shouldComponentUpdate` 、`componentWillUpdate` 等组件生命周期中的方法。

### 使用例子
 
 ```javascript
  class MyButton extends React.Component({
	setNativeProps(nativeProps) {
	     this._root.setNativeProps({   //这里输入你要修改的组件style
	     	height:48,
	     	backgroundColor:'red'
	     });
	},
	render() {
	     return (
	     	<View ref={component => this._root = component} {...this.props} style={styles.button}>
	 	     <Text>{this.props.label}</Text>
	 	</View>
	     )
	},
  });
 ```
 
### 避免和`render`方法的冲突

如果要更新一个由`render`方法来维护的属性，则可能会碰到一些出人意料的bug。因为每一次组件重新渲染都可能引起属性变化，这样一来，之前通过`setNativeProps`所设定的值就被完全忽略和覆盖掉了。


D4:React Native 函数的绑定 (2016-8-23)
----
在ES6的class中函数不再被自动绑定，你需要手动去绑定它们。

第一种在构造函数里绑定。

	  constructor(props) {
    	super(props); 
    	// Set up initial state
    	this.state = {
      		text: props.initialValue || 'placeholder' 
    };
        // Functions must be bound manually with ES6 classes
    	this.handleChange = this.handleChange.bind(this); 
另一种方式就是在你使用的地方通过内联来绑定:

	// Use `.bind`:
	 render() { 
    	return (
     	 <input onChange={this.handleChange.bind(this)}
       	 value={this.state.text} /> 
    );
	}
	// Use an arrow function:
	render() {
		 return (
			<input onChange={() => 	this.handleChange()} 
      	value={this.state.text} />
	);
以上任意一种都可以，然而在效率上却不行了。每一次调用render(可以说是非常频繁！)一个新的函数都会被创建。与在构造函数里只绑定一次相比就慢一些。

最终的选择是使用箭头函数直接替换函数在类中的声明，像这样：

	// the normal way
	// requires binding elsewhere
	handleChange(event) {
	  	this.setState({
    	text: event.target.value
		});
	}
	// the ES7 way
	// all done, no binding required
	handleChange = (event) => { 
	  this.setState({
    text: event.target.value
	  });
	}
通过这种方式，你不需要绑定任何东西。这都已经通过神奇的箭头函数被搞定了。像期望的那样，函数内部的this将会指向组件实例。
参考：[http://www.jianshu.com/p/a4c23654932e](http://www.jianshu.com/p/a4c23654932e)

D3:React Native 真机调试 (2016-8-22)
------ 
开发中真机调试是必不可少的,有些功能和问题模拟器是无法重现的,所以就需要配合真机测试,接下来就说下安卓和iOS的真机调试,不难,但是有很多细节需要注意

###iOS 真机调试
1. ``必须`` 保证调试用电脑的和你的设备处于相同的 ``WiFi ``网络环境中下
2. 打开Xcode,找到 AppDelegate.m 文件
3. 更改 jsCodeLocation 中的 localhost 改成你电脑的局域网IP地址
4. IP地址点击左面右上角WIFi图标,找到打开网络偏好设置,状态栏下就可以看见了
5. 在Xcode中,选择你的手机作为目标设备,Run运行就可以了
![React Native 真机调试的json文件-1](https://raw.githubusercontent.com/WT-Road/RNStudyNotes/master/React%20Native%20%E6%AF%8F%E6%97%A5%E4%B8%80%E5%AD%A6/images/D1/React%20Native%20%E7%9C%9F%E6%9C%BA%E8%B0%83%E8%AF%95%E7%9A%84json%E6%96%87%E4%BB%B6-1.png)

###Android 真机调试
1. 在 Android 设备上打开 USB debugging 并连接上电脑启动调试。

2. 在真机上运行的方法与在模拟器上运行一致，都是通过 react-native run-android 来安装并且运行你的 React Native 应用。

3. 如果不是 Android 5.0+ (API 21) ，那么就没办法通过 adb reverse 进行调试，需要通过 WiFi 来连接上你的开发者服务器
4. 让调试用电脑和你的手机必须处于相同的 WiFi 网络中下 打开震动菜单 (摇动设备)->前往 Dev Settings->选择 Debug server host for device->输入调试用电脑的局域网IP->点击 Reload JS

注:因为本人不是安卓开发,所以参考[http://my.oschina.net/imot/blog/512808](http://my.oschina.net/imot/blog/512808)

###细节
其实还是有些坑的,这里只说iOS 如开始所说,必须是同一网络下,有时电脑同时开着Wifi和插着网线,建议把网线拔掉,但是也不排除可以,没有试过,还有就是

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





[0]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Destructuring_assignment
[1]: http://stackoverflow.com/questions/29322973/whats-the-best-way-to-add-a-full-screen-background-image-in-react-native

[2]: https://github.com/facebook/react-native/issues/4598#issuecomment-162328501


