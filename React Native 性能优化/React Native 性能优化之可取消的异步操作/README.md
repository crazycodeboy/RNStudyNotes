# [React Native 性能优化之可取消的异步操作](https://github.com/crazycodeboy/RNStudyNotes/)  

本文出自[《React Native 研究与实践》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。

## 概述
在项目开发中离不了的需要进行一些异步操作，这些异步操作在改善用户体验的同时也带来了一些性能隐患。
比如，在某页面进行异步操作，异步操作还没有完成时，该页面已经关闭，这时由于异步操作的存在，导致系统无法及时的回收资源，从而导致性能的降低，甚至出现oom。

总而言之，异步操作在改善用户体验，增强系统灵活性的同时也带来了一些性能隐患，如果使用不当则会带来一些副作用。   

那么如何在使用异步操作的同时规避它所带来的副作用呢？     

问题不是出在异步操作上，异步操作本没有错，错在异步操作的不合理使用上。比如，页面已经关闭了，而页面的异步操作还在进行等使用问题。
所以我们需要在编程中学会“舍得”，在适当的时候去取消一些异步操作。  
    

## 为Promise插上可取消的翅膀  

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

上述方法，可以为异步操作添加可取消的功能，但是使用还是不够方便：在每个使用`makeCancelable`的页面都需要复制粘贴上述代码。   
下面我们做一下改进，将上述代码抽离到一个文件中。   

 ```javascript
 /**
 * Cancelable
 * GitHub:https://github.com/crazycodeboy
 * Eamil:crazycodeboy@gmail.com 
 * @flow
 **/
'use strict'

export default function makeCancelable(promise){
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
}
```

这样在使用的时候只需要将makeCancelable导入到你的相应js文件中就可以了。   

```javascript
import makeCancelable from '../util/Cancelable'
```

## 可取消的网络请求fetch

`fetch`是React Native开发过程中最常用的网络请求API，和`Promis`一样，fetch也没有提供用于取消已发出的网络请求的API。因为fetch返回的是一个`Promise`，所以我们可以借助上述方法，来取消fetch所发出的网络请求。  

```JavaScript
this.cancelable = makeCancelable(fetch('url')));
        this.cancelable.promise
            .then((response)=>response.json())
            .then((responseData)=> {          
                console.log(responseData);                            
            }).catch((error)=> {
                console.log(error); 
            });
```

取消网络请求：    

`this.cancelable.cancel();`

## 在项目中的使用

为了提高React Native应用的性能，我们需要在组件卸载的时候不仅要主动释放掉所持有的资源，也要取消所发出的一些异步请求操作。    

```JavaScript
componentWillUnmount() {      
  this.cancelable.cancel();
}
```    

## About
本文出自[《[React Native 研究与实践》](https://github.com/crazycodeboy/RNStudyNotes)栏目。  

#### 这里有你需要的干货:   

>**[微博](http://weibo.com/u/6003602003)：第一时间获取推送**    
**[个人博客](http://jiapenghui.com)：你需要的，才是干货**  
**[GitHub](https://github.com/crazycodeboy/)：我的开源项目**     


推荐阅读
----
  
* [React Native 学习资源精选仓库](https://github.com/crazycodeboy/react-native-awesome)：汇集了各类react-native学习资料、工具、组件、开源App、资源下载、以及相关新闻等。
* [React Native 每日一学](https://github.com/crazycodeboy/RNStudyNotes/tree/master/React%20Native%20%E6%AF%8F%E6%97%A5%E4%B8%80%E5%AD%A6)：汇聚知识，分享精华。


