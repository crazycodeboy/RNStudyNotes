一款好的APP离不了一个漂亮的布局，本文章将向大家分享React Native中的布局方式FlexBox。    
在React Native中布局采用的是FleBox(弹性框)进行布局。  
FlexBox提供了在不同尺寸设备上都能保持一致的布局方式。FlexBox是CSS3弹性框布局规范，目前还处于最终征求意见稿 (Last Call Working Draft)阶段，并不是所有的浏览器都支持Flexbox。但大家在做React Native开发时大可不必担心FlexBox的兼容性问题，因为既然React Native选择用FlexBox布局，那么FlexBox在React Native上的自然会支持的很好。  

## 宽和高  
一个组件的高度和宽度决定了它在屏幕上的大小。  
### 像素无关  
在React Native中尺寸是没有单位的，它代表了设备独立像素。  
```
<View style={{width:100,height:100,margin:40,backgroundColor:'gray'}}>
        <Text style={{fontSize:16,margin:20}}>尺寸</Text>
</View>
```    
上述代码，运行在Android上时，View的长和宽被解释成：100dp 100dp单位是dp，字体被解释成16sp 单位是sp，运行在iOS上时尺寸单位被解释称了pt，这些单位确保了在任何不同dpi的手机屏幕上显示不会发生改变；  

## 和而不同  
值得一提的是，React Native中的FlexBox 和Web CSSS上FlexBox工作方式是一样的。但有些地方还有有些出入的如：  
### React Native中的FlexBox 和Web CSSS上FlexBox的不同之处  
* flexDirection:  React Native中`flexDirection:'column'`对应Web CSS的`flex-direction:'row'`
* alignItems:  React Native中`alignItems:'stretch'`对应Web CSS的`align-items:'flex-start'`
* flex: 相比Web CSS的flex接受多参数，如:`flex: 2 2 10%;`，但在 React Native中flex只接受一个参数   




## 参考  
[A Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)   
[Using CSS flexible boxes](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Flexible_Box_Layout/Using_CSS_flexible_boxes)


