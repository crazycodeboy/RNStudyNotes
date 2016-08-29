# RN+Android 原生组件开发###

如果React Native还不支持某个你需要的原生特性，你应当可以自己实现该特性的封装。

[TOC]

##原生模块(NativeModule)

首先来创建一个原生模块。一个原生模块是一个继承了`ReactContextBaseJavaModule`的Java类，它可以实现一些JavaScript所需的功能。我们这里的目标是可以在JavaScript里写`PayAndroid.onPay()`;
```java
	import com.facebook.react.bridge.NativeModule;
	import com.facebook.react.bridge.ReactApplicationContext;
	import com.facebook.react.bridge.ReactContext;
	import  com.facebook.react.bridge.ReactContextBaseJavaModule;
	import com.facebook.react.bridge.ReactMethod;
	import java.util.Map;

	public class PayModule extends ReactContextBaseJavaModule {

	  private static final String TYPE_WEIXIN = "weixin";
	  private static final String TYPE_ALIPAY = "alipay";

	  public ToastModule(ReactApplicationContext reactContext) {
	    super(reactContext);
	  }
	}
```

`ReactContextBaseJavaModule`要求派生类实现getName方法。这个函数用于返回一个字符串名字，这个名字在JavaScript端标记这个模块。这里我们把这个模块叫做`PayModule`，这样就可以在JavaScript中通过`React.NativeModules.PayAndroid`访问到这个模块。译注：RN已经内置了一个名为`PayAndroid`的模块，所以如果你在练习时完全照抄，那么运行时会报错名字冲突！所以请在这里选择另外一个名字！

	@Override
    public String getName() {
      return "PayAndroid";
    }

一个可选的方法`getContants`返回了需要导出给JavaScript使用的常量。它并不一定需要实现，但在定义一些可以被JavaScript同步访问到的预定义的值时非常有用。

 	@Override
  	public Map<String, Object> getConstants() {
	    final Map<String, Object> constants = new HashMap<>();
	    constants.put(TYPE_WEIXIN, TYPE_WEIXIN);
	    constants.put(TYPE_ALIPAY, TYPE_ALIPAY);
	    return constants;
  	}
要导出一个方法给JavaScript使用，Java方法需要使用注解`@ReactMethod`。方法的返回类型必须为`void`。`React Native`的跨语言访问是异步进行的，所以想要给JavaScript返回一个值的唯一办法是使用回调函数或者发送事件。

 	@ReactMethod
  	public void onPay(String type,ReadableMap payReq,final Callback callback) {
       if(payReq==null){
               callback.invoke(-1,"支付失败");
           }else {
               payFlag = payReq.getString("payFlag");
               money = payReq.getInt("money");

               if(type.equals(TYPE_ALIPAY))
                   traceNo = payReq.getString("pkpayorder");
               else if(type.equals(PaySDK.TYPE_WX))
                   wxReq = payReq.getMap("wxreq");
               WXPayReq wxPayReq = new WXPayReq();
               if(wxReq!=null){
                   wxPayReq.setAppid(wxReq.getString("appid"));
                   wxPayReq.setPartnerid(wxReq.getString("partnerid"));
                   wxPayReq.setPrepayid(wxReq.getString("prepayid"));
                   wxPayReq.setPackageValue(wxReq.getString("packageValue"));
                   wxPayReq.setNoncestr(wxReq.getString("noncestr"));
                   wxPayReq.setTimestamp(wxReq.getString("timestamp"));
                   wxPayReq.setSign(wxReq.getString("sign"));
                   wxPayReq.setStatus(wxReq.getInt("status"));
               }

               PayInfo payInfo = new PayInfo(payFlag,String.valueOf(money/100.0),payFlag,traceNo,wxPayReq);

               PaySDK paySDK = new PaySDK(getCurrentActivity(), type);

               paySDK.pay(payInfo,new PayListener() {
                   @Override
                   public void onPaySuccess(String resultInfo) {
                       callback.invoke(0,"支付成功");
                   }
                   @Override
                   public void onPayFail(String resultInfo) {
                       callback.invoke(-1,"支付失败");
                   }
                   @Override
                   public void onPayWait(String resultInfo) {


                   }
               });



           }
  	}

###参数类型
	Boolean -> Bool
	Integer -> Number
	Double -> Number
	Float -> Number
	String -> String
	Callback -> function
	ReadableMap -> Object
	ReadableArray -> Array

-ReadableMap

```javascript

/**
 *string转换为map
 */
strToMap(response,type,money,payFlag){
    var payParams = new Map();
    payParams.set('type',type);
    payParams.set('payFlag',payFlag);
    payParams.set('money',money);
    let obj= Object.create(null);
    for (let[k,v] of strMap) {
        obj[k] = v;
    }
    return obj;
}

```
###注册模块
在Java这边要做的最后一件事就是注册这个模块。我们需要在应用的Package类的`createNativeModules`方法中添加这个模块。如果模块没有被注册，它也无法在JavaScript中被访问到。
```java
class PayPackage implements ReactPackage {

  @Override
  public List<Class<? extends JavaScriptModule>> createJSModules() {
    return Collections.emptyList();
  }

  @Override
  public List<ViewManager> createViewManagers(ReactApplicationContext reactContext) {
    return Collections.emptyList();
  }

  @Override
  public List<NativeModule> createNativeModules(
                              ReactApplicationContext reactContext) {
    List<PayModule> modules = new ArrayList<>();

    modules.add(new PayModule(reactContext));

    return modules;
  }

```

