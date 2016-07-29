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

class RNLayoutDemo extends Component {
  render() {
    return (
      <View>
        {/*Width&Height*/}
        <View style={{width:100,height:100,marginTop:30,backgroundColor:'gray'}}>
          <Text style={{fontSize:16}}>尺寸</Text>
        </View>

        {/*横轴和竖轴*/}
        <View style={{flexDirection:'row',backgroundColor:"darkgray",margin:10}}>
          <View style={{width:80,height:80,backgroundColor:"darkcyan",margin:5}}></View>
          <View style={{width:80,height:80,backgroundColor:"darkcyan",margin:5}}></View>
          <View style={{width:80,height:80,backgroundColor:"darkcyan",margin:5}}></View>
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

AppRegistry.registerComponent('RNLayoutDemo', () => RNLayoutDemo);
