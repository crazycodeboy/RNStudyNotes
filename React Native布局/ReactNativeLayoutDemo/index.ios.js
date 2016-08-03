/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';

class ReactNativeLayoutDemo extends Component {
  componentDidMount(){
    console.log("");
    console.log("");
    this.test();
  }
  test(){
    console.log("test");
  }
  render() {
    return (
      <View>
        {/*Width&Height*/}
        <View style={{width:100,height:100,marginTop:30,backgroundColor:'gray'}}>
          <Text style={{fontSize:16}}>尺寸</Text>
        </View>

        {/*横轴和竖轴*/}
        <View style={{flexDirection:'row',height:40,borderBottomWidth:1,borderColor:'yellow'}}>
          <View style={{flex:1,backgroundColor:"darkcyan",margin:5}}>
            <Text style={{fontSize:16}}>flex:1</Text>
          </View>
          <View style={{flex:2,backgroundColor:"darkcyan",margin:5}}>
            <Text style={{fontSize:16}}>flex:2</Text>
          </View>
          <View style={{flex:3,backgroundColor:"darkcyan",margin:5}}>
            <Text style={{fontSize:16}}>flex:3</Text>
          </View>
        </View>

      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 5,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('ReactNativeLayoutDemo', () => ReactNativeLayoutDemo);
