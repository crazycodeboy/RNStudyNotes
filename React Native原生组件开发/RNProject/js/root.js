'use strict';

import React, {Component} from 'react';
import {
    StyleSheet,
    Navigator,
    BackAndroid,
    View,
} from 'react-native';

import Home from './home';

var _navigator;

export default class Root extends Component {

    constructor(props) {
        super(props);
        this.renderScene = this.renderScene.bind(this);
        this.goBack = this.goBack.bind(this);
        BackAndroid.addEventListener('hardwareBackPress', this.goBack);
    }

    goBack() {
        if (_navigator && _navigator.getCurrentRoutes().length > 1) {
            _navigator.pop();
            return true;
        }
        return false;
    }

    renderScene(route, navigator) {
        var Component = route.component;
        _navigator = navigator;
        return (
            <Component navigator={navigator} route={route} {...route.params} {...this.props}/>
        );
    }

    configureScene(route, routeStack) {
        if (route.type === 'present') {
            return Navigator.SceneConfigs.FloatFromBottom;
        }
        return Navigator.SceneConfigs.PushFromRight;
    }

    render() {
        return (
            <View style={{flex: 1}}>
                <Navigator
                    ref='navigator'
                    style={styles.navigator}
                    configureScene={this.configureScene}
                    renderScene={this.renderScene}
                    initialRoute={{
                    component: Home,
                    name: 'Home'
                    }}
                />
            </View>
        );
    }

    componentDidUnMount() {
        BackAndroid.removeEventListener()
    }

}
let styles = StyleSheet.create({
    navigator: {
        flex: 1
    }
});

