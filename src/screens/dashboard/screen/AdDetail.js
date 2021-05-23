import React, {useState} from 'react';
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  SafeAreaView,
  TouchableOpacity,
  Image,
  TextInput,
  I18nManager,
  Button,
} from 'react-native';
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';
import DisplayBookInformation from '../../../../components/DisplayBookInformation';
import InputViewWithOutImage from '../../../../components/InputViewWithOutImage';
import {translate} from '../../../util/TranslationUtils';
import ButtonView from '../../../../components/ButtonView';
import BorderButton from '../../../../components/BorderButton';
import AdsStepView from '../../../../components/AdsStepView'
import ArrowView from '../../../../components/ArrowView'
import ApiService from '../../../network/ApiService';
import AsyncStorage from '@react-native-community/async-storage'
import Loader from './../../Loader';

  export default class AdDetail extends React.Component {
  

    constructor(props) {
      super(props);
      this.state = {isLoading: false,
        borderWidth:0,
        
      }
      this.adsData = this.props.route.params.data
      this.userData =''
      AsyncStorage.getItem('userdata').then((value)=> {
        if(!value || 0 != value.length){ 
          this.userData = JSON.parse(value)
        }
      } )
      
        
    }

    postAds =()=>{
      this.adsData.image = `data:${this.adsData.mime};base64,${this.adsData.imagePath}`
      this.adsData.user_name_id = this.userData.user_id
      this.setState({isLoading: true});
      ApiService.post('listings-create',this.adsData)
    .then((response) => {
        this.setState({isLoading: false});
        this.props.navigation.navigate('MyAdsList' ,{data:{update:true}})
    })
    .catch ((error)=> {
        this.setState({isLoading : false})
        alert(error.data.message)
    })
    }

    render(){

    return (
        <SafeAreaView style={{flex: 1, backgroundColor: '#F2F2F2'}}>
          <View style={{flex: 1, backgroundColor: '#F2F2F2'}}>
            <KeyboardAwareScrollView>
                <View style={{backgroundColor: '#F2F2F2', flexDirection: 'column'}}>
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
                        isSelected={true} 
                      />
                    </View>
                    
                  </View>
                  <View style={{width: "25%", height: 65, alignSelf: "center"}}>
                    <View style={{alignSelf: "center"}}>
                      <AdsStepView
                            isSelected={true} 
                            displayText={translate('review_publish')}
                            stepNo={translate('03')}
                        />
                    </View>
                  </View> 
              </View>
          </View>
                    <View style={{height: 280, width: "100%"}}>
            
                        <Image style={{width: "100%",height:280}}
                          
                            source={{
                              uri : `data:${this.adsData.mime};base64,${this.adsData.imagePath}` }} 
                        />
                    </View>
                    <View style={{width: "100%"}}>
                        <Text style={{marginLeft: 15, marginTop: 15, marginRight: 15, fontSize: 20, fontStyle: "normal", color: "#000"}}>
                        {this.adsData.title}
                        </Text>
                        <Text style={{marginLeft: 15, marginTop: 15, marginRight: 15, fontSize: 20, fontStyle: "normal", color: "#0A878A"}}>
                        SR {this.adsData.price}
                        </Text>
                    </View>
                    <View style={{width: "100%", height: 6, backgroundColor: "#F4F7FC", marginTop: 25}}></View>
                    <View style={{width: "100%", height: 80, justifyContent: 'space-between', flexDirection: "column"}}>
                        <View style={{width: "80%", height: 40, justifyContent: 'space-between', flexDirection: "row"}}>
                            <View style={{width: "25%", marginLeft: 15}}>
                                <DisplayBookInformation 
                                    heading="City"
                                    headingValue={this.adsData.city}
                                />
                            </View>
                            <View style={{width: "25%", marginLeft: 15}}>
                                <DisplayBookInformation 
                                    heading="Type"
                                    headingValue={this.adsData.type}
                                />
                            </View>
                        </View>
                        <View style={{width: "80%", height: 40, justifyContent: 'space-between', flexDirection: "row"}}>
                            <View style={{width: 100, marginLeft: 15}}>
                                <DisplayBookInformation 
                                    heading="Ad Number"
                                    headingValue={this.adsData.phone}
                                />
                            </View>
                            <View style={{width: "25%", marginLeft: 15}}>
                                <DisplayBookInformation 
                                    heading="Section"
                                    headingValue={this.adsData.category}
                                />
                            </View>
                        </View>
                    </View>
                    <View style={{width: "100%", height: 6, backgroundColor: "#F4F7FC"}}></View>
                    <View style={{width: "100%", flexDirection: "column", justifyContent: "space-between"}}>
                        <Text style={{marginLeft: 15, fontSize: 20, fontStyle: "normal", color: "#000", fontweight: "700"}}>
                        {translate('details')}
                        </Text>
                        <Text style={{marginLeft: 15, fontSize: 12, fontStyle: "normal", color: "#000", fontweight: "500", marginTop: 15}}>
                        {this.adsData.description}
                        </Text>
                    </View>
                    <View style={{width: "100%", height: 6, backgroundColor: "#F4F7FC"}}></View>
                    <View style={{flex:1,justifyContent:"center"}}>
                  
                    <View style={{ width: 320, marginTop:10,marginBottom:10, justifyContent:'space-between', flexDirection: 'row',  alignSelf: "center"}}>
                        <View style={{width: "48%", height: "100%"}}>
                        <BorderButton
                            clickEvent={() => {
                              this.props.navigation.pop();
                            }}
                            name={translate('previous')}
                        />
                        </View>

                        <View style={{width: "48%", height: "100%"}}>
                        <ButtonView
                            clickEvent={() => {
                            this.postAds()
                           
                            }}
                            name={translate('publish')}
                        />
                        </View>
                    </View>
                </View>
                </View>
            </KeyboardAwareScrollView>
            {this.state.isLoading ? <Loader loading={this.state.loading} /> : null}
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

