
本文出自:([React Native 研究与实践](https://github.com/crazycodeboy/RNStudyNotes))


>项目源码下载：[GitHub Popular](https://github.com/crazycodeboy/GitHubPopular)

喜欢逛GitHub的小伙伴都知道，它有个查看最热项目的功能叫[trending](https://github.com/trending)，但这个功能只能在网页上查看，
而且在手机上浏览显示效果很不友好，而我想在地铁上，餐厅，路上等空余的时间使用它，所以我需要一款带有这个功能的App，
不仅于此，我还想要在这款App上查询GitHub上我所喜欢的项目，甚至在手机没网的时候也能看到，而且我想要我的iOS和Android手机都能使用这款App，
于是[GitHub Popular](https://github.com/crazycodeboy/GitHubPopular)便诞生了。

>这个项目满足了我如下3方面的需求：

1. 在手机App上也可以使用GitHub 的[trending](https://github.com/trending)功能来查看最热最火的开源项目。
2. 在手机App上也可以搜索GitHub上的开源项目，并且可以进行查看、收藏、分享等操作。
3. 可以订阅我所喜欢的标签或语言，让感兴趣的热门项目一个不漏。

![githubpupular](https://raw.githubusercontent.com/crazycodeboy/Resources-Blog/master/images/2016/10/githubpupular.png)

## 开发环境及工具

### 环境：

* OSX:10.11.6 
* Node.js:6.3.1
* react-native:0.32.0

### 工具：

* Git
* WebStorm
* AndroidStudio
* Xcode


## 所用技术与第三方库

### 所用技术

* ES5/ES6
* React
* Flexbox
* AsyncStorage
* fetch api
* Native Modules

### 第三方工具

* react-native-check-box
* react-native-easy-toast
* react-native-splash-screen
* react-native-htmlview
* react-native-parallax-scroll-view
* react-native-scrollable-tab-view
* react-native-sortable-listview
* react-native-tab-navigator


## 功能流程图

![GitHub Popular-功能结构图](https://raw.githubusercontent.com/crazycodeboy/Resources-Blog/master/images/2016/10/GitHub%20Popular-%E5%8A%9F%E8%83%BD%E7%BB%93%E6%9E%84%E5%9B%BE.png)

## 总结

此项目是基于目前比较火的React Native技术架构的，也用到一些Android和iOS技术，其中Android、iOS两端代码复用率有90%之多，该项目占据我不少业余时间，不过总算研发完成，并成功上架。在此过程中填了不少的坑，包括GitHub没有开放[trending](https://github.com/trending)的Api，需要自己动手实现它，以及自定义主题等等，后期有时间会整理出来分享给大家。

[GitHub Popular](https://github.com/crazycodeboy/GitHubPopular)的Android版本已上架，大家可以从[百度手机助手](http://shouji.baidu.com/software/10123273.html)，[应用宝](http://sj.qq.com/myapp/detail.htm?apkName=com.jph.githubpopular)上下载使用，iOS版就差一个99刀的账号就可以上架了，囊中羞涩呜呜~~~~。项目开源在[GitHub](https://github.com/crazycodeboy/GitHubPopular)上供热爱移动开发的小伙伴学习研究，喜欢的小伙伴不要忘记点个赞支持一下哦。

## 最后

**既然来了，留下个喜欢再走吧，鼓励我继续创作(^_^)∠※**   

**如果喜欢我的文章，那就关注我的[博客](http://www.devio.org/)@ [devio.org](http://www.devio.org)吧，让我们一起做朋友~~**

#### 戳这里,加关注哦:   

>**[微博](http://weibo.com/u/6003602003)：第一时间获取推送**    
**[个人博客](http://www.devio.org/)：干货文章都在这里哦**  
**[GitHub](https://github.com/crazycodeboy/)：我的开源项目**   