这个package需要在`MainApplication.java`文件的`getPackages`方法中提供。这个文件位于你的`react-native`应用文件夹的android目录中。具体路径是:` android/app/src/main/java/com/your-app-name/MainApplication.java`.

	protected List<ReactPackage> getPackages() {
	    return Arrays.<ReactPackage>asList(
            new MainReactPackage(),
            new PayPackage()); // <-- 添加这一行，类名替换成你的Package类的名字.
	}

为了让你的功能从JavaScript端访问起来更为方便，通常我们都会把原生模块封装成一个JavaScript模块。这不是必须的，但省下了每次都从`NativeModules`中获取对应模块的步骤。这个JS文件也可以用于添加一些其他JavaScript端实现的功能。

	import { NativeModules } from 'react-native';
		// 下一句中的PayAndroid即对应上文
		// public String getName()中返回的字符串
		// 练习时请务必选择另外的名字！
	export default NativeModules.PayAndroid;

现在，在别处的JavaScript代码中可以这样调用你的方法：

	import PayAndroid from './PayAndroid';

	PayAndroid.onPay('alipay',obj,(code,message)=>{});


###更多特性
####CallBack回调函数
原生模块还支持一种特殊的参数——回调函数。它提供了一个函数来把返回值传回给JavaScript。

	@ReactMethod
	public void doSomething( Callback errorCallback, Callback successCallback) {
  		 ...
		 ...
	     if(success){
	       successCallback.invoke(0,returnMsg);
	     }
          or
		 if(failed){
			errorCallback.invoke(e.getMessage());
		 }
	  }
这个函数可以在JavaScript里这样使用：

	UIManager.doSomething((msg) => {
	    console.log(msg);
	  },
	  (code,msg) => {
	     console.log(code+','+msg);
	  }
	);
注意`callback`并非在对应的原生函数返回后立即被执行——注意跨语言通讯是异步的，这个执行过程会通过消息循环来进行。

####Promises
原生模块还可以使用promise来简化代码，如果桥接原生方法的最后一个参数是一个Promise，则对应的JS方法就会返回一个Promise对象。


	@ReactMethod
	public void doSomething( String any, Promise promise) {
  		 ...
		 ...
	     if(success){
	        WritableMap map = Arguments.createMap();
	        map.putString("name", "ada");
		    map.putInt("age", 12);
		    ...
	        promise.resolve(map);
	     }
          or
		 if(failed){
			promise.reject(e.getMessage());
		 }
	  }

现在JavaScript端的方法会返回一个Promise。这样你就可以在一个声明了async的异步函数内使用await关键字来调用，并等待其结果返回。（虽然这样写着看起来像同步操作，但实际仍然是异步的，并不会阻塞执行来等待）

	async function measureLayout() {
	   var {
	      name,
	      age,
	      ...
	    } = await UIManager.doSomething('ade');
	}

####发送事件到JavaScript

原生模块可以在没有被调用的情况下往JavaScript发送事件通知。最简单的办法就是通过`RCTDeviceEventEmitter`，这可以通过`ReactContext`来获得对应的引用，像这样：

	...
	private void sendEvent(ReactContext reactContext,
	                       String eventName,
	                       @Nullable WritableMap params) {
	  reactContext
	      .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
	      .emit(eventName, params);
	}
	...
	WritableMap params = Arguments.createMap();
	...
	sendEvent(reactContext, "keyboardWillShow", params);

你可以直接使用DeviceEventEmitter模块来监听事件：

	var { DeviceEventEmitter } = require('react-native');
	...
	componentWillMount: function() {
	  DeviceEventEmitter.addListener('keyboardWillShow', function(e: Event) {
	    // handle event.
	  });
	}
	...

##原生UI 组件

原生视图需要被一个ViewManager的派生类创建和管理。它能够包含更多公共的属性，譬如背景颜色、透明度、Flexbox布局等等。

提供原生视图很简单：
- 创建一个`ViewManager`的子类。
- 实现`createViewInstance`方法。
- 导出视图的属性设置器：使用`@ReactProp`（或`@ReactPropGroup`）注解。
- 把这个视图管理类注册到应用程序包的`createViewManagers`里。
- 实现`JavaScript`模块。

