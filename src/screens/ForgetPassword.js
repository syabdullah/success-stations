import React from "react";
import { View, Text, TextInput, StyleSheet, Image, TouchableOpacity, TouchableWithoutFeedback, Keyboard, I18nManager } from "react-native";
import InputView from "../../components/InputView";
import ButtonView from "../../components/ButtonView";
import * as RNLocalize from 'react-native-localize';
import i18n from 'i18n-js';
import memoize from 'lodash.memoize';
import Helper from '../util/Helper';
import ApiService from '../network/ApiService';
import Loader from './Loader';
import {translate} from "./../util/TranslationUtils";

export default class ForgetPassword extends React.Component {

    static navigationOptions = ({ navigation, navigationOptions }) => {
        return {
            title: '',
        };
    };

    constructor(props) {
        super(props);
        this.email = ''
        this.state = {isLoading : false}
      
    }
  
    componentDidMount() {
    }

    componentWillUnmount() {
    }
    setPassword() {
        //{data: {forgot_password: true}
        if (Helper.isEmailValid(this.email.trim())) {
            alert('Enter valid Email');
          }
       
        let data = {
          email: this.email,
        };
        this.setState({isLoading: true});
        ApiService.post('forgot-password', data)
          .then((response) => {
            this.setState({isLoading: false});
            this.props.navigation.navigate('otpScreen',{data: {email: this.email.trim(), forgot_password: this.props.navigation.state.params.data.forgot_password}})
          })
          .catch((error) => {
            this.setState({isLoading: false});
            //alert(error.data.message);
          });
      }

    render() {
        return (
            <TouchableWithoutFeedback onPress={ () => {
                Keyboard.dismiss()
            }}>
                <View style={styles.containerView}>
                    <View style={{height: 350, width: 320, alignSelf: "center", flexDirection: "column", justifyContent: "space-between"}}>
                        <View style={{height: 105}}>
                            <Image style={{width: 105, height: 105, alignSelf: "center"}} source={require('../../assets/forget-pwd-new-icon.png')} />
                        </View>
                        <View style={{height: 29, alignContent: "center"}}>
                            <Text style={styles.forgetPasswordTextStyle}>{translate('forgot_your_password')}</Text>
                        </View>
                        <View style={{height: 50}}>
                        <InputView 
                                                changeTextEvent = {(newValue) => {
                                                    this.email = newValue;
                                                }} 
                                                imageSource={require('../../assets/SignUp/email-icon.png')}
                                                placeholderText={translate('email')}
                                                isSecureField={false}
                                                isFullWidth={true}
                                                keyboardTypeValue={"email-address"}
                                    />
                        </View>
                        <View style={{height: 50, width: 320}}>
                            <ButtonView clickEvent = { () => {
                                            this.setPassword()
                                        
                                        } } name={translate('send')} />
                        </View>
                        <View style={styles.dontHaveAccountViewStyle}>
                            <TouchableOpacity onPress={() => {
                      
                                this.props.navigation.pop();
                            }}>
                                <View style={{flexDirection: "row"}}>
                                    <Text style={styles.dontHaveAccountTextStyle}>
                                    {translate('back_to')}
                                    </Text>
                                    <Text style={styles.dontHaveSignUpTextStyle}>
                                    {` `}{translate('sign_in_title')}
                                    </Text>
                                </View>
                            </TouchableOpacity>
                        </View>
                    </View>
                    {this.state.isLoading ? <Loader loading={this.state.loading} /> : null}
                </View>
            </TouchableWithoutFeedback>
        )
    }
}

const styles = StyleSheet.create({
    containerView: {
        backgroundColor: "#F2F2F2",
        flex: 1,
        justifyContent: "center",
    },
    forgetPasswordTextStyle: { 
        textAlignVertical: "center", 
        fontSize: 22, 
        fontWeight: "400", 
        fontFamily: "DMSans-Regular",
        color: "#0B0B0B",
        alignSelf: "center",
    },
    dontHaveAccountViewStyle: { 
        alignSelf: "center", 
        height: 25, 
        borderColor: "red", 
        borderWidth: 0, 
        alignItems: "center",
    },
    dontHaveAccountTextStyle: { 
        textAlignVertical: "center", 
        fontSize: 15, 
        fontWeight: "400", 
        fontFamily: "DMSans-Regular",
        color: "#2C2948",
    },
    dontHaveSignUpTextStyle: { 
        textAlignVertical: "center", 
        fontSize: 15, 
        fontWeight: "700", 
        fontFamily: "DMSans-Regular",
        color: "#F78A3A"
    }
})