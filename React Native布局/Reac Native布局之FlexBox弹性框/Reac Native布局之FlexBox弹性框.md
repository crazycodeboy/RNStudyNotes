一款好的APP离不了一个漂亮的布局，本文章将向大家分享React Native中的布局方式FlexBox。    
在React Native中布局采用的是FleBox(弹性框)进行布局。  
FlexBox提供了在不同尺寸设备上都能保持一致的布局方式。FlexBox是CSS3弹性框布局规范，目前还处于最终征求意见稿 (Last Call Working Draft)阶段，并不是所有的浏览器都支持Flexbox。但大家在做React Native开发时大可不必担心FlexBox的兼容性问题，因为既然React Native选择用FlexBox布局，那么React Native对FlexBox的支持自然会做的很好。  

## 宽和高  
在学习FlexBox之前首先要清楚一个概念“宽和高”。一个组件的高度和宽度决定了它在屏幕上的尺寸，也就是大小。  
### 像素无关  
在React Native中尺寸是没有单位的，它代表了设备独立像素。  
```
<View style={{width:100,height:100,margin:40,backgroundColor:'gray'}}>
        <Text style={{fontSize:16,margin:20}}>尺寸</Text>
</View>
```    
上述代码，运行在Android上时，View的长和宽被解释成：100dp 100dp单位是dp，字体被解释成16sp 单位是sp，运行在iOS上时尺寸单位被解释称了pt，这些单位确保了布局在任何不同dpi的手机屏幕上显示不会发生改变；  

## 和而不同  
值得一提的是，React Native中的FlexBox 和Web CSSS上FlexBox工作方式是一样的。但有些地方还是有些出入的，如：  
### React Native中的FlexBox 和Web CSSS上FlexBox的不同之处  
* flexDirection:  React Native中默认为`flexDirection:'column'`，在Web CSS中默认为`flex-direction:'row'`
* alignItems:  React Native中默认为`alignItems:'stretch'`，在Web CSS中默认`align-items:'flex-start'`
* flex: 相比Web CSS的flex接受多参数，如:`flex: 2 2 10%;`，但在 React Native中flex只接受一个参数   
* 不支持属性：align-content，flex-basis，order，flex-basis，flex-flow，flex-grow，flex-shrink

以上是React Native中的FlexBox 和Web CSSS上FlexBox的不同之处，记住这几点，你可以像在Web CSSS上使用FlexBox一样，在React Native中使用FlexBox。

## Layout Props

### Flex in React Native  
以下属性是React Native所支持的Flex属性。  

#### 父视图属性(容器属性)：   
* flexDirection enum('row', 'column') 
* flexWrap enum('wrap', 'nowrap') 
* justifyContent enum('flex-start', 'flex-end', 'center', 'space-between', 'space-around') 
* alignItems enum('flex-start', 'flex-end', 'center', 'stretch') 

#### 主轴和侧轴(横轴和竖轴)
在学习上述属性之前，让我们先了解一个概念：主轴和侧轴  
![主轴和侧轴](https://mdn.mozillademos.org/files/12998/flexbox.png)  
主轴即水平方向的轴线，可以理解成横轴，侧轴垂直于主轴，可以理解为竖轴。

#### flexDirection
`flexDirection enum('row', 'column')`  
`flexDirection`规定了，父视图中的子元素沿横轴或侧轴方片的排列方式。 





#### 子视图属性 
* alignSelf enum('auto', 'flex-start', 'flex-end', 'center', 'stretch') 
* flex number 

### 视图边框  
* borderBottomWidth number 
* borderLeftWidth number 
* borderRightWidth number 
* borderTopWidth number 
* borderWidth number 
* bottom number 

### 尺寸 
width number 
height number 

### 外边距
* margin number 
* marginBottom number 
* marginHorizontal number 
* marginLeft number 
* marginRight number 
* marginTop number 
* marginVertical number 

### 内边距
* padding number 
* paddingBottom number 
* paddingHorizontal number 
* paddingLeft number 
* paddingRight number 
* paddingTop number 
* paddingVertical number 
* position enum('absolute', 'relative') 


* left number 
* right number 
* top number 







## 参考  
[A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)   
[Using CSS flexible boxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Using_CSS_flexible_boxes)


