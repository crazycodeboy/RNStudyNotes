# React Native发布APP之签名打包APK  
本文出自[《React Native学习笔记》](https://github.com/crazycodeboy/RNStudyNotes/)系列文章。  
了解更多，可以[关注我的GitHub](https://github.com/crazycodeboy/)和加入：  
[React Native学习交流群](http://jq.qq.com/?_wv=1027&k=2IBHgLD)     
![React Native学习交流群](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%8F%91%E5%B8%83APP%E4%B9%8B%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85APK/images/react%20native%20%E5%AD%A6%E4%B9%A0%E4%BA%A4%E6%B5%81%E7%BE%A4_qrcode_share.png)

-------


用React Native开发好APP之后，如何将APP发布以供用户使用呢？一款APP的发布流程无外乎：签名打包—>发布到各store这两大步骤。本文将向大家分享如何签名打包一款React Native APP。   


众所周知，Android要求所有的APP都需要进行数字签名后，才能够被安装到相应的设备上。签名打包一个Android APP已经是每一位Android开发者的家常便饭了。
那么如何签名打包一款用React Native开发的APP呢？  
既然Android Studio中可以进行APP的签名打包，那我们可不可以用它进行打包呢，实践表明用Android Studio打包React Native APP不是一种推荐的方案。

## 为什么不用Android Studio打包React Native APP?
在发这篇博文前我曾试着用Android Studio打包React Native APP，编译，打包，安装各项指数正常，当我欣喜在手机上打开APP看一下效果时，APP在启动时闪退了。多试几次依然如此，这时让我想起每次通过terminal安装APP到模拟器上时，`launchPackager.command`终端都会输出`http://localhost:8081/index.android.bundle?platform=android&dev=true&hot=false&minify=false`这样一行信息，然后APP在启动页加载一会才进入应用。通过浏览器访问上面的链接，发现链接返回的是一个js文件，打开该文件发现文件中的代码其实是我们写的 React Native 的 JS 代码。    
**PS.**   
1. 在开发环境下，每次启动APP,都会连接JS Server将项目中编写的js文件代码加载到APP(这也是React Native的动态更新的精髓)。   
2. 签名打包后的APK已经从开发环境变成了生产环境，自然不会在每次启动的时候连接JS Server加载相应的js文件。所以导致APP因缺少相应的js而无法启动。   

既然Android Stuio打包行不通，那么我们采用[React Native官方推荐的方式](http://facebook.github.io/react-native/docs/signed-apk-android.html)进行签名打包(下文会重点讲解“通过官方推荐的方式签名打包”)，打包过程很顺利，将打包好的APK安装到手机上后，发现能正常运行。   
对比用Android Studio签名打包生成的APK与用官方推荐方式签名打包生成的APK,发现了它们在大小上和内容上都有所差别，如图：  
**大小上的差别：**   
![两种打包方式apk大小差异.png](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%8F%91%E5%B8%83APP%E4%B9%8B%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85APK/images/%E4%B8%A4%E7%A7%8D%E6%89%93%E5%8C%85%E6%96%B9%E5%BC%8Fapk%E5%A4%A7%E5%B0%8F%E5%B7%AE%E5%BC%82.png)

对比两种打包方式发现，它们所生成的apk在大小上相差几百k。为什么会相差那么大呢，带着这个疑问我们就将两个apk解压之后看看他们内部具体有什么不同。   
**apk内部差别：**    
![两种方式签名打包的APK内部差别.png](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%8F%91%E5%B8%83APP%E4%B9%8B%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85APK/images/%E4%B8%A4%E7%A7%8D%E6%96%B9%E5%BC%8F%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85%E7%9A%84APK%E5%86%85%E9%83%A8%E5%B7%AE%E5%88%AB.png)

上图是解压之后apk的内部细节，发现通过官方推荐的方式打包的apk多了两个文件“index.android.bundle”与“index.android.bundle.meta”,打开“index.android.bundle”发现其和从`http://localhost:8081/index.android.bundle?platform=android&dev=true&hot=false&minify=false`获取的文件内容是一样的，都是我们写的 React Native 的 JS 代码。  

**结论**   
1. 在开发环境下，为方便调试，APP会在启动时从JS Server服务器将index.android.bundle文件加载到APP。  
2. 签名打包后的APP变成了生产环境，此时APP会默认从本地加载 index.android.bundle文件，由于通过Android Studio打包的APK没有将index.android.bundle打包进apk，所以会因缺少index.android.bundle而无法启动。     

## 通过官方推荐的方式签名打包APK

### 第一步：生成Android签名证书  
如果你已经有签名证书可以绕过此步骤。  
签名APK需要一个证书用于为APP签名，生成签名证书可以Android Studio以可视化的方式生成，也可以使用终端采用命令行的方式生成，需要的可以自行Google这里不再敖述。  

### 第二步：设置gradle变量   
1. 将你的签名证书copy到 android/app目录下。
2. 编辑`~/.gradle/gradle.properties`或`../android/gradle.properties`(一个是全局`gradle.properties`，一个是项目中的`gradle.properties`，大家可以根据需要进行修改) ，加入如下代码：     

```
MYAPP_RELEASE_STORE_FILE=your keystore filename  
MYAPP_RELEASE_KEY_ALIAS=your keystore alias  
MYAPP_RELEASE_STORE_PASSWORD=*****    
MYAPP_RELEASE_KEY_PASSWORD=*****  
```  
提示：用正确的证书密码、alias以及key密码替换掉 *****。

### 第三步：在gradle配置文件中添加签名配置   
编辑 android/app/build.gradle文件添加如下代码：  

```   
...  
android {  
    ...  
    defaultConfig { ... }  
    signingConfigs {  
        release {  
            storeFile file(MYAPP_RELEASE_STORE_FILE)  
            storePassword MYAPP_RELEASE_STORE_PASSWORD  
            keyAlias MYAPP_RELEASE_KEY_ALIAS  
            keyPassword MYAPP_RELEASE_KEY_PASSWORD  
        }  
    }  
    buildTypes {  
        release {  
            ...  
            signingConfig signingConfigs.release  
        }  
    }  
}  
...  
```

### 第四步：签名打包APK  
terminal进入项目下的android目录，运行如下代码：   
`./gradlew assembleRelease`   

![签名打包成功.png](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%8F%91%E5%B8%83APP%E4%B9%8B%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85APK/images/%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85%E6%88%90%E5%8A%9F.png)

签名打包成功后你会在 "android/app/build/outputs/apk/"目录下看到签名成功后的app-release.apk文件。  
提示：如果你需要对apk进行混淆打包 编辑android/app/build.gradle：   

```  
/**     
 * Run Proguard to shrink the Java bytecode in release builds.  
 */  
def enableProguardInReleaseBuilds = true  
```

## 如何在gradle中不使用明文密码？  
上文中直接将证书密码以明文的形式写在了gradle.properties文件中，虽然可以将此文件排除在版本控制之外，但也无法保证密码的安全，下面将向大家分享一种方法避免在gradle中直接使用明文密码。   

### 通过“钥匙串访问(Keychain Access)”工具保护密码安全  
下面阐述的方法只在OS X上可行。  
我们可以通过将发布证书密码委托在“钥匙串访问(Keychain Access)”工具中,然后通过gradle访问“钥匙串访问”工具来获取证书密码。  

### 具体步骤：  
1. `cmd+space`打开“钥匙串访问(Keychain Access)”工具。
2. 在登录选项中新钥匙串，如图：  
![通过“钥匙串访问(Keychain Access)”工具保护密码安全  .png](https://raw.githubusercontent.com/crazycodeboy/RNStudyNotes/master/React%20Native%E5%8F%91%E5%B8%83APP%E4%B9%8B%E7%AD%BE%E5%90%8D%E6%89%93%E5%8C%85APK/images/%E9%80%9A%E8%BF%87%E2%80%9C%E9%92%A5%E5%8C%99%E4%B8%B2%E8%AE%BF%E9%97%AE(Keychain%20Access)%E2%80%9D%E5%B7%A5%E5%85%B7%E4%BF%9D%E6%8A%A4%E5%AF%86%E7%A0%81%E5%AE%89%E5%85%A8%20%20.png)

提示： 你可以在terminal中运行如下命令检查新建的钥匙串是否成功。   
 `security find-generic-password -s android_keystore -w`  
3. 在build.gradle中访问你的秘钥串,将下列代码编辑到android/app/build.gradle中：   

```
def getPassword(String currentUser, String keyChain) {
   def stdout = new ByteArrayOutputStream()
   def stderr = new ByteArrayOutputStream()
   exec {
       commandLine 'security', '-q', 'find-generic-password', '-a', currentUser, '-s', keyChain, '-w'
       standardOutput = stdout
       errorOutput = stderr
       ignoreExitValue true
   }
   //noinspection GroovyAssignabilityCheck
      stdout.toString().trim()
}
```    

```
// Add this line
def pass = getPassword("YOUR_USER_NAME","android_keystore")
...
android {
    ...
    defaultConfig { ... }
    signingConfigs {
        release {
            storeFile file(MYAPP_RELEASE_STORE_FILE)
            storePassword pass // Change this
            keyAlias MYAPP_RELEASE_KEY_ALIAS
            keyPassword pass // Change this
        }
    }
    buildTypes {
        release {
            ...
            signingConfig signingConfigs.release
        }
    }
}
...
```   

**注意事项**   
钥匙串访问(Keychain Access)工具只是帮我们托管了，证书密码，证书明和alias还是需要我们在`gradle.properties`中设置一下的。
