# React Native 启动白屏问题解决教程

![react-native-splash-screen.png](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%20%E9%97%AE%E9%A2%98%E5%8F%8A%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88%E5%90%88%E9%9B%86/React%20Native%20%E5%90%AF%E5%8A%A8%E7%99%BD%E5%B1%8F%E9%97%AE%E9%A2%98%E8%A7%A3%E5%86%B3%E6%95%99%E7%A8%8B/images/react-native-splash-screen-.png)

## 目录

* [问题描述](#问题描述)
* [问题分析](#问题分析)
* [Android启动白屏解决方案](#android启动白屏解决方案)
* [iOS启动白屏解决方案](#ios启动白屏解决方案)
* [开源库](#开源库)
* [最后](#最后)

**[项目源码：react-native-splash-screen](https://github.com/crazycodeboy/react-native-splash-screen)**

## 问题描述：  
用React Native架构的无论是Android APP还是iOS APP，在启动时都出现白屏现象，时间大概1~3s（根据手机或模拟器的性能不同而不同）。

## 问题分析：  

**为什么会产生白屏？**

React Native应用在启动时会将js bundle读取到内存中，并完成渲染。这期间由于js bundle还没有完成装载并渲染，所以界面显示的是白屏。  

白屏给人的感觉很不友好，那有没有办法不显示白屏呢？   

上文解释了：为什么React Native应用会在启动的时候显示一会白屏。既然知道了出现问题的原因，那么离解决问题也不远了。市场上大部分APP在启动的时候都会有个启动屏，启动屏对于用户是比较友好的，一来展示欢迎信息，二来显示一些产品信息或一些广告，启动页对于程序来说，是为程序完成初始化加载数据，做一些初始化工作的所保留的时间，启动屏等待的时间可长可短，具体根据业务而定。

下面我就教大家如何给React Native 应用添加启动屏，并解决启动白屏的问题。  

## Android启动白屏解决方案

我们可以通过为React Native Android应用添加启动屏的方式，来解决启动白屏的问题。我在[《React Native Android启动屏，启动白屏，闪现白屏》](http://www.cboy.me/2016/09/15/React-Native-Android%E5%90%AF%E5%8A%A8%E5%B1%8F-%E5%90%AF%E5%8A%A8%E7%99%BD%E5%B1%8F-%E9%97%AA%E7%8E%B0%E7%99%BD%E5%B1%8F/)一文中介绍过一种为React Native Android应用添加启动屏的方法，
不过那种方法虽好，但牵扯到对React Native 源码的修改，如果React Native 版本有更新还需要对源码做一些处理，所以以后维护起来不是很方便。  

下面就向大家介绍另外一种为React Native Android应用添加启动屏的方案。    

在[《React Native Android启动屏，启动白屏，闪现白屏》](http://www.cboy.me/2016/09/15/React-Native-Android%E5%90%AF%E5%8A%A8%E5%B1%8F-%E5%90%AF%E5%8A%A8%E7%99%BD%E5%B1%8F-%E9%97%AA%E7%8E%B0%E7%99%BD%E5%B1%8F/)一文中
我们使用的是在根视图容器上添加一个视图作为启动屏，当js bundle加载并渲染完成后，再将添加的视图从根视图上移除。在根视图上添加一个视图的方式其实就是为了遮挡白屏，既然是遮挡白屏，我们是不是可以弹出一个对话框呢？   

小伙伴们肯定会说，对话框也不是全屏啊，主题也不一样啊，不过没关系，既然我们可以添加对话框，那么我们就可以修改对话框的样式来达到我们需要的效果。

要达到启动屏的效果，我们需要一个什么样效果的对话框呢？  

1. 在APP启动的时候显示；
2. 在js bundle加载并渲染完成后消失；
3. 全屏显示；
4. 显示的内容可以通过 layout xml 进行修改；

上述是我们对这个对话框的基本需求，现在就让我们来实现这一需求：  

### 第一步，创建一个对话框组件[SplashScreen](https://github.com/crazycodeboy/react-native-splash-screen/blob/master/android/src/main/java/com/cboy/rn/splashscreen/SplashScreen.java)

为满足上述需求，对话框组件需要提供下面两个方法：

**1.显示对话框的方法:**

```java
/**
 * 打开启动屏
 */
public static void show(final Activity activity,final boolean fullScreen) {
    if (activity == null) return;
    mActivity = new WeakReference<Activity>(activity);
    activity.runOnUiThread(new Runnable() {
        @Override
        public void run() {
            if (!activity.isFinishing()) {

                mSplashDialog = new Dialog(activity,fullScreen? R.style.SplashScreen_Fullscreen:R.style.SplashScreen_SplashTheme);
                mSplashDialog.setContentView(R.layout.launch_screen);
                mSplashDialog.setCancelable(false);

                if (!mSplashDialog.isShowing()) {
                    mSplashDialog.show();
                }
            }
        }
    });
} 
```

为了Activity被销毁的时候，持有的Activity能被及时的回收，这里我们通过`new WeakReference<Activity>(activity);`创建了一个Activity的弱引用。

另外，因为在Android中所有的有关UI操作都必须在主线程，所有我们通过`activity.runOnUiThread(new Runnable()...`，将对话框的显示放在了主线程处理。

上述代码中，`show`的第二个参数`fullScreen`表示启动屏是全屏显示(即是否隐藏状态栏)，代码会控制对话框加载不同的主题样式[R.style.SplashScreen_Fullscreen](https://github.com/crazycodeboy/react-native-splash-screen/blob/master/android/src/main/res/values/styles.xml)与[R.style.SplashScreen_SplashTheme](https://github.com/crazycodeboy/react-native-splash-screen/blob/master/android/src/main/res/values/styles.xml)来达到是否隐藏状态的需求。  

然后，我们可以在`MainActivity.java`的`onCreate`方法中调`void show(final Activity activity,final boolean fullScreen)`方法来显示启动屏。

```java
@Override
protected void onCreate(Bundle savedInstanceState) {
    SplashScreen.show(this,true);
    super.onCreate(savedInstanceState);
}
``` 

>提示：`SplashScreen.show(this,true);`放在`super.onCreate(savedInstanceState);`之前的位置效果会更好。


**2.关闭对话框的方法:**

```java
/**
 * 关闭启动屏
 */
public static void hide(Activity activity) {
    if (activity == null) activity = mActivity.get();
    if (activity == null) return;

    activity.runOnUiThread(new Runnable() {
        @Override
        public void run() {
            if (mSplashDialog != null && mSplashDialog.isShowing()) {
                mSplashDialog.dismiss();
            }
        }
    });
}
```

上述代码中，我们提供了关闭启动屏的方法。那么如何才能让JS模块调用`void hide(Activity activity)`来关闭启动屏呢？  


###  第二步：向JS模块提供[SplashScreen](https://github.com/crazycodeboy/react-native-splash-screen/blob/master/android/src/main/java/com/cboy/rn/splashscreen/SplashScreen.java)组件


因为我们需要在js中调用`hide`方法还控制启动屏的关闭。js不能直接调Java，所有我们需要为他们搭建一个桥梁([Native Modules](https://facebook.github.io/react-native/docs/native-modules-android.html))。  

**首先，创建一个`ReactContextBaseJavaModule`类型的类，供js调用。**   

```java
/**
 * SplashScreenModule
 * 出自：http://www.cboy.me
 * GitHub:https://github.com/crazycodeboy
 * Eamil:crazycodeboy@gmail.com
 */
public class SplashScreenModule extends ReactContextBaseJavaModule{
    public SplashScreenModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "SplashScreen";
    }

    /**
     * 打开启动屏
     */
    @ReactMethod
    public void show() {
        SplashScreen.show(getCurrentActivity());
    }

    /**
     * 关闭启动屏
     */
    @ReactMethod
    public void hide() {
        SplashScreen.hide(getCurrentActivity());
    }
}
```

**其次，创建一个`ReactPackage`类型的类，用于向React Native注册我们的`SplashScreenModule`组件。**   


```java
/**
 * SplashScreenReactPackage
 * 出自：http://www.cboy.me
 * GitHub:https://github.com/crazycodeboy
 * Eamil:crazycodeboy@gmail.com
 */
public class SplashScreenReactPackage implements ReactPackage {

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
        List<NativeModule> modules = new ArrayList<>();
        modules.add(new SplashScreenModule(reactContext));
        return modules;
    }
}
```

**再次，在MainApplication中注册`SplashScreenModule`组件。**   

```java
@Override
protected List<ReactPackage> getPackages() {
    return Arrays.<ReactPackage>asList(
            new MainReactPackage(),
            new SplashScreenReactPackage()
    );
}
```

准备工作，做好之后，下面我们就可以在JS中调用`hide`方法来关闭启动屏了。


### 第三步：在JS模块中控制启动屏的关闭

创建一个名为[SplashScreen](https://github.com/crazycodeboy/react-native-splash-screen/blob/master/index.js)的文件，加入下面代码。  


```JavaScript
/**
 * SplashScreen
 * 启动屏
 * 出自：http://www.cboy.me
 * GitHub:https://github.com/crazycodeboy
 * Eamil:crazycodeboy@gmail.com
 * @flow
 */
'use strict';

import { NativeModules } from 'react-native';
module.exports = NativeModules.SplashScreen;
```

然后，我们可以在js中调用SplashScreen的hide()方法来关闭启动屏了。


```JavaScript
componentDidMount() {
    SplashScreen.hide();
}
```

>不要忘记在使用SplashScreen的js文件中导入它哦`import SplashScreen from './SplashScreen`。



## iOS启动白屏解决方案

在iOS中，iOS支持为程序设置一个Launch Image或Launch Screen File来作为启动屏，当程序被打开的时候，首先显示的便是设置的这个启动屏了。   

那么小伙伴会问了，这个启动屏幕什么时候会消失呢？

在`AppDelegate`如下方法：

`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`

该方法返回一个	BOOL类型的值，当系统调用该方并返回值之后，标志着APP启动加载已经完成，系统会将启动屏给关掉。   

所以如果我们控制了这个启动屏幕让它在js bundle加载并渲染完成之后再关闭不就解决了iOS 启动白屏了吗？   

上面已经说到，`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`方法执行完成之后，启动屏会被关掉。

所以我们就想办法控制该方实行的时间。  

### 第一步：创建一个名为[SplashScreen](https://github.com/crazycodeboy/react-native-splash-screen/tree/master/ios)的Object-C文件

在SplashScreen.h文件中添加如下代码：

```obj-c
//
//  SplashScreen.h
//  SplashScreen
//  出自：http://www.cboy.me
//  GitHub:https://github.com/crazycodeboy
//  Eamil:crazycodeboy@gmail.com


#import "RCTBridgeModule.h"

@interface SplashScreen : NSObject<RCTBridgeModule>
+ (void)show;
@end
```

在SplashScreen.m中添加如下代码：

```obj-c 
//  SplashScreen
//  出自：http://www.cboy.me
//  GitHub:https://github.com/crazycodeboy
//  Eamil:crazycodeboy@gmail.com

#import "SplashScreen.h"

static bool waiting = true;

@implementation SplashScreen
- (dispatch_queue_t)methodQueue{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

+ (void)show {
    while (waiting) {
        NSDate* later = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop mainRunLoop] runUntilDate:later];
    }
}

RCT_EXPORT_METHOD(hide) {
    dispatch_async(dispatch_get_main_queue(),
                   ^{
                       waiting = false;
                   });
}
@end

```

在上述代码中，我们通过`[[NSRunLoop mainRunLoop] runUntilDate:later];`来控制`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`方法执行的时间，
主线程会每隔0.1s阻塞一次，直到`waiting`变量为true，然后我们就可以通过暴露给JS模块的`hide`方法来控制`waiting`变量的值，继而达到控制启动屏幕的关闭。

### 第二步：在JS模块中控制启动屏的关闭

通过第一步我们已经向JS模块暴露了`hide`方法，然我们就可以在JS模块中通过`hide`方法来关闭启动屏幕。
由于iOS在JS模块中控制启动屏的关闭的方法和Android中[第三步：在JS模块中控制启动屏的关闭](#第三步在js模块中控制启动屏的关闭)的方法是一样的，这里就不再介绍了。

### 开源库

为了方便大家使用和解决React Native应用启动白屏的问题，我已经将上述方案做成React Native组件[react-native-splash-screen](https://github.com/crazycodeboy/react-native-splash-screen/blob/master/README.zh.md),
开源在了[GitHub](https://github.com/crazycodeboy/react-native-splash-screen/blob/master/README.zh.md)上，小伙伴们可以下载使用。


## 最后

**既然来了，留下个喜欢再走吧，鼓励我继续创作(^_^)∠※**   

**如果喜欢我的文章，那就关注我的[博客](http://www.cboy.me/)吧，让我们一起做朋友~~**

#### 戳这里,加关注哦:   

>**[微博](http://weibo.com/u/6003602003)：第一时间获取推送**    
**[个人博客](http://www.cboy.me/)：干货文章都在这里哦**  
**[GitHub](https://github.com/crazycodeboy/)：我的开源项目**   



