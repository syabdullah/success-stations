import React, { useState } from "react";
import { View, Text, Image, StyleSheet, TouchableOpacity, Keyboard, TouchableWithoutFeedback, SafeAreaView, I18nManager } from "react-native";
import InputView from "../../components/InputView";
import ButtonView from "../../components/ButtonView";
import {translate} from "./../util/TranslationUtils";
import ApiService from '../network/ApiService';
import Helper from '../util/Helper';
import Loader from './Loader';
import AsyncStorage from '@react-native-community/async-storage'
import { StackActions, NavigationActions } from 'react-navigation';

const resetAction = StackActions.reset({
    index: 0,
    actions: [NavigationActions.navigate({ routeName: 'dashBoard' })],
  });

export default class LoginScreen extends React.Component {

    static navigationOptions = ({ navigation, navigationOptions }) => {
        return {
            title: translate('sign_in')
        };
    };

    constructor(props) {
        super(props)
        this.state = {isLoading: false, email: '', password: ''}
    }

    componentDidMount() {
    }
    
    componentWillUnmount() {
    }

    startLogin = () => {

        if (this.state.email == '') {
            alert(translate('please_enter_email'))
            return;
        } 
          
        if (Helper.isEmailValid(this.state.email)) {
            alert(translate('enter_valid_email'))
            return;
        } 

        if (this.state.password == '') {
            alert(translate('please_enter_password'))
            return;
        }

        this.setState({isLoading: true});
        ApiService.post('login', {
            "email": this.state.email.trim(), "password": this.state.password
        })
        .then((response) => {
            this.setState({isLoading: false});
            ApiService.setToken(response.access_token)
            AsyncStorage.setItem('userdata',JSON.stringify(response))
            this.props.navigation.dispatch(resetAction);
        })
        .catch ((error)=> {
            this.setState({isLoading : false})
            alert(error.data.message)
        })
    }

    render() {
        return <TouchableWithoutFeedback 
        onPress={() => {
            Keyboard.dismiss();
        }}>
            <SafeAreaView style={{flex: 1}}>    
                <View style={{flex: 1, justifyContent: "center"}}>
                    <View style={style.mainViewStyle}> 
                        <View style={{height: 122, alignSelf: "center"}}>
                            <Image style={style.logoImageStyle}
                                source={require('../../assets/logo.png')}
                            />
                        </View>
                        <View style={{height: 50}}>
                            <Text style={style.welcomeTextViewStyle}>{translate('welcome_back')}</Text>
                        </View>
                        <View style={{height: 50}}>
                            <Text style={style.signInTextViewStyle}>{translate('sign_continue')}</Text>
                        </View>
                        <View style={{height: 50}}>
                            <InputView 
                                        changeTextEvent = {(newValue) => {
                                            this.setState({email: newValue})
                                        }} 
                                        imageSource={require('../../assets/SignUp/email-icon.png')}
                                        placeholderText={translate('email')}
                                        isSecureField={false}
                                        isFullWidth={true}
                                        keyboardTypeValue={"email-address"}
                            />
                        </View>
                        <View style={{height: 50}}>
                        <InputView 
                                                changeTextEvent = {(newValue) => {
                                                 this.setState({password: newValue})
                                                }} 
                                                imageSource={require('../../assets/SignUp/password-icon.png')}
                                                placeholderText={translate('password_placeholder')}
                                                isSecureField={true}
                                                isFullWidth={true}
                                    />
                        </View>
                        <View style={{height: 30, width: 320, alignSelf: "center", alignItems: "stretch", flexDirection: "row"}}>
                            
                            <View style={{width: 160, height: 25}}>
                                <View style={{alignContent: "flex-end", width: 110, height: 25}}>
                                <TouchableOpacity onPress={() => {
                                    this.props.navigation.navigate('forgetPassword',{data: {forgot_password: true}})
                                }}>
                                    <Text style={{fontWeight: "400", fontSize: 12, lineHeight: 18, color: "#7165E3", textAlignVertical: "center"}}>{translate('forgot_password')}</Text>
                                </TouchableOpacity>
                                    
                                </View>
                            </View>
                        </View>
                        <View style={{height: 50, width: 320, alignSelf: "center"}}> 
                            <ButtonView clickEvent = { () => {
                                this.startLogin()
                            } } name={translate('sign_in_title')} />
                        </View>
                        <View style={style.dontHaveAccountViewStyle}>
                            <TouchableOpacity onPress={() => {
                                this.props.navigation.navigate('userSignUpForm')
                            }}>
                                <View style={{flexDirection: "row"}}>
                                    <Text style={style.dontHaveAccountTextStyle}>
                                    {translate('Dont_have_account')}
                                    </Text>
                                    <Text style={style.dontHaveSignUpTextStyle}>
                                    {translate('sign_up_text')}
                                    </Text>
                                </View>
                            </TouchableOpacity>
                        </View>
                    </View>
                </View>
                {this.state.isLoading ?   <Loader
                loading={this.state.loading} /> :null}
            </SafeAreaView>
    </TouchableWithoutFeedback>
    }
};

const style = StyleSheet.create({

    mainViewStyle: {
        alignItems: "stretch",
        backgroundColor: "#F2F2F2",
        justifyContent: "space-between",
        height: 480,
    },
    logoImageStyle: {
        width: 220,
        height: 122,
        alignItems: "center",
        resizeMode: "contain",
    },
    welcomeTextViewStyle: {
        fontSize: 30,
        fontWeight: "700",
        lineHeight: 40,
        alignSelf: "center",
        color: "#000",
        fontFamily: "DMSans-Regular",
    },
    signInTextViewStyle: {
        fontSize: 15,
        fontWeight: "400",
        fontFamily: "DMSans-Regular",
        lineHeight: 40,
        alignSelf: "center",
        color: "#1C1939",
    },
    emailViewStyle: {
        borderWidth: 1,
        borderColor: "#000000",
        height: 50,
        width: 320,
        borderRadius: 4,
        alignSelf: "center",
    },
    dontHaveAccountViewStyle: { 
        width: 280, 
        alignSelf: "center", 
        height: 25, 
        borderColor: "red", 
        borderWidth: 0, 
        alignItems: "center",
    },
    dontHaveAccountTextStyle: { 
        textAlignVertical: "center", 
        fontSize: 15, 
        fontWeight: "700", 
        color: "#2C2948",
        fontFamily: "DMSans-Regular",
    },
    dontHaveSignUpTextStyle: { 
        textAlignVertical: "center", 
        fontSize: 15, 
        fontWeight: "700", 
        fontFamily: "DMSans-Regular",
        color: "#F78A3A"
    }

});