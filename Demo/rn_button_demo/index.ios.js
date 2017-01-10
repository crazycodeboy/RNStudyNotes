/**
 * React Native按钮使用详解
 * Author: CrazyCodeBoy
 * 技术博文：http://www.devio.org
 * GitHub:https://github.com/crazycodeboy
 * Email:crazycodeboy@gmail.com
 */
import React, {Component} from 'react';
import {
    AppRegistry,
    StyleSheet,
    Text,
    TouchableWithoutFeedback,
    View,
    Alert,
    TouchableHighlight,
    TouchableNativeFeedback
} from 'react-native';

export default class rn_demo extends Component {
    state = {
        count: 0,
        countLong: 0,
        text: '',
        waiting: false,
        startTime: 0
    }

    render() {
        return (
            <View style={styles.container}>
                <View>
                    <TouchableWithoutFeedback
                        onPress={()=> {
                            this.setState({count: this.state.count + 1})
                        }}
                        onLongPress={()=> {
                            this.setState({countLong: this.state.countLong + 1})
                            Alert.alert(
                                '提示',
                                '确定要删除吗?',
                                [
                                    {text: '取消', onPress: () => console.log('Cancel Pressed'), style: 'cancel'},
                                    {text: '确实', onPress: () => console.log('OK Pressed')},
                                ]
                            )
                        }}
                    >
                        <View style={styles.button}>
                            <Text style={styles.buttonText}>
                                我是TouchableWithoutFeedback,单击我
                            </Text>
                        </View>
                    </TouchableWithoutFeedback>
                    <TouchableWithoutFeedback
                        disabled={this.state.waiting}
                        onPress={()=> {
                            this.setState({text: '正在登录...', waiting: true})
                            setTimeout(()=> {
                                this.setState({text: '网络不流畅', waiting: false})
                            }, 2000);

                        }}
                    >
                        <View style={styles.button}>
                            <Text style={styles.buttonText}>
                                登录
                            </Text>
                        </View>
                    </TouchableWithoutFeedback>
                    <TouchableWithoutFeedback
                        style={{marginBottom:20}}
                        onPressIn={()=> {
                            this.setState({text: '触摸开始', startTime: new Date().getTime()})
                        }}
                        onPressOut={()=> {
                            this.setState({text: '触摸结束,持续时间:' + (new Date().getTime() - this.state.startTime) + '毫秒'})
                        }}
                    >
                        <View style={styles.button}>
                            <Text style={styles.buttonText}>
                                点我
                            </Text>
                        </View>
                    </TouchableWithoutFeedback>
                    <TouchableHighlight
                        style={{marginTop: 20}}
                        activeOpacity={0.7}
                        underlayColor='green'
                        onHideUnderlay={()=> {
                            this.setState({text: '衬底被隐藏'})
                        }}
                        onShowUnderlay={()=> {
                            this.setState({text: '衬底显示'})
                        }}
                        onPress={()=> {

                        }}
                    >
                        <View style={styles.button}>
                            <Text style={styles.buttonText}>
                                TouchableHighlight
                            </Text>
                        </View>
                    </TouchableHighlight>
                    <TouchableNativeFeedback
                        onPress={()=>{
                            this.setState({count: this.state.count + 1})
                        }}
                        background={TouchableNativeFeedback.SelectableBackground()}>
                        <View style={{width: 150, height: 100, backgroundColor: 'red'}}>
                            <Text style={{margin: 30}}>TouchableNativeFeedback</Text>
                        </View>
                    </TouchableNativeFeedback>
                    <Text style={styles.text}>{this.state.text}</Text>
                    <Text style={styles.text}>您单击了:{this.state.count}次</Text>
                    <Text style={styles.text}>您长按了:{this.state.countLong}次</Text>
                </View>
            </View>
        );
    }
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        marginTop: 50
    },
    button: {
        borderWidth: 1,
    },
    buttonText: {
        fontSize: 18,
        color: 'red',
        backgroundColor:'white'
    },
    text: {
        fontSize: 16,
        marginBottom:20
    },

});

AppRegistry.registerComponent('rn_button_demo', () => rn_demo);
