'use strict';

import React from 'react';
import {
    View,
    Text,
    requireNativeComponent
} from 'react-native';
import RNText from './RNText';

export default class Home extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <View style={{flex: 1, backgroundColor: '#777777'}}>
                <View style={{height: 64, backgroundColor: 'red'}} />
                <View style={{flex: 1, backgroundColor: '#ffffff'}}>
                    <Text>{this.props.key1}</Text>
                </View>
                <View style={{flex: 1, backgroundColor: '#ffffee'}}>
                    <RNText
                    value="HaHaHa~~~"
                    onValueChange={(value) => {
                        alert(value);
                    }}
                    style={{flex: 1}}/>
                </View>
            </View>
        );
    }
}