###自定义View

	...
	public class AndroidMapView extends FrameLayout{
	    public AndroidMapView(Context context) {
	        super(context);
	        initViews(context);
	    }
	...

###创建子类

	...

	public class ReactImageManager extends SimpleViewManager<AndroidMapView> {

	  public static final String REACT_CLASS = "AndroidMapView";

	  @Override
	  public String getName() {
	    return REACT_CLASS;
	  }

###实现方法`createViewInstance`

	 @Override
	  public ReactImageView createViewInstance(ReactContext context) {
	    return new AndroidMapView (context);
	  }
### 通过`@ReactProp`（或`@ReactPropGroup`）注解来导出属性的设置方法。

要导出给JavaScript使用的属性，需要申明带有`@ReactProp`（或`@ReactPropGroup`）注解的设置方法。方法的第一个参数是要修改属性的视图实例，第二个参数是要设置的属性值。方法的返回值类型必须为`void`，而且访问控制必须被声明为`public`。JavaScript所得知的属性类型会由该方法第二个参数的类型来自动决定。支持的类型有：`boolean`,` int`, `float`, `double`, `String`, `Boolean`, `Integer`, `ReadableArray`, `ReadableMap`。

`@ReactProp`注解必须包含一个字符串类型的参数`name`。这个参数指定了对应属性在JavaScript端的名字。除了`name`，`@ReactProp`注解还接受这些可选的参数：`defaultBoolean`,` defaultInt`, `defaultFloat`。

	   @ReactProp(name = "address",defaultInt=0)
	   public void setAddress(AndroidMapView view, @Nullable String address) {
	       if (address != null) {
	           view.setAddress(address);
	       }
	   }
###注册`ViewManager`

	@Override
	  public List<ViewManager> createViewManagers(
	                            ReactApplicationContext reactContext) {
	    return Arrays.<ViewManager>asList(
	      new AndroidMapView ()
	    );
	  }
###实现对应的JavaScript模块

	import { PropTypes } from 'react';
	import { requireNativeComponent, View } from 'react-native';

	var iface = {
	  name: 'AndroidMapView ',
	  propTypes: {
	    address: PropTypes.string
	  },
	};
	module.exports = requireNativeComponent('AndroidMapView ', iface);
通常接受两个参数，第一个参数是原生视图的名字，而第二个参数是一个描述组件接口的对象。组件接口应当声明一个友好的`name`，用来在调试信息中显示；组件接口还必须声明`propTypes`字段，用来对应到原生视图上。这个`propTypes`还可以用来检查用户使用View的方式是否正确。

###事件

	class AndroidMapView extends FrameLayout{
	   ...
	   public void onReceiveNativeEvent() {
	      WritableMap event = Arguments.createMap();
	      event.putString("message", "MyMessage");
	      ReactContext reactContext = (ReactContext)getContext();
	      reactContext.getJSModule(RCTEventEmitter.class).receiveEvent(
	          getId(),
	          "topChange",
	          event);
	    }
	}
这个事件名`topChange`在JavaScript端映射到`onChange`回调属性上（这个映射关系在`UIManagerModuleConstants.java`文件里）。这个回调会被原生事件执行，然后我们通常会在封装组件里构造一个类似的API：


	// AndroidMapComponent .js

	class AndroidMapComponent extends React.Component {
	  constructor() {
	    this._onChange = this._onChange.bind(this);
	  }
	  _onChange(event: Event) {
	    if (!this.props.onChangeMessage) {
	      return;
	    }
	    this.props.onChangeMessage(event.nativeEvent.message);
	  }
	  render() {
	    return <AndroidMapView {...this.props} onChange={this._onChange} />;
	  }
	}
	MyCustomView.propTypes = {
		onChangeMessage: React.PropTypes.func,
	    ...
	};

	var AndroidMapView = requireNativeComponent(`AndroidMapComponent `, AndroidMapView , {
		  nativeOnly: {onChange: true}
	});

有时候有一些特殊的属性，想从原生组件中导出，但是又不希望它们成为对应React封装组件的属性。举个例子，Switch组件可能在原生组件上有一个`onChange`事件，然后在封装类中导出`onValueChange`回调属性。这个属性在调用的时候会带上Switch的状态作为参数之一。这样的话你可能不希望原生专用的属性出现在API之中，也就不希望把它放到`propTypes`里。可是如果你不放的话，又会出现一个报错。解决方案就是带上`nativeOnly`选项。

##问题
1.使用API InteractionManager，它的作用就是可以使本来JS的一些操作在动画完成之后执行，这样就可确保动画的流程性

	InteractionManager.runAfterInteractions(()=>{
	//耗时较长
	//获取网络数据
	});

2.exports 和 module.exports

module.exports才是真正的接口，exports只不过是它的一个辅助工具。　最终返回给调用的是Module.exports而不是exports。

所有的exports收集到的属性和方法，都赋值给了Module.exports。当然，这有个前提，就是Module.exports本身不具备任何属性和方法。如果，Module.exports已经具备一些属性和方法，那么exports收集来的信息将被忽略。

a.js
```javascript
		exports.name='a';
		exports.age = 12;
		//module.exports = ['a','12']
```

b.js
```javascript
	var a = require('./a')
	console(a.name+','+a.age)// TypeError: Object a has no method 'name'
	//console(a[0]+','+a[1])
```