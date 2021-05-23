// React Navigate Drawer with Bottom Tab
// https://aboutreact.com/bottom-tab-view-inside-navigation-drawer/
import React, { useState } from "react";
import {Button, View, Text, SafeAreaView, Image, TouchableOpacity, TextInput, I18nManager, FlatList} from 'react-native';
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';
import MapView, { Marker } from "react-native-maps";
import InputView from '../../../../components/InputView';
import {translate} from './../../../util/TranslationUtils';
import ApiService from '../../../network/ApiService';
import Loader from '../../Loader';
import RBSheet from 'react-native-raw-bottom-sheet';
import DropDownSelectBoxWithoutImage from '../../../../components/DropDownSelectBoxWithoutImage';
import DropDownSelectBox from '../../../../components/DropDownSelectBox';
import ImagePicker from "react-native-customized-image-picker";
import ImgToBase64 from 'react-native-image-base64'
import ButtonView from '../../../../components/ButtonView';
import Helper from '../../../util/Helper';
import AsyncStorage from '@react-native-community/async-storage'

export default class MyLoacationScreen extends React.Component {

  getCountries= () =>{
    this.setState({isLoading: true});
    ApiService.get('countries')
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({countries: response.data});
        this.countriesSheet.open()
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data);
      });
  }

  getCategory= () =>{
    this.setState({isLoading: true});
    ApiService.get('listing-categories')
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({categories: response.data}) 
        this.categoryType.open()
       
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data);
      });
  }

  getRegionByCountry = () => {
    this.setState({isLoading: true});
    ApiService.get('regions', {
      country: this.state.selectedCountryId,
    })
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({regions: response.data});
        this.regionSheet.open();
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data.message);
      });
  };

  getCityByRegion = () => {
    this.setState({isLoading: true});
    ApiService.get('cities', {
      region: this.state.selectedRegionId,
    })
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({cities: response.data});
        this.citySheet.open();
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data.message);
      });
  };

  constructor(props) {
    super(props);
    this.state = {isLoading: false,borderWidth:0, countries: [],
      regions: [],
      cities: [],
      types:[],
      categories :[],
      imagePath:'',
      mime:'',
      base64Data: '',
      selectedCountry: '',
      selectedCountryId: 0,
      selectedRegionId: 0,
      selectedRegion: '',
      selectedCity: '',
      selectedCityId: 0,
      selectedCategory: '',
      selectedCategoryId: 0,
      desc: '',
      name: '',
      mobile: '',
      phone: '',
      website: '',
      email: '',
    }
  }

  componentDidMount() {

  }

  componentWillUnmount() {

  }

  validateForm = () => {
    let errorArray = [];
    if (this.state.name == '') {
      errorArray.push('Enter Name');
    }

    if (this.state.email == '') {
      errorArray.push('Enter Email');
    }

    if (Helper.isEmailValid(this.state.email)) {
      errorArray.push('Enter valid Email');
    }

    if (this.state.mobile == '') {
      errorArray.push('Enter Mobile');
    }

    if (this.state.phone == '') {
      errorArray.push('Enter Phone');
    }

    if (this.state.website == '') {
      errorArray.push('Enter website');
    }

    if (this.state.desc == '') {
      errorArray.push('Enter Description');
    }

    if (this.state.base64Data == '') {
      errorArray.push('Select Image');
    }

    if (this.state.selectedCategoryId == 0) {
      errorArray.push('Select Category');
    }

    if (this.state.selectedCountryId == 0) {
      errorArray.push('Select Country');
    }

    if (this.state.selectedRegionId == 0) {
      errorArray.push('Select Region');
    }

    if (this.state.selectedCityId == 0) {
      errorArray.push('Select City');
    }

    if (errorArray.length > 0) {
      errorText = errorArray.join('\n');
      alert(errorText);
    } else {

      AsyncStorage.getItem('userdata').then((value)=> {
        if(!value || 0 != value.length){ 
          var data = {
            "location": "Dubai",
            "catogrey_id": this.state.selectedCategoryId,
            "sub_catogery_id": "1",
            "country_id": this.state.selectedCountryId,
            "city_id": this.state.selectedCityId,
            "lat": "25.22",
            "long": "55.27",
            "description": this.state.desc,
            "user_name_id": JSON.parse(value).user_id,
            "contact_name": this.state.name,
            "phone_number": this.state.phone,
            "mobile_number": this.state.mobile,
            "website": this.state.website,
            "email": this.state.email,
            "logo":  `data:${this.state.mime};base64,${this.state.base64Data}`,
            "image": `data:${this.state.mime};base64,${this.state.base64Data}` 
        }
        this.props.navigation.navigate('SelectMyLocation',{data:data})
        }
        this.setState({isLoading : false})
      } ).catch(()=> {
      })

      
    }
  }

  render() {
    return (
      <SafeAreaView style={{flex: 1, backgroundColor: '#F2F2F2'}}>
        <View style={{flex: 1}}>
        <KeyboardAwareScrollView>
           
          <View style={{width: 120, height: 120, borderRadius: 60, backgroundColor: "red", alignSelf: "center", marginTop: 25}}>
          {this.state.base64Data.trim() == ""?  <Image
                    source={ {uri: 'https://storage.googleapis.com/stateless-campfire-pictures/2019/05/e4629f8e-defaultuserimage-15579880664l8pc.jpg'}}
                    
                    style = {{width: 120,
                      height: 120,
                      borderRadius: 60,}}
                  /> :  <Image
                  source={{uri: `data:${this.state.mime};base64,${this.state.base64Data}`}}
                  
                  style = {{width: 120,
                    height: 120,
                    borderRadius: 60,}}
                />}
            <View style={{width: 40, height: 40, position: "absolute", bottom: 0, right: 0}}>
                <TouchableOpacity onPress={() => {
                    ImagePicker.openPicker({includeBase64:true}).then(image => {

                      this.setState({base64Data:image[0].data,mime: image[0].mime })
                      
                    });
                }} style={{bottom:0, right:0, position: "absolute",width: 40, height: 40}}>
                    <Image
                      source={require('../../../../assets/Edit-Profile/camera-icon.png')}
                      resizeMode="contain" 
                      style={{width: 40, height: 40, position: "absolute", bottom: 0, right: 0}}
                   />
                </TouchableOpacity>
            </View>
            
        </View>
        <View style={{height: 50, marginTop: 10}}>
                  <InputView
                    changeTextEvent={(newValue) => {
                      this.setState({name: newValue});
                    }}
                    imageSource={require('../../../../assets/SignUp/user-icon.png')}
                    placeholderText={translate('user_name')}
                    isSecureField={false}
                    isFullWidth={true}
                  />
                </View>
  
                <View style={{height: 50, marginTop: 10}}>
                  <InputView
                    changeTextEvent={(newValue) => {
                      this.setState({email: newValue});
                    }}
                    imageSource={require('../../../../assets/SignUp/email-icon.png')}
                    placeholderText={translate('email')}
                    isSecureField={false}
                    isFullWidth={true}
                    keyboardTypeValue={"email-address"}
                  />
                </View>
  
                <View style={{height: 50, marginTop: 10}}>
                  <InputView
                    changeTextEvent={(newValue) => {
                      this.setState({mobile: newValue});
                    }}
                    imageSource={require('../../../../assets/SignUp/phone.png')}
                    placeholderText={translate('mobile_number')}
                    isSecureField={false}
                    isFullWidth={true}
                    keyboardTypeValue={"phone-pad"}
                  />
                </View>
  
                <View style={{height: 50, marginTop: 10}}>
                  <InputView
                    changeTextEvent={(newValue) => {
                      this.setState({phone: newValue});
                    }}
                    imageSource={require('../../../../assets/SignUp/phone.png')}
                    placeholderText={translate('Telephone_no')}
                    isSecureField={false}
                    isFullWidth={true}
                    keyboardTypeValue={"phone-pad"}
                  />
                </View>
  
                <View style={{height: 50, marginTop: 10}}>
                  <InputView
                    changeTextEvent={(newValue) => {
                      this.setState({website: newValue});
                    }}
                    imageSource={require('../../../../assets/SignUp/user-icon.png')}
                    placeholderText={translate('website')}
                    isSecureField={false}
                    isFullWidth={true}
                    keyboardTypeValue={"url"}
                  />
                </View>
  
                <View style={{height: 90, marginTop:10, width: 320, alignSelf: 'center'}}>
                  <TextInput
                      autoCapitalize="none"
                      autoCorrect={false}
                      style={{textAlign: I18nManager.isRTL ? 'right' : 'left', borderWidth: this.state.borderWidth, borderColor: "#0A878A", borderRadius:4, height: 90,textAlignVertical: 'top', backgroundColor: '#FFFFFF'}}
                      placeholder={`  `+translate('description')}
                      multiline={true}
                      onChangeText={text => this.setState({desc: text})}
                      onFocus = {(newValue) => {
                        this.setState({borderWidth:1})
                      
                      }}
                  />
                </View>

                <View style={{ marginTop: 10}}>
                <DropDownSelectBoxWithoutImage
                  placeholderText={translate('category')}
                  selectedText={this.state.selectedCategory}
                  isFullWidth={true}
                  onPressEvent={() => {
                    this.getCategory()
                  }}
                />
              </View>

              <View style={{ marginTop:10}}>
              <View style={{
                  width: 320,
                  alignSelf: 'center',
                }}>
                  <View
                    style={{
                      height: 50,
                      width: 320,
                    }}>
                    <DropDownSelectBox
                      placeholderText={translate('country')}
                      imageSource={require('../../../../assets/SignUp/country.png')}
                      isFullWidth={true}
                      selectedText={this.state.selectedCountry}
                      onPressEvent={() => {
                          this.getCountries();
                      }}
                    />
                  </View>
                </View>

              
              </View>

              <View style={{ marginTop:10 }}>
              <View style={{
                  width: 320,
                  alignSelf: 'center',
                }}>
                  <View
                    style={{
                      height: 50,
                      width: 320,
                    }}>
                    <DropDownSelectBox
                      placeholderText={translate('region')}
                      imageSource={require('../../../../assets/SignUp/region.png')}
                      isFullWidth={true}
                      selectedText={this.state.selectedRegion}
                      onPressEvent={() => {
                          this.getRegionByCountry();
                      }}
                    />
                  </View>
                </View>

              
              </View>

              <View style={{ marginTop:10 }}>
              <View style={{
                  width: 320,
                  alignSelf: 'center',
                }}>
                  <View
                    style={{
                      height: 50,
                      width: 320,
                    }}>
                    <DropDownSelectBox
                      placeholderText={translate('city')}
                      imageSource={require('../../../../assets/SignUp/city.png')}
                      isFullWidth={true}
                      selectedText={this.state.selectedCity}
                      onPressEvent={() => {
                          this.getCityByRegion();
                      }}
                    />
                  </View>
                </View>

              
              </View>
              <View style={{height: 50, width: 320, alignSelf: 'center', marginTop: 10,marginBottom:10}}>
                <ButtonView
                  clickEvent={() => {
                     this.validateForm();
                  }}
                  name={translate('next')}
                />
              </View>
          
        
        </KeyboardAwareScrollView>
        <RBSheet
                ref={(ref) => {
                  this.categoryType = ref;
                }}>
                <FlatList
                  data={this.state.categories}
                  style = {{backgroundColor:'white'}}
                  renderItem={({item}) => {
                    return (
                      <TouchableOpacity
                        style={{
                          height: 50,
                          justifyContent: 'center',
                          alignItems: 'center',
                          borderBottomWidth: 1,
                          borderColor: '#D3D3D3',
                        
                        }}
                        onPress={() => {
                          this.setState({selectedCategory: item.category});
                          this.setState({selectedCategoryId: item.id});
                          this.categoryType.close();
                        }}>
                        <View
                          style={{
                            flex: 1,
                            justifyContent: 'center',
                            alignItems: 'stretch',
                            
                          }}>
                          <Text
                            style={{
                              color: 'black',
                              fontWeight: '500',
                              alignSelf: 'center',
                              fontSize: 18,
                            }}>
                            {item.category}
                          </Text>
                        </View>
                      </TouchableOpacity>
                    );
                  }}
                  keyExtractor={(item) => item.id}
                />
              </RBSheet>
              <RBSheet
              ref={(ref) => {
                this.countriesSheet = ref;
              }}>
              <FlatList
                data={this.state.countries}
                renderItem={({item}) => {
                  return (
                    <TouchableOpacity
                      style={{
                        height: 50,
                        justifyContent: 'center',
                        alignItems: 'center',
                        borderBottomWidth: 1,
                        borderColor: '#D3D3D3',
            
                      }}
                      onPress={() => {
                        this.setState({selectedCountry: item.name});
                        this.setState({selectedCountryId: item.id});
                        this.countriesSheet.close();
                      }}>
                      <View
                        style={{
                          flex: 1,
                          justifyContent: 'center',
                          alignItems: 'stretch',
                        }}>
                        <Text
                          style={{
                            color: 'black',
                            fontWeight: '500',
                            alignSelf: 'center',
                            fontSize: 18,
                          }}>
                          {item.name}
                        </Text>
                      </View>
                    </TouchableOpacity>
                  );
                }}
                keyExtractor={(item) => item.id}
              />
            </RBSheet>
              <RBSheet
              ref={(ref) => {
                this.regionSheet = ref;
              }}>
              <FlatList
                data={this.state.regions}
                renderItem={({item}) => {
                  return (
                    <TouchableOpacity
                      style={{
                        height: 50,
                        justifyContent: 'center',
                        alignItems: 'center',
                        borderBottomWidth: 1,
                        borderColor: '#D3D3D3',
                    
                      }}
                      onPress={() => {
                        this.setState({selectedRegion: item.region});
                        this.setState({selectedRegionId: item.id});
                        this.regionSheet.close();
                      }}>
                      <View
                        style={{
                          flex: 1,
                          justifyContent: 'center',
                          alignItems: 'stretch',
                        }}>
                        <Text
                          style={{
                            color: 'black',
                            fontWeight: '500',
                            alignSelf: 'center',
                            fontSize: 18,
                          }}>
                          {item.region}
                        </Text>
                      </View>
                    </TouchableOpacity>
                  );
                }}
                keyExtractor={(item) => item.id}
              />
            </RBSheet>
            <RBSheet
              ref={(ref) => {
                this.citySheet = ref;
              }}>
              <FlatList
                data={this.state.cities}
                renderItem={({item}) => {
                  return (
                    <TouchableOpacity
                      style={{
                        height: 50,
                        justifyContent: 'center',
                        alignItems: 'center',
                        borderBottomWidth: 1,
                        borderColor: '#D3D3D3',
                
                      }}
                      onPress={() => {
                        this.setState({selectedCity: item.city});
                        this.setState({selectedCityId: item.id});
                        this.citySheet.close();
                      }}>
                      <View
                        style={{
                          flex: 1,
                          justifyContent: 'center',
                          alignItems: 'stretch',
                        }}>
                        <Text
                          style={{
                            color: 'black',
                            fontWeight: '500',
                            alignSelf: 'center',
                            fontSize: 18,
                          }}>
                          {item.city}
                        </Text>
                      </View>
                    </TouchableOpacity>
                  );
                }}
                keyExtractor={(item) => item.id}
              />
            </RBSheet>
        </View>
      </SafeAreaView>
    );
  }
}