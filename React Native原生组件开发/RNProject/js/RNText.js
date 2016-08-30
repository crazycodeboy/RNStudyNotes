import React, { Component, PropTypes } from 'react';
import { requireNativeComponent } from 'react-native';

var UIText = requireNativeComponent('RNText', RNText);

export default class RNText extends Component {
  static propTypes = {
      value: PropTypes.string,
      onValueChange: PropTypes.func
  };

  static defaultProps = {
  }

  render() {
      return <UIText {...this.props} onChange={(obj) => {
          this.props.onValueChange(obj.nativeEvent.value);
      }} />;
  }
}
