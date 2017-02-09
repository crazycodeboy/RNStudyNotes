
# React Native应用部署/热更新-CodePush最新集成总结(新)
本文出自[《React Native学习笔记》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。  
了解更多，可以[关注我的GitHub](https://github.com/crazycodeboy/)和加入：  
[React Native学习交流群](http://jq.qq.com/?_wv=1027&k=2IBHgLD)     
![React Native学习交流群](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%8F%91%E5%B8%83APP%E4%B9%8B%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85APK/images/react%20native%20%E5%AD%A6%E4%B9%A0%E4%BA%A4%E6%B5%81%E7%BE%A4_qrcode_share.png)

-------

>更新说明：
此次博文更新适配了最新版的CodePush v1.17.0；添加了iOS的集成方式与调试技巧；添加了更为简洁的CodePush发布更新的方式以及进行了一些其他的优化。

React Native的出现为移动开发领域带来了两大革命性的创新：  
1. 整合了移动端APP的开发，不仅缩短了APP的开发时间，也提高了APP的开发效率。  
2. 为移动APP动态更新提供了基础。    

本文将向大家分享React Natvie应用部署/动态更新方面的内容。    

React Native支持大家用React Native技术开发APP，并打包生成一个APP。在动态更新方面React Native只是提供了动态更新的基础，对将应用部署到哪里，如何进行动态更新并没有支持的那么完善。好在微软开发了CodePush，填补React Native 应用在动态更新方面的空白。CodePush 是微软提供的一套用于热更新 React Native 和 Cordova 应用的服务。下面将向大家分享如何使用CodePush实时更新你的应用，后期会分享不采用CodePush，如何自己去实现React Native应用热更新。  

## CodePush简介
CodePush 是微软提供的一套用于热更新 React Native 和 Cordova 应用的服务。  
CodePush 是提供给 React Native 和 Cordova 开发者直接部署移动应用更新给用户设备的云服务。CodePush 作为一个中央仓库，开发者可以推送更新 (JS, HTML, CSS and images)，应用可以从客户端 SDK 里面查询更新。CodePush 可以让应用有更多的可确定性，也可以让你直接接触用户群。在修复一些小问题和添加新特性的时候，不需要经过二进制打包，可以直接推送代码进行实时更新。    

CodePush 可以进行实时的推送代码更新：     

* 直接对用户部署代码更新  
* 管理 Alpha，Beta 和生产环境应用  
* 支持 React Native 和 Cordova  
* 支持JavaScript 文件与图片资源的更新


CodePush开源了react-native版本，[react-native-code-push](https://github.com/Microsoft/react-native-code-push)托管在GitHub上。

## 安装与注册CodePush    
使用CodePush之前首先要安装CodePush客户端。本文以OSX 10.11.5作为平台进行演示。    

### 安装 CodePush CLI
管理 CodePush 账号需要通过 NodeJS-based CLI。   
只需要在终端输入 `npm install -g code-push-cli`，就可以安装了。  
安装完毕后，输入 `code-push -v`查看版本，如看到版本代表成功。   
![安装 CodePush CLI成功](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/安装 CodePush CLI成功.png)    
目前我的版本是 1.12.1-beta   

**PS.**  
`npm`为NodeJS的包管理器，如果你没安装NodeJS请先安装。  

### 创建一个CodePush 账号
在终端输入`code-push register`，会打开如下注册页面让你选择授权账号。  
![注册codepush](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/注册codepush.png)  
授权通过之后，CodePush会告诉你“access key”，复制此key到终端即可完成注册。  
![获取codepush access key](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/获取codepush access key.png)  
然后终端输入`code-push login`进行登陆，登陆成功后，你的session文件将会写在 /Users/你的用户名/.code-push.config。  
![登陆成功](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/登陆成功.png)

**PS.相关命令**  

* `code-push login` 登陆  
* `code-push loout` 注销  
* `code-push access-key ls` 列出登陆的token  
* `code-push access-key rm <accessKye>` 删除某个 access-key  

### 在CodePush服务器注册app  
为了让CodePush服务器知道你的app，我们需要向它注册app： 在终端输入`code-push app add <appName>`即可完成注册。

![code-push-add-app](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93/images/code-push-add-app.png)

注册完成之后会返回一套deployment key，该key在后面步骤中会用到。

>心得：如果你的应用分为Android和iOS版，那么在向CodePush注册应用的时候需要注册两个App获取两套deployment key，如：

```
code-push app add MyApp-Android
code-push app add MyApp-iOS
```

**PS.相关命令**   

* `code-push app add` 在账号里面添加一个新的app  
* `code-push app remove` 或者 rm 在账号里移除一个app  
* `code-push app rename` 重命名一个存在app  
* `code-push app list` 或则 ls 列出账号下面的所有app  
* `code-push app transfer` 把app的所有权转移到另外一个账号  

## 集成CodePush SDK  

### Android   
下面我们通过如下步骤在Android项目中集成CodePush。  
第一步：在项目中安装 react-native-code-push插件，终端进入你的项目根目录然后运行  
`npm install --save react-native-code-push`

第二步：在Android project中安装插件。  
CodePush提供了两种方式：RNPM 和 Manual，本次演示所使用的是RNPM。  
运行`npm i -g rnpm`，来安装RNPM。

>在React Native v0.27及以后版本RNPM已经被集成到了 React Native CL中，就不需要再进行安装了。

第三步： 运行 `rnpm link react-native-code-push`。这条命令将会自动帮我们在anroid文件中添加好设置。

![react-native-code-push has been successfully linked](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93/images/react-native-code-push%20has%20been%20successfully%20linked.png)  

>在终端运行此命令之后，终端会提示让你输入deployment key，这是你只需将你的deployment Staging key输入进去即可，如果不输入则直接单击enter跳过即可。

第四步： 在 android/app/build.gradle文件里面添如下代码：

```  
apply from: "../../node_modules/react-native-code-push/android/codepush.gradle"  
```
然后在/android/settings.gradle中添加如下代码:

```
include ':react-native-code-push'
project(':react-native-code-push').projectDir = new File(rootProject.projectDir, '../node_modules/react-native-code-push/android/app')
```

第五步: 运行 `code-push deployment -k ls <appName>`获取 部署秘钥。默认的部署名是 staging，所以 部署秘钥（deployment key ） 就是 staging。   
第六步： 添加配置。当APP启动时我们需要让app向CodePush咨询JS bundle的所在位置，这样CodePush就可以控制版本。更新 MainApplication.java文件：    

```java
public class MainApplication extends Application implements ReactApplication {
  private final ReactNativeHost mReactNativeHost = new ReactNativeHost(this) {
    @Override
    protected boolean getUseDeveloperSupport() {
      return BuildConfig.DEBUG;
    }
    @Override
    protected String getJSBundleFile() {
      return CodePush.getJSBundleFile();
    }
    @Override
    protected List<ReactPackage> getPackages() {
      // 3. Instantiate an instance of the CodePush runtime and add it to the list of
      // existing packages, specifying the right deployment key. If you don't already
      // have it, you can run "code-push deployment ls <appName> -k" to retrieve your key.
      return Arrays.<ReactPackage>asList(
        new MainReactPackage(),
        new CodePush("deployment-key-here", MainApplication.this, BuildConfig.DEBUG)
      );
    }
  };
  @Override
  public ReactNativeHost getReactNativeHost() {
      return mReactNativeHost;
  }
}
```

**关于deployment-key的设置**

在上述代码中我们在创建CodePush实例的时候需要设置一个deployment-key,因为deployment-key分生产环境与测试环境两种,所以建议大家在build.gradle中进行设置。在build.gradle中的设置方法如下:

打开android/app/build.gradle文件,找到`android { buildTypes {} }`然后添加如下代码即可:

```
android {
    ...
    buildTypes {
        debug {
            ...
            // CodePush updates should not be tested in Debug mode
            ...
        }

        releaseStaging {
            ...
            buildConfigField "String", "CODEPUSH_KEY", '"<INSERT_STAGING_KEY>"'
            ...
        }

        release {
            ...
            buildConfigField "String", "CODEPUSH_KEY", '"<INSERT_PRODUCTION_KEY>"'
            ...
        }
    }
    ...
}
```

>心得:另外,我们也可以将deployment-key存放在local.properties中:

```
code_push_key_production=erASzHa1-wTdODdPJDh6DBF2Jwo94JFH08Kvb
code_push_key_staging=mQY75RkFbX6SiZU1kVT1II7OqWst4JFH08Kvb
```
如图:
![local.properties存放codepush-key](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93/images/local.properties%E5%AD%98%E6%94%BEcodepush-key.png)
然后在就可以在android/app/build.gradle可以通过下面方式来引用它了:

```
Properties properties = new Properties()
properties.load(project.rootProject.file('local.properties').newDataInputStream())
android {
    ...
    buildTypes {
        debug {
            ...
            // CodePush updates should not be tested in Debug mode
            ...
        }

        releaseStaging {
            ...
            buildConfigField "String", "CODEPUSH_KEY", '"'+properties.getProperty("code_push_key_production")+'"'
            ...
        }

        release {
            ...
            buildConfigField "String", "CODEPUSH_KEY", '"'+properties.getProperty("code_push_key_staging")+'"'
            ...
        }
    }
    ...
}
```


在android/app/build.gradle设置好deployment-key之后呢,我们就可以这样使用了:

```
@Override
protected List<ReactPackage> getPackages() {
     return Arrays.<ReactPackage>asList(
         ...
         new CodePush(BuildConfig.CODEPUSH_KEY, MainApplication.this, BuildConfig.DEBUG), // Add/change this line.
         ...
     );
}
```



第七步：修改versionName。  
在 android/app/build.gradle中有个 android.defaultConfig.versionName属性，我们需要把 应用版本改成 1.0.0（默认是1.0，但是codepush需要三位数）。

```
android{
    defaultConfig{
        versionName "1.0.0"
    }
}
```   
至此Code Push for Android的SDK已经集成完成。   

### iOS  

CodePush官方提供RNPM、CocoaPods与手动三种在iOS项目中集成CodePush的方式，接下来我就以RNPM的方式来讲解一下如何在iOS项目中集成CodePush。

第一步：在项目中安装react-native-code-push插件，终端进入你的项目根目录然后运行

```
npm install --save react-native-code-push
```
第二步： 运行 `rnpm link react-native-code-push`。这条命令将会自动帮我们在ios中添加好设置。

>在终端运行此命令之后，终端会提示让你输入deployment key，这是你只需将你的deployment Staging key输入进去即可，如果不输入则直接单击enter跳过即可。

**关于deployment-key的设置**

在我们想CodePush注册App的时候，CodePush会给我们两个deployment-key分别是在生产环境与测试环境时使用的，我们可以通过如下步骤来设置deployment-key。

1.用Xcode 打开项目 ➜ Xcode的项目导航视图中的`PROJECT`下选择你的项目 ➜ 选择Info页签 ➜ 在`Configurations`节点下单击 + 按钮 ➜ 选择`Duplicate "Release`  ➜ 输入Staging(名称可以自定义)；
![Duplicate-Release-Staging.png](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93/images/Duplicate-Release-Staging.png)

2.然后选择`Build Settings`页签 ➜ 单击 + 按钮然后选择添加`User-Defined Setting` 

![添加User-Defined-Setting](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93/images/%E6%B7%BB%E5%8A%A0User-Defined-Setting.png)

3.然后输入CODEPUSH_KEY(名称可以自定义)

![设置Staging deployment key](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93/images/%E8%AE%BE%E7%BD%AEStaging%20deployment%20key.png)

>提示：你可以通过`code-push deployment ls <APP_NAME> -k`命令来查看deployment key。

4.打开 Info.plist文件，在CodePushDeploymentKey列的Value中输入`$(CODEPUSH_KEY)`

![引用CODEPUSH_KEY](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93/images/%E5%BC%95%E7%94%A8CODEPUSH_KEY.png)

到目前为止，iOS的设置已经完成了，和在Android上的集成相比是不是简单了很多呢。

## 使用CodePush进行热更新  

### 设置更新策略
在使用CodePush更新你的应用之前需要，先配置一下更新控制策略，即：  

* 什么时候检查更新？（在APP启动的时候？在设置页面添加一个检查更新按钮？）
* 什么时候可以更新，如何将更新呈现给终端用户？  

最简单的方式是在根component中进行上述策略控制。  
1. 在 js中加载 CodePush模块：   
`import codePush from 'react-native-code-push'`   
2.在 `componentDidMount`中调用 `sync`方法，后台请求更新  
`codePush.sync()`   

如果可以进行更新，CodePush会在后台静默地将更新下载到本地，等待APP下一次启动的时候应用更新，以确保用户看到的是最新版本。  
如果更新是强制性的，更新文件下载好之后会立即进行更新。    
如果你期望更及时的获得更新，可以在每次APP从后台进入前台的时候去主动的检查更新：  
在应用的根component的`componentDidMount`中添加如下代码：  

```
AppState.addEventListener("change", (newState) => {
    newState === "active" && codePush.sync();
});
```

### 发布更新

CodePush支持两种发布更新的方式，一种是通过`code-push release-react`简化方式，另外一种是通过`code-push release`的复杂方式。

>第一种方式：通过`code-push release-react`发布更新

这种方式将打包与发布两个命令合二为一，可以说大大简化了我们的操作流程，建议大家多使用这种方式来发布更新。

命令格式：

```
code-push release-react <appName> <platform>
```

eg:

```
code-push release-react MyApp-iOS ios
code-push release-react MyApp-Android android
```
再来个更高级的：

```
code-push release-react MyApp-iOS ios  --t 1.0.0 --dev false --d Production --des "1.优化操作流程" --m true
```
其中参数--t为二进制(.ipa与apk)安装包的的版本；--dev为是否启用开发者模式(默认为false)；--d是要发布更新的环境分Production与Staging(默认为Staging)；--des为更新说明；--m 是强制更新。

关于`code-push release-react`更多可选的参数，可以在终端输入`code-push release-react`进行查看。

另外，我们可以通过`code-push deployment ls <appName>`来查看发布详情与此次更新的安装情况。

>第二中方式：通过`code-push release`发布更新

`code-push release`发布更新呢我们首先需要将js与图片资源进行打包成 bundle。

#### 生成bundle  
发布更新之前，需要先把 js打包成 bundle，如：

第一步： 在 工程目录里面新增 bundles文件：`mkdir bundles`

第二步： 运行命令打包 `react-native bundle --platform 平台 --entry-file 启动文件 --bundle-output 打包js输出文件 --assets-dest 资源输出目录 --dev 是否调试`。   
eg:    
`react-native bundle --platform android --entry-file index.android.js --bundle-output ./bundles/index.android.bundle --dev false`   

![生成bundle](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/生成bundle包.png)

**需要注意的是：**  

* 忽略了资源输出是因为 输出资源文件后，会把bundle文件覆盖了。
* 输出的bundle文件名不叫其他，而是 index.android.bundle，是因为 在debug模式下，工程读取的bundle就是叫做 index.android.bundle。
* 平台可以选择 android 或者 ios。  

### 发布更新  
打包bundle结束后，就可以通过CodePush发布更新了。在终端输入   
`code-push release <应用名称> <Bundles所在目录> <对应的应用版本> --deploymentName： 更新环境
--description： 更新描述  --mandatory： 是否强制更新`   
eg:  
`code-push release GitHubPopular ./bundles/index.android.bundle 1.0.6 --deploymentName Production  --description "1.支持文章缓存。" --mandatory true`
![推送更新到CodePush](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/推送更新到CodePush.png)

**注意：**  
1. CodePush默认是更新 staging 环境的，如果是staging，则不需要填写 deploymentName。     
2. 如果有 mandatory 则Code Push会根据mandatory 是true或false来控制应用是否强制更新。默认情况下mandatory为false即不强制更新。      
3. 对应的应用版本（targetBinaryVersion）是指当前app的版本(对应build.gradle中设置的versionName "1.0.6")，也就是说此次更新的js/images对应的是app的那个版本。不要将其理解为这次js更新的版本。
如客户端版本是 1.0.6，那么我们对1.0.6的客户端更新js/images，targetBinaryVersion填的就是1.0.6。     
4. 对于对某个应用版本进行多次更新的情况，CodePush会检查每次上传的 bundle，如果在该版本下如1.0.6已经存在与这次上传完全一样的bundle(对应一个版本有两个bundle的md5完全一样)，那么CodePush会拒绝此次更新。
如图：  
![对应一个版本有两个bundle的md5完全一样](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/对应一个版本有两个bundle的md5完全一样.png)    

所以如果我们要对某一个应用版本进行多次更新，只需要上传与上次不同的bundle/images即可。如：  
eg:    
对1.0.6的版本进行第一次更新：    
`code-push release GitHubPopular ./bundles/index.android.bundle 1.0.6 --deploymentName Production  --description "1.支持文章缓存。" --mandatory true`    
对1.0.6的版本进行第二次更新：     
`code-push release GitHubPopular ./bundles/index.android.bundle 1.0.6 --deploymentName Production  --description "1.新添加收藏功能。" --mandatory true`      
5. 在终端输入 `code-push deployment history <appName> Staging` 可以看到Staging版本更新的时间、描述等等属性。     
eg:  
`code-push release Equipment ./bundles 1.0.1`

下面我们启动事先安装好的应用，看有什么反应：  
![提示更新](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/提示更新.png)  
应用启动之后，从CodePush服务器查询更新，并下载到本地，下载好之后，提示用户进行更新。这就是CodePush用于热更新的整个过程。  


**更多部署APP相关命令**

* code-push deployment add <appName> 部署  
* code-push deployment rename <appName> 重命名  
* code-push deployment rm <appName> 删除部署  
* code-push deployment ls <appName> 列出应用的部署情况  
* code-push deployment ls <appName> -k 查看部署的key  
* code-push deployment history <appName> <deploymentNmae> 查看历史版本(Production 或者 Staging)  

### 调试技巧  
如果你用模拟器进行调试CodePush，在默认情况下是无法达到调试效果的，因为在开发环境下装在模拟器上的React Native应用每次启动时都会从NodeJS服务器上获取最新的bundle，所以还没等CodePush从服务器将更新包下载下来时，APP就已经从NodeJS服务器完成了更新。

**Android**

为规避这个问题在Android可以将开发环境的调试地址改为一个不可用的地址，如下图：

![解决NodeJS对CodePush的影响](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native应用部署、热更新-CodePush最新集成总结/images/解决NodeJS对CodePush的影响.png)  
这样APP就无法连接到NodeJS服务器了，自然也就不能从NodeJS服务器下载bundle进行更新了，它也只能乖乖的等待从CodePush服务器下载更新包进行更新了。   

**iOS**

在iOS中我们需要上文中讲到的[生成bundle](#生成bundle)，将bundle包与相应的图片资源拖到iOS项目中如图：

![导入bundle到xcode](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%BA%94%E7%94%A8%E9%83%A8%E7%BD%B2%E3%80%81%E7%83%AD%E6%9B%B4%E6%96%B0-CodePush%E6%9C%80%E6%96%B0%E9%9B%86%E6%88%90%E6%80%BB%E7%BB%93/images/%E5%AF%BC%E5%85%A5bundle%E5%88%B0xcode.png)

然后呢，我们需要在AppDelegate.m中进行如下修改：

```
//#ifdef DEBUG
//    jsCodeLocation = [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
//#else
    jsCodeLocation = [CodePush bundleURL];
//#endif
```
让React Native通过CodePush去获取bundle包即可。


## JavaScript API Reference

* allowRestart
* checkForUpdate
* disallowRestart
* getUpdateMetadata
* notifyAppReady
* restartApp
* sync

其实我们可以将这些API分为两类，一类是自动模式，一类是手动模式。  

### 自动模式
`sync`为自动模式，调用此方法CodePush会帮你完成一系列的操作。其它方法都是在手动模式下使用的。    
**codePush.sync**     
`codePush.sync(options: Object, syncStatusChangeCallback: function(syncStatus: Number),
downloadProgressCallback: function(progress: DownloadProgress)): Promise<Number>;`  
通过调用该方法CodePush会帮我们自动完成检查更新，下载，安装等一系列操作。除非我们需要自定义UI表现，不然直接用这个方法就可以了。    
**sync方法，提供了如下属性以允许你定制sync方法的默认行为**  

* deploymentKey （String）： 部署key，指定你要查询更新的部署秘钥，默认情况下该值来自于Info.plist(Ios)和MianActivity.java(Android)文件，你可以通过设置该属性来动态查询不同部署key下的更新。
* installMode (codePush.InstallMode)： 安装模式，用在向CodePush推送更新时没有设置强制更新(mandatory为true)的情况下，默认codePush.InstallMode.ON_NEXT_RESTART即下一次启动的时候安装。  
* mandatoryInstallMode (codePush.InstallMode):强制更新,默认codePush.InstallMode.IMMEDIATE。
* minimumBackgroundDuration (Number):该属性用于指定app处于后台多少秒才进行重启已完成更新。默认为0。该属性只在`installMode`为`InstallMode.ON_NEXT_RESUME`情况下有效。  
* updateDialog (UpdateDialogOptions) :可选的，更新的对话框，默认是null,包含以下属性
	* appendReleaseDescription (Boolean) - 是否显示更新description，默认false
	* descriptionPrefix (String) - 更新说明的前缀。 默认是” Description: “
	* mandatoryContinueButtonLabel (String) - 强制更新的按钮文字. 默认 to “Continue”.
	* mandatoryUpdateMessage (String) - 强制更新时，更新通知. Defaults to “An update is available that must be installed.”.
	* optionalIgnoreButtonLabel (String) - 非强制更新时，取消按钮文字. Defaults to “Ignore”.
	* optionalInstallButtonLabel (String) - 非强制更新时，确认文字. Defaults to “Install”.
	* optionalUpdateMessage (String) - 非强制更新时，更新通知. Defaults to “An update is available. Would you like to install it?”.
	* title (String) - 要显示的更新通知的标题. Defaults to “Update available”.

eg:  

```javascript  
codePush.sync({
      updateDialog: {
        appendReleaseDescription: true,
        descriptionPrefix:'\n\n更新内容：\n',
        title:'更新',
        mandatoryUpdateMessage:'',
        mandatoryContinueButtonLabel:'更新',
      },
      mandatoryInstallMode:codePush.InstallMode.IMMEDIATE,
      deploymentKey: CODE_PUSH_PRODUCTION_KEY,
    });
```   


### 手动模式
**codePush.allowRestart**

`codePush.allowRestart(): void;`    
允许重新启动应用以完成更新。   
如果一个CodePush更新将要发生并且需要重启应用(e.g.设置了InstallMode.IMMEDIATE模式)，但由于调用了`disallowRestart`方法而导致APP无法通过重启来完成更新，
可以调用此方法来解除`disallowRestart`限制。  
但在如下四种情况下，CodePush将不会立即重启应用：  
1. 自上一次`disallowRestart`被调用，没有新的更新。  
2. 有更新，但`installMode`为`InstallMode.ON_NEXT_RESTART`的情况下。  
3. 有更新，但`installMode`为`InstallMode.ON_NEXT_RESUME`，并且程序一直处于前台，并没有从后台切换到前台的情况下。   
4. 自从上次`disallowRestart`被调用，没有再调用`restartApp`。

**codePush.checkForUpdate**

`codePush.checkForUpdate(deploymentKey: String = null): Promise<RemotePackage>;`  
向CodePush服务器查询是否有更新。  
该方法返回Promise，有如下两种值：  

* null 没有更新   
通常有如下情况导致RemotePackage为null:  
	1. 当前APP版本下没有部署新的更新版本。也就是说没有想CodePush服务器推送基于当前版本的有关更新。  
	2. CodePush上的更新和用户当前所安装的APP版本不匹配。也就是说CodePush服务器上有更新，但该更新对应的APP版本和用户安装的当前版本不对应。  
	3. 当前APP已将安装了最新的更新。  
	4. 部署在CodePush上可用于当前APP版本的更新被标记成了不可用。  
	5. 部署在CodePush上可用于当前APP版本的更新是"active rollout"状态，并且当前的设备不在有资格更新的百分比的设备之内。  

*  A RemotePackage instance  
有更新可供下载。    

eg：

```javascript
codePush.checkForUpdate()
.then((update) => {
    if (!update) {
        console.log("The app is up to date!");
    } else {
        console.log("An update is available! Should we download it?");
    }
});  
```

**codePush.disallowRestart**

`codePush.disallowRestart(): void;`  
不允许立即重启用于以完成更新。    
eg:  

```javascript
class OnboardingProcess extends Component {
    ...

    componentWillMount() {
        // Ensure that any CodePush updates which are
        // synchronized in the background can't trigger
        // a restart while this component is mounted.
        codePush.disallowRestart();
    }

    componentWillUnmount() {
        // Reallow restarts, and optionally trigger
        // a restart if one was currently pending.
        codePush.allowRestart();
    }

    ...
}
```

**codePush.getUpdateMetadata**  
`codePush.getUpdateMetadata(updateState: UpdateState = UpdateState.RUNNING): Promise<LocalPackage>;`  
获取当前已安装更新的元数据（描述、安装时间、大小等）。  
eg:  

```javascript
// Check if there is currently a CodePush update running, and if
// so, register it with the HockeyApp SDK (https://github.com/slowpath/react-native-hockeyapp)
// so that crash reports will correctly display the JS bundle version the user was running.
codePush.getUpdateMetadata().then((update) => {
    if (update) {
        hockeyApp.addMetadata({ CodePushRelease: update.label });
    }
});

// Check to see if there is still an update pending.
codePush.getUpdateMetadata(UpdateState.PENDING).then((update) => {
    if (update) {
        // There's a pending update, do we want to force a restart?
    }
});
```  

**codePush.notifyAppReady**  
`codePush.notifyAppReady(): Promise<void>;`  
通知CodePush，一个更新安装好了。当你检查并安装更新，（比如没有使用sync方法去handle的时候），这个方法必须被调用。否则CodePush会认为update失败，并rollback当前版本，在app重启时。  
当使用`sync`方法时，不需要调用本方法，因为`sync`会自动调用。   

**codePush.restartApp**  
`codePush.restartApp(onlyIfUpdateIsPending: Boolean = false): void;`  
立即重启app。
当以下情况时，这个方式是很有用的：   
1. app 当 调用 `sync` 或 `LocalPackage.install` 方法时，指定的 `install mode `是 `ON_NEXT_RESTART` 或 `ON_NEXT_RESUME时` 。 这两种情况都是当app重启或`resume`时，更新内容才能被看到。   
2. 在特定情况下，如用户从其它页面返回到APP的首页时，这个时候调用此方法完成过更新对用户来说不是特别的明显。因为强制重启，能马上显示更新内容。  




## 总结  
上文已经介绍了CodePush在动态更新方面的一些特性，但CodePush也存在着一些缺点：  
1. 服务器在国外，在国内访问，网速不是很理想。   
2. 其升级服务器端程序并不开源的，后期微软会不会对其收费还是个未知数。     
如果在没有更好的动态更新React Native应用的方案的情况下，并且这些问题还在你的接受范围之内的话，那么CodePush可以作为动态更新React Native应用的一种选择。  
后期会向大家分享不采用CodePush，自己搭建服务器并实现React Native应用的动态更新相关的方案。  

**参考：**   
http://microsoft.github.io/code-push/docs/getting-started.html   
https://github.com/Microsoft/react-native-code-push   
