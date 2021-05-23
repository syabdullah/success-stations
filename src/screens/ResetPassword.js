import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  Image,
  TouchableWithoutFeedback,
  Keyboard,
} from 'react-native';
import InputView from '../../components/InputView';
import ButtonView from '../../components/ButtonView';
import * as RNLocalize from 'react-native-localize';
import {translate} from './../util/TranslationUtils';
import ApiService from '../network/ApiService';
import {Alert} from 'react-native';
import Loader from './Loader';

export default class ResetPassword extends React.Component {
  static navigationOptions = ({navigation, navigationOptions}) => {
    return {
      title: '',
    };
  };

  constructor(props) {
    super(props);
    this.state= {isLoading:false}
    this.password = '';
    this.confirmPassword = '';
  }
  setPassword() {
    if (this.password != this.confirmPassword) {
      alert('Password doesnot match. Please try again.');
      return;
    }
   
    let data = {
      user_id: this.props.navigation.state.params.data.user_id.toString(),
      password: this.password,
    };
    this.setState({isLoading: true});
    ApiService.post('update-password', data)
      .then((response) => {
        this.setState({isLoading: false});
        this.props.navigation.navigate('recoveredPassword', {data: response, forgot_password: this.props.navigation.state.params.forgot_password});
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data.message);
      });
  }
  componentDidMount() {}

  componentWillUnmount() {}

  render() {
    return (
      <TouchableWithoutFeedback
        onPress={() => {
          Keyboard.dismiss();
        }}>
        <View style={styles.containerView}>
          <View
            style={{
              height: 350,
              width: 320,
              alignSelf: 'center',
              flexDirection: 'column',
              justifyContent: 'space-between',
            }}>
            <View style={{height: 105}}>
              <Image
                style={{width: 105, height: 105, alignSelf: 'center'}}
                source={require('../../assets/forgot.png')}
              />
            </View>
            <View style={{height: 29, alignContent: 'center'}}>
              <Text style={styles.forgetPasswordTextStyle}>
                {translate('enter_new_password')}
              </Text>
            </View>
            <View style={{height: 50}}>
              <InputView
                changeTextEvent={(newValue) => {
                  this.password = newValue;
                }}
                imageSource={require('../../assets/SignUp/password-icon.png')}
                placeholderText={translate('password_placeholder')}
                isSecureField={false}
                isFullWidth={true}
              />
            </View>
            <View style={{height: 50}}>
              <InputView
                changeTextEvent={(newValue) => {
                  this.confirmPassword = newValue;
                }}
                imageSource={require('../../assets/SignUp/password-icon.png')}
                placeholderText={translate('confirm_password')}
                isSecureField={false}
                isFullWidth={true}
              />
            </View>
            <View style={{height: 50, width: 320}}>
              <ButtonView
                clickEvent={() => {
                  this.setPassword();
                }}
                name={translate('submit')}
              />
            </View>
          </View>
          {this.state.isLoading ? <Loader loading={this.state.loading} /> : null}
        </View>
        
      </TouchableWithoutFeedback>
    );
  }
}

const styles = StyleSheet.create({
  containerView: {
    backgroundColor: '#F2F2F2',
    flex: 1,
    justifyContent: 'center',
  },
  forgetPasswordTextStyle: {
    textAlignVertical: 'center',
    fontSize: 22,
    fontWeight: '400',
    fontFamily: "DMSans-Regular",
    color: '#0B0B0B',
    alignSelf: 'center',
  },
});
