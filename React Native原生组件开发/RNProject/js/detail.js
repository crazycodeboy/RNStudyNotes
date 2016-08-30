'use strict';

import React from 'react';
import {
    View,
    Text,
    TouchableOpacity,
    NativeModules,
    NativeAppEventEmitter
} from 'react-native';

var Test = NativeModules.Test;

export default class Detail extends React.Component {
    constructor(props) {
        super(props);
    }

    componentWillUnmount() {
        this.subscription.remove();
    }

    componentDidMount() {
        this.subscription = NativeAppEventEmitter.addListener(
                        'typeChange',
                        (result)  => alert(result.type)
                    );
    }

    render() {

        this.index = 0;
        return (
            <View style={{flex: 1, backgroundColor: '#888888'}}>
                <View style={{height: 64, backgroundColor: 'blue'}} />
                <View style={{flex: 1, backgroundColor: '#ffffff'}}>
                    <Text>{this.props.key1}</Text>
                </View>
                <TouchableOpacity onPress={() => {
                    Test.print("Hello World");
                }}
                style={{flex: 1, backgroundColor: '#ffffff'}}
                >
                <Text>Print</Text>
                </TouchableOpacity>

                <TouchableOpacity onPress={() => {
                    Test.add(1, 2, (result) => {
                        alert('1 + 2 = ' + result);
                    });
                }}
                style={{flex: 1, backgroundColor: '#ffffff'}}
                >
                <Text>Cal 1 + 2 = ？</Text>
                </TouchableOpacity>

                <TouchableOpacity onPress={() => {
                    alert(Test.defaultValue);
                }}
                style={{flex: 1, backgroundColor: '#ffffff'}}
                >
                <Text>常量</Text>
                </TouchableOpacity>

                <TouchableOpacity onPress={() => {
                    console.log(Test.testManagerTypeDefault);
                    Test.updateTestManagerType(Test.testManagerTypeDefault, (type, info) => {
                        alert("update result\n" + type + " " + info);
                    });
                }}
                style={{flex: 1, backgroundColor: '#ffffff'}}
                >
                <Text>枚举常量</Text>
                </TouchableOpacity>

                <TouchableOpacity onPress={() => {
                    var type;
                    switch (this.index) {
                        case 0:
                        type = Test.testManagerTypeNone;
                        break;
                        case 1:
                        type = Test.testManagerTypeDefault
                        break;
                        case 2:
                        type = Test.testManagerTypeCustome
                        break;
                        default:
                    }
                    this.index = (this.index + 1) % 3;
                    Test.updateTestManagerType(type, (type, info) => {

                    });
                }}
                style={{flex: 1, backgroundColor: '#ffffff'}}
                >
                <Text>更改TYPE</Text>
                </TouchableOpacity>
            </View>
        );
    }
}
