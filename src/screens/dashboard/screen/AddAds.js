// React Navigate Drawer with Bottom Tab
// https://aboutreact.com/bottom-tab-view-inside-navigation-drawer/

import React, {useState} from 'react';
import {Button, View, Text, SafeAreaView, FlatList, Image, StyleSheet, TextInput, I18nManager, TouchableOpacity} from 'react-native';
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';
import InputViewWithOutImage from '../../../../components/InputViewWithOutImage';
import DropDownSelectBoxWithoutImage from '../../../../components/DropDownSelectBoxWithoutImage';
import DropDownSelectBox from '../../../../components/DropDownSelectBox';
import {translate} from '../../../util/TranslationUtils';
import AdsStepView from '../../../../components/AdsStepView'
import ArrowView from '../../../../components/ArrowView'
import ButtonView from '../../../../components/ButtonView'
import ImagePicker from "react-native-customized-image-picker";
import ApiService from '../../../network/ApiService';
import Loader from '../../Loader';
import RBSheet from 'react-native-raw-bottom-sheet';

export default class AddAdsScreen extends React.Component {
  //const [borderWidth, setBorderWidth] = useState(0)

  constructor(props) {
    super(props);
    this.state = {isLoading: false,borderWidth:0, countries: [],
      regions: [],
      cities: [],
      types:[],
      categories :[],
      types : [],
      statuses: [{title: 'New', id: 'New' },{title: 'Used', id: 'Used'}],
      selectedCountry: '',
      selectedCountryId: 0,
      selectedRegionId: 0,
      selectedRegion: '',
      selectedCity: '',
      selectedCityId: 0,
      selectedCategory: '',
      selectedCategoryId: 0,
      selectedAdType: '',
      selectedAdTypeId: 0,
      selectedStatus: '',
      selectedStatusId: ''
    }

    this.price =''
    this.description =''
    this.title =''
    this.imagePath=''
    this.mime=''
    
      
  }

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
  getAddType= () =>{
    this.setState({isLoading: true});
    ApiService.get('listing-types')
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({types: response.data}) 
        this.adType.open()
       
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

  validateForm = () => {
    let errorArray = [];
    if (this.state.selectedCategory == '') {
      errorArray.push(translate('select_category'));
    }

    if (this.state.selectedAdTypeId == 0) {
      errorArray.push(translate('select_type'));
    }

    if (this.title == '') {
      errorArray.push(translate('enter_title'));
    }

    if (this.description == '') {
      errorArray.push(translate('enter_description'));
    }

    if (this.price == '') {
      errorArray.push(translate('enter_price'));
    }

    if (this.imagePath == '') {
      errorArray.push(translate('select_image'));
    }

    if (this.state.selectedCountryId == 0) {
      errorArray.push(translate('select_country'));
    }

    if (this.state.selectedRegionId == 0) {
      errorArray.push(translate('select_region'));
    }

    if (this.state.selectedCityId == 0) {
      errorArray.push(translate('select_city'));
    }

    if (errorArray.length > 0) {
      errorText = errorArray.join('\n');
      alert(errorText);
    } else {
      let adsData = {
        title : this.title,
        description : this.description,
        price: this.price,
        category_id:this.state.selectedCategoryId,
        type_id: this.state.selectedAdTypeId,
        imagePath: this.imagePath,
        city_id: this.state.selectedCityId,
        region_id: this.state.selectedRegionId,
        country_id: this.state.selectedCountryId,
        category:this.state.selectedCategory,
        type: this.state.selectedAdType,
        city: this.state.selectedCity,
        region: this.state.selectedRegion,
        country: this.state.selectedCountry,
        status: this.state.selectedStatusId,
        mime: this.mime
    }
    
     this.props.navigation.navigate('EnterPublisherDetail',{data:adsData})
    }
    
  }

  render(){

  return (
    <SafeAreaView style={{flex: 1}}>
      <View style={{flex: 1}}>
            <KeyboardAwareScrollView>
            <View style={{flex: 1, flexDirection: "column"}}>
            <View style={{backgroundColor:"#0A878A", height: 15, alignItems: 'center'}}>
              
          </View>  
            <View style={{backgroundColor:"#0A878A", height: 80}}>
            <View style={{width:"80%", flexDirection: 'row', justifyContent: "space-between", alignSelf: "center"}}>
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
                          isSelected={false} 
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
            <View style={{flex: 1, alignItems: 'stretch', backgroundColor: '#F2F2F2', marginTop:10, width: 320, alignSelf: 'center', top: 25}}>
              <View style={{height: 80}}>
                <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('category')}</Text>
                <DropDownSelectBoxWithoutImage
                  placeholderText={translate('category')}
                  selectedText={this.state.selectedCategory}
                  isFullWidth={true}
                  onPressEvent={() => {
                    this.getCategory()
                  }}
                />
              </View>
              <View style={{height: 80, marginTop:10}}>
                <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('type')}</Text>
                <DropDownSelectBoxWithoutImage
                  placeholderText={translate('type')}
                  selectedText={this.state.selectedAdType}
                  isFullWidth={true}
                  onPressEvent={() => {
                    this.getAddType()
                  }}
                />
              </View>
              <View style={{height: 80, marginTop:10}}>
                <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('status')}</Text>
                <DropDownSelectBoxWithoutImage
                  placeholderText={translate('status')}
                  selectedText={this.state.selectedStatus}
                  isFullWidth={true}
                  onPressEvent={() => {
                    this.statusType.open();
                  }}
                />
              </View>
              <View style={{height: 80,marginTop:10}}>
                <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('title')}</Text>
                <InputViewWithOutImage
                  changeTextEvent={(newValue) => {
                    this.title = newValue
                  }}
                  placeholderText={translate('title')}
                  isFullWidth={true}
                />
              </View>
              <View style={{height: 115, marginTop:10}}>
                <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>{translate('description')}</Text>
                <TextInput
                    autoCapitalize="none"
                    autoCorrect={false}
                    style={{textAlign: I18nManager.isRTL ? 'right' : 'left', borderWidth: this.state.borderWidth, borderColor: "#0A878A", borderRadius:4, height: 90,textAlignVertical: 'top', backgroundColor: '#FFFFFF'}}
                    placeholder={`  `+translate('description')}
                    multiline={true}
                    onChangeText={text => this.description = text}
                    onFocus = {(newValue) => {
                     this.setState({borderWidth:1})
                    }}
                />
              </View>
              <View style={{height: 80,marginTop:10}}>
                <Text style={{width: "100%", fontSize:15, fontWeight:"400", fontStyle: "normal", color:"#9EA6BE", height: 25}}>Price</Text>
                <InputViewWithOutImage
                  changeTextEvent={(newValue) => {
                    this.price = newValue
                  }}
                  placeholderText={'Price'}
                  isFullWidth={true}
                  keyboardTypeValue={"decimal-pad"}
                />
              </View>

              <View style={{width: "100%", marginTop:10, height: 54, backgroundColor: "#FFA73342", borderRadius:4}}>
                  <TouchableOpacity 
                      style={{width: "100%", height: "100%", justifyContent: "center", alignItems: 'center'}}
                      onPress={() => {
                        
                        ImagePicker.openPicker({includeBase64:true}).then(image => {
                          this.imagePath = image[0].data
                          this.mime = image[0].mime
                        });
                      }

                      }
                  >
                      <View style={{width: 120, height: 20, flexDirection: "row", justifyContent: "space-between"}}>
                        <Image
                            style={{width: 24, height: 20, resizeMode: "contain"}}
                            source={require('../../../../assets/Ads/upload-icon.png')} 
                        />
                        <Text style={{fontSize:15, fontWeight: "400", fontStyle: "normal", color: "#F78A3A", width: 86, height: 20}}>Uplad Photo</Text>
                      </View>
                  </TouchableOpacity>
              </View>
              
              <View style={{ marginTop:10 }}>
              <View style={{
                  width: 320,
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
                         this.getCountries()
                      }}
                    />
                  </View>
                </View>

              
              </View>
               
              <View style={{ marginTop:10}}>
              <View style={{
                  width: 320,
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
                       this.getRegionByCountry()
                      }}
                    />
                  </View>
                </View>
                
              
              </View>
               
              <View style={{ marginTop:10}}>
              <View style={{
                  width: 320,
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
                       this.getCityByRegion()
                      }}
                    />
                  </View>
                </View>
                
              
              </View>
              <View style={{height: 50, width: 320 ,marginBottom:30,marginTop:10}}>
                <ButtonView
                  clickEvent={() => {
                    this.validateForm()
                  }}
                  name={translate('next')}
                />
              </View>
            </View>
            </View>
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
            <RBSheet
              ref={(ref) => {
                this.adType = ref;
              }}>
              <FlatList
                data={this.state.types}
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
                        this.setState({selectedAdType: item.type});
                        this.setState({selectedAdTypeId: item.id});
                        this.adType.close();
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
                          {item.type}
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
                this.statusType = ref;
              }}>
              <FlatList
                data={this.state.statuses}
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
                        this.setState({selectedStatus: item.title});
                        this.setState({selectedStatusId: item.id});
                        this.statusType.close();
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
                          {item.title}
                        </Text>
                      </View>
                    </TouchableOpacity>
                  );
                }}
                keyExtractor={(item) => item.id}
              />
            </RBSheet>
            </KeyboardAwareScrollView>
            {this.state.isLoading ? <Loader loading={this.state.loading} /> : null}
      </View>
    </SafeAreaView>
  );
              }
}

const styles = StyleSheet.create({
  baseText: {
    fontFamily: "Cochin"
  },
  titleText: {
    fontSize: 28,
    fontWeight: "500",
    textAlign: "center", 
    color: "white"
  },
  stepTitleText: {
    fontSize: 14,
    fontWeight: "400",
    textAlign: "center", 
    color: "white"
  },
  stepNumberText: {
    fontSize: 17,
    fontWeight: "700",
    color: "#F78A3A",
    width:20,
    height:20,
    alignSelf: "center",
  },
  inputFullViewStyle: {
    borderWidth: 1,
    borderColor: "#0A878A",
    height: 100,
    width: 320,
    borderRadius: 4,
    alignItems: "stretch",
    alignSelf: "center",
    justifyContent: "space-between",
    flexDirection: "row"
}
});

