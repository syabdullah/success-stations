import React, {useState} from "react";
import {View,SafeAreaView, Alert, Text, Image, FlatList, TouchableOpacity, I18nManager, Platform} from "react-native"
import DropDownSelectBox from '../../components/DropDownSelectBox'
import ButtonView from '../../components/ButtonView'
import * as RNLocalize from 'react-native-localize';
import { StackActions, NavigationActions } from 'react-navigation';
import i18n from 'i18n-js';
import {translate} from "./../util/TranslationUtils";
import RBSheet from 'react-native-raw-bottom-sheet';
import {languageArray} from './../util/DataUtil'
import AsyncStorage from '@react-native-community/async-storage'
import Loader from './Loader';
import SplashScreen from 'react-native-splash-screen'
import ApiService from '../network/ApiService';
const translationGetters = {

    en: () => require('../translations/en.json'),
    ar: () => require('../translations/ar.json'), 
};


const setI18nConfig = (lang) => {
    const fallback = { languageTag: lang, isRTL: false };
    const { languageTag, isRTL } = RNLocalize.findBestAvailableLanguage(Object.keys(translationGetters)) || fallback;
    translate.cache.clear();
    I18nManager.forceRTL(isRTL);
    i18n.translations = { [lang]: translationGetters[lang]() };
    i18n.locale = lang;
};

const resetAction = StackActions.reset({
  index: 0,
  actions: [NavigationActions.navigate({ routeName: 'dashBoard' })],
},{
  index: 1,
  actions: [NavigationActions.navigate({ routeName: 'login' })],
});
export default class ChooseLanguageScreen extends React.Component {

  static navigationOptions = ({ navigation, navigationOptions }) => {
    const { params } = navigation.state;
  
    return {
      header: () => null
        };
    };

    constructor(props) {
        super(props);
        this.state = {langTitle: languageArray[0].label, langCode: languageArray[0].code,isLoading:Platform.OS != 'android'}
    
        AsyncStorage.getItem('langCode').then((code)=> {
    
        setI18nConfig(code);
        this.loadScreen()
        }).catch(()=> {
          setI18nConfig('en')
          this.loadScreen()
        })
    }
  
    loadScreen(){
      this.setState({isLoading :  Platform.OS != 'android'})
      
      AsyncStorage.getItem('userdata').then((value)=> {
        if(!value || 0 != value.length){ 
          ApiService.setToken(JSON.parse(value).access_token)
          this.props.navigation.dispatch(resetAction)
          Platform.OS == 'android' ?  SplashScreen.hide():null
         
        }
        this.setState({isLoading : false})
         
      } ).catch(()=> {
        this.setState({isLoading : false})
      Platform.OS == 'android' ?  SplashScreen.hide():null})
    }

    componentDidMount() {
       
    }

    componentWillUnmount() {
    }



    render() {
      return (
        this.state.isLoading? <Loader
        loading={this.state.loading} /> : (
        <SafeAreaView style={{flex: 1, backgroundColor: "#F2F2F2"}}>
            <View style={{flex: 1, justifyContent: "center"}}>
                <View style={{width: 320, alignSelf: "center"}}>
                    <View style={{width: 96, height: 96, alignSelf: "center"}}>
                            <Image style={{}}
                                resizeMode="contain"
                                source={require('../../assets/language-choose-icon.png')} 
                            />
                    </View>
                    <View style={{height: 32, alignSelf: "center", marginTop: 10}}>
                        <Text style={{fontSize: 29, fontWeight: "bold", fontStyle: "normal", color: "#1C1939", fontFamily: "DMSans-Regular"}}>{translate('choose_language')}</Text>
                    </View>
                    <View style={{height: 18, alignSelf: "center", marginTop: 10}}>
                        <Text style={{fontSize: 14, fontWeight: "normal", fontStyle: "normal", color: "#1C1939", fontFamily: "DMSans-Regular"}}>{translate('please_select_your_language')}</Text>
                    </View>
                    <View style={{width: 320, height: 50, marginTop: 10}}>
                        <DropDownSelectBox 
                                selectedText={this.state.langTitle}
                                isFullWidth={true}
                                onPressEvent = {() =>{
                                    this.ChooseLanguage.open();    
                                }}
                        />
                    </View>
                    <View style={{width: 320, height: 50, marginTop: 10}}>
                            <ButtonView
                                name={translate('next')}
                                clickEvent = { () => {
                                    AsyncStorage.setItem('langCode',this.state.langCode)
                                    this.props.navigation.navigate('countrySelectScreen', { data: { code: this.state.langCode} })
                                }}
                            />
                    </View>
                </View>
                <RBSheet
              ref={(ref) => {
                this.ChooseLanguage = ref;
              }}
              height={150}>
              <View>
                <FlatList
                  data={languageArray}
                  renderItem={({item}) => {
                    return (
                      <TouchableOpacity
                        style={{
                          height: 50,
                          justifyContent: 'center',
                          alignItems: 'center',
                          borderBottomWidth: 1,
                          borderColor: '#D3D3D3',
                          backgroundColor: '#F2F2F2'
                        }}
                        onPress={() => {
                          this.ChooseLanguage.close();
                          this.setState({'langTitle': item.label})
                          this.setState({'langCode': item.code})
                          AsyncStorage.setItem('langCode',item.code)
                        
                        }}>
                        <View style={{flex: 1, justifyContent: 'center', alignItems: "stretch"}}>
                        <Text
                          style={{
                            color: 'black',
                            fontWeight: '500',
                            alignSelf: 'center',
                            fontSize: 18,
                          }}>
                          {item.label}
                        </Text>
                        </View>  
                        
                      </TouchableOpacity>
                    );
                  }}
                  keyExtractor={(item) => item.id}
                />
              </View>
            </RBSheet>
            
            </View>
        </SafeAreaView>))
    
    }
    
}