import React from 'react';
import {
  View,
  Text,
  StyleSheet,
  SafeAreaView,
  Image,
  TextInput,
  I18nManager,
} from 'react-native';
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';
import InputViewWithOutImage from '../../../../components/InputViewWithOutImage';
import {translate} from '../../../util/TranslationUtils';
import ButtonView from '../../../../components/ButtonView';
import BorderButton from '../../../../components/BorderButton';
import AdsStepView from '../../../../components/AdsStepView'
import Helper from '../../../util/Helper';

import ArrowView from '../../../../components/ArrowView'


  export default class EnterPublisherDetail extends React.Component {
  
    constructor(props) {
      super(props);
      this.state = {isLoading: false,
        borderWidth:0,
      }
  
      this.name =''
      this.email =''
      this.mobileNo =''
      this.telNo=''
      this.notes=''
      this.adsData = this.props.route.params.data
      
        
    }
  
    validateForm = () => {
      let errorArray = [];
      if (this.name == '') {
        errorArray.push(translate('enter_user_name'));
      }
  
      if (this.email == '') {
        errorArray.push(translate('enter_email'));
      }
  
      if (Helper.isEmailValid(this.email)) {
        errorArray.push(translate('enter_valid_email'));
      }
  
      if (this.mobileNo == '') {
        errorArray.push(translate('enter_mobile'));
      }

      if (errorArray.length > 0) {
        errorText = errorArray.join('\n');
        alert(errorText);
      } else {

        this.adsData.contact_name= this.name
        this.adsData.email= this.email
        this.adsData.notes= this.notes
        this.adsData.phone= this.mobileNo
        this.adsData.telNo= this.telNo

        this.props.navigation.navigate('AdDetail',{data: this.adsData})
      }
    }

  render(){
  return (
    <SafeAreaView style={{flex: 1, backgroundColor: '#F2F2F2'}}>
      <View style={{flex: 1, backgroundColor: '#F2F2F2'}}>
        <KeyboardAwareScrollView>
        <View style={{backgroundColor: "#0A878A", height:200, width: "100%"}}>
        <View style={{backgroundColor:"#0A878A", height: 15, alignItems: 'center'}}>
        </View>
        <View style={{height: 65, width:"85%", flexDirection: 'row', top: 25, justifyContent: "space-between", alignSelf: "center"}}>
                  <View style={{width: "32%", height: 65, flexDirection: "row", justifyContent: "space-between"}}>
                    <View>
                      <AdsStepView
                          isSelected={true} 
                          displayText={translate('announce_new')}
                          stepNo={translate('01')}
                      />
                    </View>
                    <View style={{justifyContent: 'center'}}>
                      <ArrowView
                        isSelected={true} 
                        style={{alignSelf: 'center'}}
                      />
                    </View>
                  </View>
                  <View style={{width: "32%", height: 65, flexDirection: "row", justifyContent: "space-between"}}>
                    <View>
                      <AdsStepView
                          isSelected={true} 
                          displayText={translate('contact_information')}
                          stepNo={translate('02')}
                      />
                    </View>
                    <View style={{justifyContent: 'center'}}>
                      <ArrowView
                        isSelected={false} 
                      />
                    </View>
                    
                  </View>
                  <View style={{width: "25%", height: 65, alignSelf: "center"}}>
                    <View style={{alignSelf: "center"}}>
                      <AdsStepView
                            isSelected={false} 
                            displayText={translate('review_publish')}
                            stepNo={translate('03')}
                        />
                    </View>
                  </View> 
              </View>
          </View>
          <View style={{flex: 1, alignItems: 'stretch', backgroundColor: '#F2F2F2', justifyContent: 'space-between', height: 700, width: 320, alignSelf: 'center'}}>
            <View style={{height: 30, width: 320}}></View>
            <View style={{height: 80, justifyContent: 'space-between'}}>
              <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('full_name')}</Text>
              <InputViewWithOutImage
                changeTextEvent={(newValue) => {
                  this.name = newValue
                }}
                placeholderText={translate('full_name')}
                isFullWidth={true}
              />
            </View>
            <View style={{height: 80, justifyContent: 'space-between'}}>
              <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('mobile_no')}</Text>
              <InputViewWithOutImage
                changeTextEvent={(newValue) => {
                  this.mobileNo = newValue
                }}
                placeholderText={translate('mobile_no')}
                isFullWidth={true}
                keyboardTypeValue={"phone-pad"}
              />
            </View>
            <View style={{height: 80, justifyContent: 'space-between'}}>
              <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('Telephone_no')}</Text>
              <InputViewWithOutImage
                changeTextEvent={(newValue) => {
                  this.telNo = newValue
                }}
                placeholderText={translate('Telephone_no')}
                isFullWidth={true}
                keyboardTypeValue={"phone-pad"}
              />
            </View>
            <View style={{height: 80, justifyContent: 'space-between'}}>
              <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('email')}</Text>
              <InputViewWithOutImage
                changeTextEvent={(newValue) => {
                  this.email = newValue
                }}
                placeholderText={translate('email')}
                isFullWidth={true}
                keyboardTypeValue={"email-address"}
              />
            </View>
            <View style={{height: 120, justifyContent: 'space-between'}}>
            <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('notes')}</Text>
              <TextInput
                  autoCapitalize="none"
                  autoCorrect={false}
                  style={{textAlign: I18nManager.isRTL ? 'right' : 'left', borderWidth: this.state.borderWidth, borderColor: "#0A878A", borderRadius:4, height: 90, backgroundColor: '#FFFFFF',textAlignVertical: 'top',}}
                  placeholder={`  `+translate('notes')}
                  multiline={true}
                  onChangeText={text => this.notes = text}
                  onFocus = {(newValue) => {
                    this.setState({borderWidth:1})
                    
                  }}
              />
            </View>
            <View style={{height: 80, width: 320, flexDirection: 'row', justifyContent: 'space-between'}}>
              <View style={{width: "48%", height: "100%"}}>
              <BorderButton
                clickEvent={() => {
                  navigation.pop();
                }}
                name={translate('previous')}
              />
              </View>

              <View style={{width: "48%", height: "100%"}}>
              <ButtonView
                clickEvent={() => {
                  this.validateForm()
                }}
                name={translate('next')}
              />
              </View>
              
            </View>
          </View>
        </KeyboardAwareScrollView>
      </View>
    </SafeAreaView>
  );
}
}

const style = StyleSheet.create({
  mainViewStyle: {
    flex: 1,
    alignItems: 'stretch',
    backgroundColor: '#F2F2F2',
    justifyContent: 'space-between',
    height: 500,
    width: 320,
    alignSelf: 'center',
  },
  dontHaveAccountViewStyle: {
    width: 280,
    alignSelf: 'center',
    height: 25,
    borderColor: 'red',
    borderWidth: 0,
    alignItems: 'center',
  },
  dontHaveAccountTextStyle: {
    textAlignVertical: 'center',
    fontSize: 15,
    fontWeight: '400',
    fontStyle: 'normal',
    color: '#2C2948',
  },
  dontHaveSignUpTextStyle: {
    textAlignVertical: 'center',
    fontSize: 15,
    fontWeight: '700',
    fontStyle: 'normal',
    color: '#F78A3A',
  },
  titleText: {
    fontSize: 28,
    fontWeight: "500",
    textAlign: "center", 
    color: "white"
  }
});
