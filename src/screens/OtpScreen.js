import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  SafeAreaView,
  TouchableWithoutFeedback,
  Keyboard,
  Image,
  TouchableOpacity,
} from 'react-native';
import ButtonView from '../../components/ButtonView';
import OTPInputView from 'react-native-otp-textinput';
import {translate} from './../util/TranslationUtils';
import ApiService from '../network/ApiService';
import Loader from './Loader';
export default class OtpScreen extends React.Component {
  static navigationOptions = ({navigation, navigationOptions}) => {
    return {
      title: '',
    };
  };

  constructor(props) {
    super(props);
    //I18nManager.forceRTL(true);
    this.state= {isLoading:false}
    this.otp = '';
  }
  sendOtp() {
    let data = {
      email: this.props.navigation.state.params.data.email,
      otp: this.otp,
    };
    this.setState({isLoading: true});
    ApiService.post('verify-otp', data)
      .then((response) => {
        this.setState({isLoading: false});
        this.props.navigation.navigate('resetPassword', {data: response, forgot_password: this.props.navigation.state.params.data.forgot_password});
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
      <SafeAreaView
        style={{flex: 1, backgroundColor: '#F2F2F2', justifyContent: 'center'}}>
        <TouchableWithoutFeedback
          onPress={() => {
            Keyboard.dismiss();
          }}>
          <View
            style={{
              width: 320,
              height: 330,
              flexDirection: 'column',
              justifyContent: 'space-between',
              alignSelf: 'center',
            }}>
            <View style={{height: 118, width: 320, alignContent: 'center'}}>
              <Image
                source={require('../../assets/enter-otp-logo.png')}
                style={{
                  width: 98,
                  height: 118,
                  resizeMode: 'contain',
                  alignSelf: 'center',
                }}
              />
            </View>
            <View style={{height: 29}}>
              <Text
                style={{
                  alignSelf: 'center',
                  fontSize: 22,
                  fontFamily: "DMSans-Regular",
                  fontWeight: '400',
                  color: 'black',
                }}>
                {translate('enter_otp')}
              </Text>
            </View>
            <View style={{height: 16}}>
              <Text
                style={{
                  alignSelf: 'center',
                  fontSize: 12,
                  fontFamily: "DMSans-Regular",
                  fontWeight: '400',
                  color: '#4A4A4A',
                }}>
                {translate('otp_desc')}
              </Text>
            </View>
            <View style={{height: 50, marginBottom: 18}}>
              <OTPInputView
                handleTextChange={(e) => {
                  this.otp = e;
                }}
                containerStyle={styles.textInputContainer}
                textInputStyle={styles.roundedTextInput}
                inputCount={4}
                tintColor={'#ffffff'}
                offTintColor={'#ffffff'}
                inputCellLength={1}
              />
            </View>
            <View style={{height: 50, width: 320}}>
              <ButtonView
                clickEvent={() => {
                  this.sendOtp();
                }}
                name={translate('send')}
              />
            </View>
            <View style={{height: 25}}>
              <TouchableOpacity>
                <Text
                  style={{
                    alignSelf: 'center',
                    fontSize: 15,
                    fontStyle: 'normal',
                    fontWeight: '700',
                    color: '#F78A3A',
                  }}>
                  {translate('resend')}
                </Text>
              </TouchableOpacity>
            </View>
          </View>
        </TouchableWithoutFeedback>
        {this.state.isLoading ? <Loader loading={this.state.loading} /> : null}
      </SafeAreaView>
    );
  }
}

const styles = StyleSheet.create({
  textInputContainer: {
    marginBottom: 20,
  },
  roundedTextInput: {
    borderRadius: 10,
    borderWidth: 4,
    backgroundColor: '#ffffff',
  },
});
