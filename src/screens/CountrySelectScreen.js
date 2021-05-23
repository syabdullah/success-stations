import React from "react";
import { View, Text, StyleSheet, Image, TouchableOpacity, I18nManager, SafeAreaView } from "react-native";
import { FlatList } from "react-native-gesture-handler";
import * as RNLocalize from 'react-native-localize';
import i18n from 'i18n-js';
import {translate} from "./../util/TranslationUtils";
import AsyncStorage from '@react-native-community/async-storage'
//import Loading from 'react-native-whc-loading'

    const translationGetters = {

        en: () => require('../translations/en.json'),
        ar: () => require('../translations/ar.json'),
    };
  

    const setI18nConfig = (lang) => {
        const fallback = { languageTag: 'ar', isRTL: false };
        const { languageTag, isRTL } = RNLocalize.findBestAvailableLanguage(Object.keys(translationGetters)) || fallback;
        translate.cache.clear();
        I18nManager.forceRTL(isRTL);
        i18n.translations = { [lang]: translationGetters[lang]() };
        i18n.locale = lang;
  };
  
  




export default class CountrySelectScreen extends React.Component {

    countryData = [
        {name: this.getLanguageCode() == 'en' ? 'Saudi Arabia': 'المملكة العربية السعودية', id: 1, image: require('../../assets/Flags/saudi-arab-flag.png'), isHidden: true, 'lang': 'ar'},
        {name: this.getLanguageCode() == 'en' ? 'UAE': 'الإمارات العربية المتحدة', id: 2, image: require('../../assets/Flags/uae-flag.png'), isHidden: true, 'lang': 'ar'},
        {name: this.getLanguageCode() == 'en' ? 'Egypt': 'مصر', id: 3, image: require('../../assets/Flags/egypt-flag.png'), isHidden: true, 'lang': 'ar'},
        {name: this.getLanguageCode() == 'en' ? 'Kuwait': 'الكويت', id: 4, image: require('../../assets/Flags/kuwait-flag.png'), isHidden: true, 'lang': 'en'},
        {name: this.getLanguageCode() == 'en' ? 'Amman': 'عمان', id: 5, image: require('../../assets/Flags/damman-flag.png'), isHidden: true, 'lang': 'ar'},
        {name: this.getLanguageCode() == 'en' ? 'Jordan': 'الأردن', id: 6, image: require('../../assets/Flags/jordan-flag.png'), isHidden: true, 'lang': 'ar'},
        {name: this.getLanguageCode() == 'en' ? 'Bahrain': 'البحرين', id: 7, image: require('../../assets/Flags/bahrain-flag.png'), isHidden: true, 'lang': 'ar'},
    ];

    static navigationOptions = ({ navigation, navigationOptions }) => {
        return {
            title: translate('choose_country')
        };
    };

    constructor(props) {
        super(props);
        AsyncStorage.getItem('langCode').then((code)=> {
            setI18nConfig(code)
            }).catch(()=> {
                setI18nConfig('en')
            })
        this.state = {country : this.countryData}
        this.langCode = props.navigation.state.params.data.code
      }
  
    componentDidMount() {
        RNLocalize.addEventListener('change', this.handleLocalizationChange);
    }

    componentWillUnmount() {
        RNLocalize.removeEventListener('change', this.handleLocalizationChange);
    }

    handleLocalizationChange = (lang) => {
        // setI18nConfig(lang);
    };

    getLanguageCode (){
        return this.props.navigation.state.params.data.code
    }
  
render(){
    var data = this.state.country
    return (
    
        <SafeAreaView style={{flex: 1}}>
            <View style={styles.mainViewStyle}>
            <View style={{}}> 
                <FlatList
                    keyExtractor = {(item) => item.id} 
                    data = {data}
                    renderItem = { ({item}) => {
                            return (
                                <TouchableOpacity onPress={ () => {
                                    var array = []
                                    var langCode = ''
                                    data.forEach(element => {
                                        if (element.id == item.id) {
                                            element.isHidden = false
                                            langCode = element.lang
                                        } else {
                                            element.isHidden = true
                                        }
                                        array.push(element)
                                    }
                                        
                                    );
                                    this.setState({country : array})
                                    this.handleLocalizationChange(langCode)
                                    this.props.navigation.navigate('login')
                                }}>
                                    <View style={styles.countryNameStyle}>
                                        <Image 
                                            source={item.image} 
                                            style={styles.imageStyle} 
                                        />
                                        <Text style={styles.countryNameTextStyle}>{item.name}</Text>
                                        <View style={[styles.roundViewStyle, item.isHidden ? styles.roundViewStyle : styles.roundViewStyleWithoutBorder]}>
                                            <Image
                                                source={require('../../assets/yellow-check-mark.png')}
                                                style={{display: item.isHidden ? "none" :  "flex", width: 20, height: 20}}
                                            />
                                        </View>
                                    </View>
                                </TouchableOpacity>
                                
                            )
                        }
                    } 
                />
            </View>     
      
            </View>
        </SafeAreaView>
    )   
}
}

const styles = StyleSheet.create({
    mainViewStyle: {
        backgroundColor: "#F2F2F2",
        alignItems: "stretch",
        flexDirection: "column",
    },
    headingViewStyle: {
        top: 90
    },
    countryNameStyle: {
        height: 70,
        justifyContent: 'center',
        borderBottomWidth: 1,
        borderColor: "white"
    },
    countryNameTextStyle: {
        fontSize: 18,
        lineHeight: 38,
        textAlign: "left",
        flex: 1,
        position: "absolute",
        left: 82,
        fontFamily: "DMSans-Regular",
        fontWeight: "500"
    },
    headingStyle: {
        fontWeight: "bold",
        fontStyle: "normal",
        fontSize: 29,
        lineHeight: 38,
        textAlign: "center",
    },
    imageStyle: {
        left: 19,
        width: 52,
        height: 33,
        position: "absolute",
        alignSelf: "center",
        resizeMode: 'contain',
    },
    roundViewStyle: {
        width: 20,
        height: 20,
        borderRadius: 10,
        borderColor: "#5D648A",
        borderWidth: 1,
        right: 20,
        alignSelf: "flex-end"
    },
    roundViewStyleWithoutBorder: {
        width: 20,
        height: 20,
        borderRadius: 10,
        borderColor: "#F2F2F2",
        borderWidth: 1,
        right: 20,
        alignSelf: "flex-end"
    }
  });
  

