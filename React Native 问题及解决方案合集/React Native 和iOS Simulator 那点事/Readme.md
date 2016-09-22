# React Native 和iOS Simulator 那点事   

本文出自[《React Native学习笔记》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。

## 问题1：使用React Native时按cmd+r无法reload js，cmd+d无法唤起 React Native开发菜单？  

不知大家是否有过这样的经历，用 React Native开发应用正不亦乐乎的时候，突然发现，cmd+r，cmd+d快捷键在iOS Simulator上不起作用了，一时抓狂，不知道问题出在哪。

其实这个问题主要是由于iOS Simulator和键盘之间断开了连接导致的，也就是说iOS Simulator不在接受键盘的事件了（也不是完全不是受，至少cmd+shift+h它还是会响应的）。   

那么你肯定会问了，刚才还好好的，怎么突然间就断开连接了呢，我也没做什么啊？   

这是因为在iOS Simulator的Hardware菜单下的“Connect hardware keyboard”功能有个打开和关闭的快捷键“shift+cmd+k”,想想刚才是不是使用了这组快捷键了呢。   

![Connect hardware keyboard](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%20%E9%97%AE%E9%A2%98%E5%8F%8A%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88%E5%90%88%E9%9B%86/React%20Native%20%E5%92%8CiOS%20Simulator%20%E9%82%A3%E7%82%B9%E4%BA%8B/images/Connect%20hardware%20keyboard.png)   

>解决办法：将“Connect hardware keyboard”重新勾选上就好了。   

## 问题2：iOS Simulator的动画变得非常慢？   

为了方便开发者调试动画，iOS官方为iOS Simulator添加了一个可以“放慢动画”的功能叫“Slow Animation”，以方便开发者能更好的调试动画。   

![Slow Animation](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%20%E9%97%AE%E9%A2%98%E5%8F%8A%E8%A7%A3%E5%86%B3%E6%96%B9%E6%A1%88%E5%90%88%E9%9B%86/React%20Native%20%E5%92%8CiOS%20Simulator%20%E9%82%A3%E7%82%B9%E4%BA%8B/images/Slow%20Animation.png)

这个功能确实在调试动画的时候起了不少的作用，但不知情的开发者，当不小心打开了“Slow Animation”功能之后，发现APP所有的动画都变得非常慢，一时不解，是不是程序出什么问题了？难道摊上性能方面的事了？      

>解决办法：取消勾选iOS Simulator(模拟器)的Debug菜单下“Slow Animation”功能即可。


## 最后

**既然来了，留下个喜欢再走吧，鼓励我继续创作(^_^)∠※**   

**如果喜欢我的文章，那就关注我的[博客](http://www.cboy.me/)吧，让我们一起做朋友~~**

#### 戳这里,加关注哦:   

>**[微博](http://weibo.com/u/6003602003)：第一时间获取推送**    
**[个人博客](http://www.cboy.me/)：干货文章都在这里哦**  
**[GitHub](https://github.com/crazycodeboy/)：我的开源项目**     