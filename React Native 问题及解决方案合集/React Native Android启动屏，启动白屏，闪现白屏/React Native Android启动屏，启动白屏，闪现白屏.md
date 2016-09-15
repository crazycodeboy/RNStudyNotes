# React Native Android启动屏，启动白屏，闪现白屏

本文出自[《React Native学习笔记》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。

![React Native Android启动屏，启动白屏，闪现白屏](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%20%E9%97%AE%E9%A2%98%E5%8F%8A%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88%E5%90%88%E9%9B%86/React%20Native%20Android%E5%90%AF%E5%8A%A8%E5%B1%8F%EF%BC%8C%E5%90%AF%E5%8A%A8%E7%99%BD%E5%B1%8F%EF%BC%8C%E9%97%AA%E7%8E%B0%E7%99%BD%E5%B1%8F/img/React%20Native%20Android%E5%90%AF%E5%8A%A8%E5%B1%8F%EF%BC%8C%E5%90%AF%E5%8A%A8%E7%99%BD%E5%B1%8F%EF%BC%8C%E9%97%AA%E7%8E%B0%E7%99%BD%E5%B1%8F.gif)

## 问题描述：  
用React Native架构的无论是Android APP还是iOS APP，在启动时都出现白屏现象，时间大概1~3s（根据手机或模拟器的性能不同而不同）。

## 问题分析：  
React Native应用在启动时会将js bundle读取到内存中，并完成渲染。这期间由于js bundle还没有完成装载并渲染，所以界面显示的是白屏。  

白屏给人的感觉很不友好，那有没有办法不显示白屏呢？   

上文解释了：为什么React Native应用会在启动的时候显示一会白屏。既然知道了出现问题的原因，那么离解决问题也不远了。市场上大部分APP在启动的时候都会有个启动屏，启动屏对于用户是比较友好的，一来展示欢迎信息，二来显示一些产品信息或一些广告，启动页对于程序来说，是为程序完成初始化加载数据，做一些初始化工作的所保留的时间，启动屏等待的时间可长可短，具体根据业务而定。

下面我就教大家如何给React Native Android加启动屏，并解决启动白屏的问题。  


## 为React Native Android添加启动屏(解决白屏等待问题)  

为了实现为React Native Android添加启动屏，我们需要给React Native动刀了了。下面就让我们从源码看起。   

### 原理分析 
通过`react-native init <project name>`初始化的应用，Android部分，只有一个`MainActivity`，它是整个Android程序的入口。
  
```java
public class MainActivity extends ReactActivity {
    /**
     * Returns the name of the main component registered from JavaScript.
     * This is used to schedule rendering of the component.
     */
    @Override
    protected String getMainComponentName() {
        return "GitHubPopular";
    }
}
```

通过上述代码可以看出`MainActivity`很干净，就一个`getMainComponentName()`方法。显然启动白屏不是因为`MainActivity`导致的。

接下来，我们就继续探索，进入`ReactActivity`源码一探究竟。  

```java
@Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    if (getUseDeveloperSupport() && Build.VERSION.SDK_INT >= 23) {
      // Get permission to show redbox in dev builds.
      if (!Settings.canDrawOverlays(this)) {
        Intent serviceIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
        startActivity(serviceIntent);
        FLog.w(ReactConstants.TAG, REDBOX_PERMISSION_MESSAGE);
        Toast.makeText(this, REDBOX_PERMISSION_MESSAGE, Toast.LENGTH_LONG).show();
      }
    }
    mReactRootView = createRootView();
    mReactRootView.startReactApplication(
      getReactNativeHost().getReactInstanceManager(),
      getMainComponentName(),
      getLaunchOptions());
    setContentView(mReactRootView);
    mDoubleTapReloadRecognizer = new DoubleTapReloadRecognizer();
  }
```

上面代码是`ReactActivity`的`onCreate`方法的代码，`onCreate`作为一个Activity的入口，负责着程序初始化等一系列工作。  
熟悉Android开发的小伙伴都知道，在`onCreate`方法通过`setContentView()`方法设置一个用于用户交互界面。在`ReactActivity`的`onCreate`方法中也有使用`setContentView()`。   

```java
 mReactRootView = createRootView();
 
 mReactRootView.startReactApplication(
      getReactNativeHost().getReactInstanceManager(),
      getMainComponentName(),
      getLaunchOptions());
 setContentView(mReactRootView);
```

上述代码中，首先通过` mReactRootView = createRootView();`创建一个根视图，该视图便是React Native应用的最顶部视图。然后通过`mReactRootView.startReactApplication`方法，加载并渲染js bundle，此过程是比较耗时的。最后，通过`setContentView(mReactRootView);`将根视图绑定到Activity界面上。  

基本原理就是这些，下面我们就对`ReactActivity`动动刀子。   

## 实现思路   
先说一下思路：

1. APP启动的时候控制ReactActivity显示启动屏。
2. 提供关闭启动屏的公共接口。
3. 在js的适当位（一般是程序初始化工作完成后）置调用上述公共接口关闭启动屏。


## 具体实现   

### 第一步：APP启动的时候控制ReactActivity显示启动屏  

在给`ReactActivity`动刀子前我们需要进行一些准备工作。  

**基础准备：**

**首先，我们需要将`ReactActivity`复制一份出来。**   
因为`ReactActivity`是React Native源码中的一部分，我们无法直接对其源码进行修改，所以我们需将它复制一份出来。然后将`MainActivity`继承改为我们复制出来的这个`ReactActivity`。   

**其次。修改getUseDeveloperSupport方法。**

因为，`ReactNativeHost`的`getUseDeveloperSupport`方法是受保护类型的，所以我们无法在它所属包之外访问该方法。但我们又需要在`ReactActivity`中调用该方法，那么我们可以使用反射来满足我们这一需求。   

```java  
protected boolean getUseDeveloperSupport() {
    ReactNativeHost rnh=((ReactApplication) getApplication()).getReactNativeHost();
        Class<?>cls=rnh.getClass();
    Object support= null;
    try {
        Method method = cls.getDeclaredMethod("getUseDeveloperSupport", new Class[]{});
        method.setAccessible(true);
        support=method.invoke(rnh);
    } catch (NoSuchMethodException e) {
        e.printStackTrace();
    } catch (InvocationTargetException e) {
        e.printStackTrace();
    } catch (IllegalAccessException e) {
        e.printStackTrace();
    }
    return (boolean) support;
} 
```
    
>前期工作准备玩了，现在让我们开始吧。


为了让ReactActivity显示启动屏我们需要创建一个View容器，来容纳启动屏视图和React Native根视图。

```java
@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        if (getUseDeveloperSupport() && Build.VERSION.SDK_INT >= 23) {
            // Get permission to show redbox in dev builds.
            if (!Settings.canDrawOverlays(this)) {
                Intent serviceIntent = new Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
                startActivity(serviceIntent);
                FLog.w(ReactConstants.TAG, REDBOX_PERMISSION_MESSAGE);
                Toast.makeText(this, REDBOX_PERMISSION_MESSAGE, Toast.LENGTH_LONG).show();
            }
        }

        mRootView = new FrameLayout(this);
        splashView = LayoutInflater.from(this).inflate(R.layout.launch_screen, null);

        mReactRootView = createRootView();
        mReactRootView.startReactApplication(
                getReactNativeHost().getReactInstanceManager(),
                getMainComponentName(),
                getLaunchOptions());
        mRootView.addView(mReactRootView);
        mRootView.addView(splashView, new ViewGroup.LayoutParams(
                ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT));
        setContentView(mRootView);
        mDoubleTapReloadRecognizer = new DoubleTapReloadRecognizer();
    }
```
	
**首先，我创建了一个`mRootView = new FrameLayout(this);`视图容器。**     

**其次，将启动屏布局文件读到内存中`splashView = LayoutInflater.from(this).inflate(R.layout.launch_screen, null);`。**   

**再次，添加`mReactRootView`与`splashView`，注意添加顺序。**

**最后，将`mRootView`绑定到Activity。**  

这样一来，我们就控制了ReactActivity在启动的时候显示欢迎界面。下面我们需要让ReactActivity开放关闭换用界面的接口方法。  


```java
/**
 * 隐藏启动屏幕
 */
public void hide() {
    if (mRootView == null || splashView == null) return;
    AlphaAnimation fadeOut = new AlphaAnimation(1, 0);
    fadeOut.setDuration(1000);
    splashView.startAnimation(fadeOut);
    fadeOut.setAnimationListener(new Animation.AnimationListener() {
        @Override
        public void onAnimationStart(Animation animation) {
        }

        @Override
        public void onAnimationEnd(Animation animation) {
            mRootView.removeView(splashView);
            splashView = null;
        }

        @Override
        public void onAnimationRepeat(Animation animation) {
        }
    });
}
```

上述方法，中加入了一个淡出动画持续1s，目的是让欢迎界面和其他界面之间过度自然些。
做到这里还不够，因为我们需要在js中调用`hide`方法还控制欢迎界面的关闭。js不能直接调Java，所有我们需要为他们搭建一个桥梁([Native Modules](https://facebook.github.io/react-native/docs/native-modules-android.html))。  

**首先，创建一个`ReactContextBaseJavaModule`类型的类，供js调用。**   

```java
/**
 * LaunchScreenModule
 * 出自：http://www.cboy.me
 * GitHub:https://github.com/crazycodeboy
 * Eamil:crazycodeboy@gmail.com
 */
public class LaunchScreenModule extends ReactContextBaseJavaModule{
    public LaunchScreenModule(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    @Override
    public String getName() {
        return "LaunchScreen";
    }
    @ReactMethod
    public void hide(){
        getCurrentActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                ((ReactActivity)getCurrentActivity()).hide();
            }
        });

    }
}
```

**其次，创建一个`ReactPackage`类型的类，用于向React Native注册我们的`LaunchScreenModule`组件。**

```java
/**
 * LaunchScreenReactPackage
 * 出自：http://www.cboy.me
 * GitHub:https://github.com/crazycodeboy
 * Eamil:crazycodeboy@gmail.com
 */
public class LaunchScreenReactPackage implements ReactPackage {

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
        modules.add(new LaunchScreenModule(reactContext));
        return modules;
    }
}
```

**再次，在MainApplication中注册`LaunchScreenModule`组件。**   

```java
@Override
protected List<ReactPackage> getPackages() {
    return Arrays.<ReactPackage>asList(
            new MainReactPackage(),
            new LaunchScreenReactPackage()
    );
}
```

**最后，在js中调用LaunchScreenModule。**

创建一个名为`LaunchScreen`的文件，加入下面代码。  

```JavaScript
/**
 * LaunchScreen
 * Android启动屏
 * 出自：http://www.cboy.me
 * GitHub:https://github.com/crazycodeboy
 * Eamil:crazycodeboy@gmail.com
 * @flow
 */
'use strict';

import { NativeModules } from 'react-native';
module.exports = NativeModules.LaunchScreen;
```

>上述代码，目的是向js暴露`LaunchScreen`模块。  

下面我们就可以在js中调用`LaunchScreen`的`hide()`方法来关闭启动屏了。  

```
LaunchScreen.hide();
```

不要忘记在使用LaunchScreen的js文件中导入它哦`import LaunchScreen from './LaunchScreen`。

到这里，React Native Android的启动白屏的原因，解决方案，原理，使用方法已经向大家介绍完了。大家如果还有什么疑问可以加群：`165774887`，和我一起讨论。   

另外，跟大家分享一个Android启动时闪现白屏或黑屏的解决方案。  
这个问题是Android主题的问题和React Native无关，请往下看。   

## 修改主题解决闪现白屏/黑屏   

### 问题描述：
市场上有很多应用，在启动的时候，会出现闪现黑屏或白屏，有的应用却没有。究其原因，是主题在搞鬼。

### 问题分析

当单击应用的图标时，Android会为被单击的应用创建一个进程，然后创建一个Application实例，然后应用主题，然后启动Activity。  
因为启动Activity也是需要时间的，这之间的时间间隔，便是闪现白屏或黑屏的时间。
  
### 解决方案   

为解决启动时闪现白屏或黑屏的问题，我们可以从主题下手，为应用创建一个透明的主题。    

**第一步：创建一个透明主题。**

```
<!-- Base application theme. -->
<style name="AppTheme" parent="Theme.AppCompat.Light.NoActionBar">    
    <!--设置透明背景-->
    <item name="android:windowIsTranslucent">true</item>
</style>
```  

**第二步：在AndroidManifest.xml中为application应用主题。**

```
 <application
      android:name=".MainApplication"
      android:allowBackup="true"
      android:label="@string/app_name"
      android:icon="@mipmap/ic_launcher"
      android:theme="@style/AppTheme">
```

这样一来，启动时变不会闪现黑屏或白屏了。  

>如果，你的应用需要一个特定的主题，但该主题不是透明的，你可以先将application的默认主题设置成透明的主题，然后在程序启动后（可以在启动页进行），通过`public void setTheme(int resid)`方法将主题设置成你想要的主题即可。

## 最后

**既然来了，留下个喜欢再走吧，鼓励我继续创作(^_^)∠※**   

**如果喜欢我的文章，那就关注我的[博客](http://www.cboy.me/)吧，让我们一起做朋友~~**

#### 戳这里,加关注哦:   

>**[微博](http://weibo.com/u/6003602003)：第一时间获取推送**    
**[个人博客](http://www.cboy.me/)：干货文章都在这里哦**  
**[GitHub](https://github.com/crazycodeboy/)：我的开源项目**     


