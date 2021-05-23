import * as React from 'react';
import { Platform,I18nManager }from "react-native"
import { createAppContainer } from 'react-navigation';
import { createStackNavigator } from 'react-navigation-stack';
import HomeScreen from './src/screens/HomeScreen';
import MyListScreen from './src/screens/ListScreen';
import ImageScreen from './src/screens/ImageScreen';
import CounterScreen from './src/screens/ConterScreen';
import ColorScreen from "./src/screens/ColorScreen";
import SquareScreen from "./src/screens/SquareScreen";
import SquareScreenByReducer from "./src/screens/SquareScreenByReducer";
import CounterScreenByReducer from "./src/screens/CounterScreenByReducer";
import TextScreen from "./src/screens/TextScreen";
import CountrySelectScreen from "./src/screens/CountrySelectScreen";
import LoginScreen from "./src/screens/LoginScreen";
import ForgetPassword from "./src/screens/ForgetPassword";
import OtpScreen from "./src/screens/OtpScreen";
import RecoveredPassword from "./src/screens/RecoveredPassword";
import ResetPassword from "./src/screens/ResetPassword";
import UserSignUpForm from "./src/screens/UserSignUpForm";
import DashBoard from "./src/screens/dashboard/DashBoard"
import ChooseLanguageScreen from "./src/screens/ChooseLanguageScreen";

import AsyncStorage from '@react-native-community/async-storage'
import SplashScreen from 'react-native-splash-screen'
import ApiService from './src/network/ApiService';
import {languageArray} from './src/util/DataUtil'
import i18n from 'i18n-js';
import * as RNLocalize from 'react-native-localize';
import {translate} from "./../success-station/src/util/TranslationUtils";
import {bindActionCreators} from 'redux';
import { connect } from 'react-redux';
import * as Action from '../success-station/src/redux/ReduxAction';


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


const IntroNavigationStack = createStackNavigator(
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
    chooseLanguageScreen: ChooseLanguageScreen,
    login: LoginScreen,
    forgetPassword: ForgetPassword,
    otpScreen: OtpScreen,
    recoveredPassword : RecoveredPassword,
    resetPassword : ResetPassword,
    userSignUpForm: UserSignUpForm,
    dashBoard:DashBoard
  
  }, 
  {
    initialRouteName: 'chooseLanguageScreen',
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

const LoginNavigationStack = createStackNavigator(
  {
    login: LoginScreen,
    forgetPassword: ForgetPassword,
    otpScreen: OtpScreen,
    recoveredPassword : RecoveredPassword,
    resetPassword : ResetPassword,
    userSignUpForm: UserSignUpForm,
    dashBoard:DashBoard
  }, 
  {
    initialRouteName: 'login',
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



const DashBoardNavigationStack = createStackNavigator(
  {
    login: LoginScreen,
    forgetPassword: ForgetPassword,
    otpScreen: OtpScreen,
    recoveredPassword : RecoveredPassword,
    resetPassword : ResetPassword,
    userSignUpForm: UserSignUpForm,
    dashBoard:DashBoard
  }, 
  {
    initialRouteName: 'dashBoard',
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

 const IntroStack =  createAppContainer(IntroNavigationStack );
 const DashBoradStack =  createAppContainer(DashBoardNavigationStack);
 const SignInStack =  createAppContainer(LoginNavigationStack);
 class App extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      langTitle: languageArray[0].label,
      langCode: languageArray[0].code,
      isFirstTime: true,
      isSigned : false
    };
    

    AsyncStorage.getItem('langCode')
      .then((code) => {
        setI18nConfig(code);
        this.loadScreen();
        this.setState({isFirstTime:false})
      })
      .catch(() => {
        setI18nConfig('en');
        this.setState({isFirstTime:false})
        this.loadScreen();
      });
  }
  loadScreen() {
   
    this.setState({isLoading: Platform.OS != 'android'});

    AsyncStorage.getItem('userdata')
      .then((value) => {
        if (!value || 0 != value.length) {
          ApiService.setToken(JSON.parse(value).access_token);
          this.setState({isSigned : true})
          Platform.OS == 'android' ? SplashScreen.hide() : null;
        }
        
      })
      .catch(() => {
        this.setState({isSigned : false})
        Platform.OS == 'android' ? SplashScreen.hide() : null;
      });
  }
  componentWillMount() {
   this.loadScreen
  }




  render() {
    console.log("LOGOUT",this.props.state.isLogout)
    const {isSigned} = this.state
    return (
      this.props.state.isLogout?<SignInStack/> : isSigned ? <DashBoradStack/>:<IntroStack/>
    );
  }
}
export default connect((state) => ( 
  {
    state: state.updateProfile,
  }),(dispatch) => ({
    actions: bindActionCreators(Action, dispatch)
  }))(App);
