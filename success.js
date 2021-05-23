import React, {useState} from "react";
import {
  NavigationContainer,
} from '@react-navigation/native';
import {createAppContainer} from 'react-navigation';
import {createStackNavigator} from 'react-navigation-stack';
import { Platform,I18nManager }from "react-native"
import HomeScreen from './src/screens/HomeScreen';
import MyListScreen from './src/screens/ListScreen';
import ImageScreen from './src/screens/ImageScreen';
import CounterScreen from './src/screens/ConterScreen';
import ColorScreen from './src/screens/ColorScreen';
import SquareScreen from './src/screens/SquareScreen';
import SquareScreenByReducer from './src/screens/SquareScreenByReducer';
import CounterScreenByReducer from './src/screens/CounterScreenByReducer';
import TextScreen from './src/screens/TextScreen';
import CountrySelectScreen from './src/screens/CountrySelectScreen';
import LoginScreen from './src/screens/LoginScreen';
import ForgetPassword from './src/screens/ForgetPassword';
import OtpScreen from './src/screens/OtpScreen';
import RecoveredPassword from './src/screens/RecoveredPassword';
import ResetPassword from './src/screens/ResetPassword';
import UserSignUpForm from './src/screens/UserSignUpForm';
import DashBoard from './src/screens/dashboard/DashBoard';
import ChooseLanguageScreen from './src/screens/ChooseLanguageScreen';
import BookDetailScreen from './src/screens/dashboard/screen/book/BookDetailScreen';
import AsyncStorage from '@react-native-community/async-storage'
import SplashScreen from 'react-native-splash-screen'
import ApiService from './src/network/ApiService';
import {languageArray} from './src/util/DataUtil'
import i18n from 'i18n-js';
import * as RNLocalize from 'react-native-localize';
import {translate} from "./../success-station/src/util/TranslationUtils";
const Stack = createStackNavigator();

 const AppNavigator = (isSigned) => {
   return createStackNavigator(
    {
      Home: HomeScreen,
      MyList: MyListScreen,
      ImageSc: ImageScreen,
      counterScreen: CounterScreen,
      colorScreen: ColorScreen,
      squareScreen: SquareScreen,
      squareScreenByReducer: SquareScreenByReducer,
      counterScreenByReducer: CounterScreenByReducer,
      textScreen: TextScreen,
      countrySelectScreen: CountrySelectScreen,
      login: LoginScreen, 
      forgetPassword: ForgetPassword,
      otpScreen: OtpScreen,
      recoveredPassword: RecoveredPassword,
      resetPassword: ResetPassword,
      dashBoard: DashBoard,
      userSignUpForm: UserSignUpForm,
      chooseLanguageScreen: ChooseLanguageScreen,
      bookDetailScreen: BookDetailScreen,
    },
    {
      initialRouteName:  isSigned?'dashBoard':'chooseLanguageScreen',
      defaultNavigationOptions: {
        headerStyle: {
          backgroundColor: '#F2F2F2',
        },
        headerTintColor: '#000',
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      },
    },
  );
};
const translationGetters = {

  en: () => require('./src/translations/en.json'),
  ar: () => require('./src/translations/ar.json'), 
};
 

const setI18nConfig = (lang) => {
  const fallback = { languageTag: lang, isRTL: false };
  const { languageTag, isRTL } = RNLocalize.findBestAvailableLanguage(Object.keys(translationGetters)) || fallback;
  translate.cache.clear();
  I18nManager.forceRTL(isRTL);
  i18n.translations = { [lang]: translationGetters[lang]() };
  i18n.locale = lang;
};
export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      langTitle: languageArray[0].label,
      langCode: languageArray[0].code,
      isSigned: false
    };
    

    AsyncStorage.getItem('langCode')
      .then((code) => {
        setI18nConfig(code);
        this.loadScreen();
      })
      .catch(() => {
        setI18nConfig('en');
        this.loadScreen();
      });
  }
  loadScreen() {
    console.log("load")
    this.setState({isLoading: Platform.OS != 'android'});

    AsyncStorage.getItem('userdata')
      .then((value) => {
        if (!value || 0 != value.length) {
          ApiService.setToken(JSON.parse(value).access_token);
          this.setState({isSigned : true})
          Platform.OS == 'android' ? SplashScreen.hide() : null;
          console.log("userdata")
        }
        
      })
      .catch(() => {
        console.log("error")
        this.setState({isSigned : false})
        Platform.OS == 'android' ? SplashScreen.hide() : null;
      });
  }
  componentWillMount() {
   this.loadScreen
  }

  render() {
    return(
   Stack(AppNavigator(this.state.isSigned))
    )
  }
}
