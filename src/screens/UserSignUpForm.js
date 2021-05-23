import React, {useState} from 'react';
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  SafeAreaView,
  TouchableOpacity,
  Image,
  ActivityIndicator,
} from 'react-native';
import {KeyboardAwareScrollView} from 'react-native-keyboard-aware-scroll-view';
import DropDownSelectBox from '../../components/DropDownSelectBox';
import InputView from '../../components/InputView';
import {translate} from './../util/TranslationUtils';
import ButtonView from '../../components/ButtonView';
import RBSheet from 'react-native-raw-bottom-sheet';
import {userType} from './../util/DataUtil';
import CalendarPicker from 'react-native-calendar-picker';
import DynamicTabView from 'react-native-dynamic-tab-view';
import RadioForm, {
  RadioButton,
  RadioButtonInput,
  RadioButtonLabel,
} from 'react-native-simple-radio-button';
import ApiService from '../network/ApiService';
import Helper from '../util/Helper';
import Loader from './Loader';

export default class UserSignUpForm extends React.Component {

  static navigationOptions = ({navigation, navigationOptions}) => {
    return {
      title: '',
    };
  };

  constructor(props) {
    super(props);

    this.state = {
      isLoading: false,
      selectedUserType: 'student',
      isDobVisible: false,
      viewHeight: 900,
      dateOfBirth: '',
      index: 0,
      universities: [],
      colleges: [],
      countries: [],
      regions: [],
      cities: [],
      selectedUniversity: '',
      selectedUniversityId: 0,
      selectedCollege: '',
      selectedCollegeId: 0,
      selectedCountry: '',
      selectedCountryId: 0,
      selectedRegionId: 0,
      selectedRegion: '',
      selectedCity: '',
      selectedCityId: 0,
      userName: '',
      email: '',
      mobileNumber: '',
      crNo: '',
      iqamaNo: '',
    };
    //this.setState({selectedRegion: item.region});
    //this.setState({selectedRegionId: item.id});
    this.data = [
      {title: translate('student'), key: '3', type: 'student'},
      {title: translate('company'), key: '1', type: 'company'},
    ];
  }

  getCountries() {
    ApiService.get('countries')
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({countries: response.data});
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

  getUniversities() {
    this.setState({isLoading: true});
    ApiService.get('universities', {
      country: this.state.selectedCountryId,
    })
      .then((response) => {
        this.setState({universities: response.data});
        this.setState({isLoading: false});
        this.universitySheet.open();
      })
      .catch((error) => {
        alert(error.data.message);
      });
  }

  getCollegeByUniversities = () => {
    this.setState({isLoading: true});
    ApiService.get('colleges', {
      university: this.state.selectedUniversityId,
    })
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({colleges: response.data});
        this.collegeSheet.open();
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data.message);
      });
  };

  resetEveryThing = () => {
    this.setState({selectedUniversity: '',
    selectedUniversityId: 0,
    selectedCollege: '',
    selectedCollegeId: 0,
    selectedCountry: '',
    selectedCountryId: 0,
    selectedRegionId: 0,
    selectedRegion: '',
    selectedCity: '',
    selectedCityId: 0,})


  }

  startSignUp() {
    let errorArray = [];
    if (this.state.userName == '') {
      errorArray.push(translate('enter_user_name'));
    }

    if (this.state.email == '') {
      errorArray.push(translate('enter_email'));
    }

    if (Helper.isEmailValid(this.state.email)) {
      errorArray.push(translate('enter_valid_email'));
    }

    if (this.state.mobileNumber == '') {
      errorArray.push(translate('enter_mobile'));
    }

    if (this.state.selectedCountryId == 0) {
      errorArray.push(translate('select_country'));
    }

    if (this.state.selectedCityId == 0) {
      errorArray.push(translate('select_city'));
    }

    if (this.state.selectedRegionId == 0) {
      errorArray.push(translate('select_region'));
    }

    if (this.state.selectedUserType == 'student') {
      if (this.state.dateOfBirth == '') {
        errorArray.push(translate('select_date_of_birth'));
      }

      if (this.state.selectedCollegeId == '') {
        errorArray.push(translate('select_college'));
      }

      if (this.state.selectedUniversityId == 0) {
        errorArray.push(translate('select_university'));
      }
    } else if (this.state.selectedUserType == 'company') {
      if (this.state.crNo == '') {
        errorArray.push(translate('enter_cr_number'));
      }
    } else if (this.state.selectedUserType == 'individual') {
      if (this.state.dateOfBirth == '') {
        errorArray.push(translate('select_date_of_birth'));
      }

      if (this.state.iqamaNo == '') {
        errorArray.push(translate('enter_iqama_number'));
      }
    }

    if (errorArray.length > 0) {
      errorText = errorArray.join('\n');
      alert(errorText);
    } else {
      this.setState({isLoading: true});
      let type = 2
      if(this.state.selectedUserType == 'company'){
        type = 4
      }else  if(this.state.selectedUserType == 'individual'){
        type = 3
      }
      const data = {
        name: this.state.userName,
        email: this.state.email,
        mobile: this.state.mobileNumber,
        country_id: this.state.selectedCountryId.toString(),
        city_id: this.state.selectedCityId.toString(),
        region_id: this.state.selectedRegionId,
        user_type: type.toString(),
        date_of_birth: this.state.dateOfBirth,
        college_id: this.state.selectedCollegeId,
        university_id: this.state.selectedUniversityId.toString(),
        iqama_number: this.state.iqamaNo,
        cr_number: this.state.crNo,
      };

      ApiService.post('register', data)
        .then((response) => {
          this.setState({isLoading: false});
          this.props.navigation.navigate('otpScreen', {data: response})
        })
        .catch((error) => {
          this.setState({isLoading: false});
        alert(error.data.message)
        });
    }
  };

  componentDidMount() {
    this.setState({isLoading: true});
    this.getCountries();
  }

  componentWillUnmount() {}
  setUserType = (userType) => {
    this.setState({selectedUserType: userType});
  };
  setIsDobVisible = (isDobVisible) => {
    this.setState({isDobVisible: isDobVisible});
  };
  setViewHeight = (viewHeight) => {
    this.setState({viewHeight: viewHeight});
  };
  setDateOfBirth = (dateOfBirth) => {
    this.setState({dateOfBirth: dateOfBirth});
  };

  render() {
    return (
      <SafeAreaView style={{flex: 1, backgroundColor: '#F2F2F2'}}>
        <View style={{flex: 1, backgroundColor: '#F2F2F2'}}>
          <KeyboardAwareScrollView>
            <View
              style={{
                flex: 1,
                alignItems: 'stretch',
                backgroundColor: '#F2F2F2',
                justifyContent: 'space-between',
                height: this.state.viewHeight,
                width: 320,
                alignSelf: 'center',
              }}>
              <View style={{width: 320, height: 122}}>
                <Image
                  style={{resizeMode: 'contain', alignSelf: 'center'}}
                  source={require('../../assets/logo.png')}
                />
              </View>
              <View style={{height: 50, width: 320}}>
                <Text style={{textAlign: 'center', fontFamily: "DMSans-Regular", fontWeight: "400"}}>
                  {translate('sign_up_desc')}
                </Text>
              </View>
              <View
                style={{
                  width: '80%',
                  height: 60,
                  justifyContent: 'center',
                  alignSelf: 'center',
                }}>
                <DynamicTabView
                  data={this.data}
                  renderTab={() => <View style={{flex: 1, height: 1}} />}
                  defaultIndex={this.state.defaultIndex}
                  containerStyle={style.container2}
                  headerBackgroundColor={'#F2F2F2'}
                  headerTextStyle={style.headerText}
                  onChangeTab={(item) => {
                    if (this.data[item].type == 'student') {
                      this.setViewHeight(900);
                    } else {
                      this.setViewHeight(800);
                    }
                    this.setUserType(this.data[item].type);
                  }}
                  headerUnderlayColor={'#F78A3A'}
                />
              </View>
              <View style={{height: 50}}>
                <InputView
                  changeTextEvent={(newValue) => {
                    this.setState({userName: newValue});
                  }}
                  imageSource={require('../../assets/SignUp/user-icon.png')}
                  placeholderText={translate('user_name')}
                  isSecureField={false}
                  isFullWidth={true}
                />
              </View>
              <View style={{height: 50}}>
                <InputView
                  changeTextEvent={(newValue) => {
                    this.setState({email: newValue});
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
                  changeTextEvent={(newValue) => {
                    this.setState({mobileNumber: newValue});
                  }}
                  imageSource={require('../../assets/SignUp/phone.png')}
                  placeholderText={translate('mobile_number')}
                  isSecureField={false}
                  isFullWidth={true}
                  keyboardTypeValue={"phone-pad"}
                />
              </View>
              {this.state.selectedUserType === 'company' ||
              this.state.selectedUserType === 'individual' ? (
                <View
                  style={{height: 50, width: 320, justifyContent: 'flex-end'}}>
                  <RadioForm
                    radio_props={[
                      {label: translate('company'), value: 'company'},
                      {label: translate('individual'), value: 'individual'},
                    ]}
                    initial={0}
                    formHorizontal={true}
                    selectedButtonColor={'#F78A3A'}
                    buttonColor={'#F78A3A'}
                    labelStyle={{marginRight: 15}}
                    onPress={(item) => {
                      if (item == 'individual') {
                        this.setViewHeight(850);
                      } else {
                        this.setViewHeight(800);
                      }
                      this.setUserType(item);
                    }}
                  />
                </View>
              ) : null}
              {this.state.selectedUserType === 'student' ||
              this.state.selectedUserType === 'individual' ? (
                <View>
                  <View style={{height: 50}}>
                    <DropDownSelectBox
                      placeholderText={translate('dob')}
                      imageSource={require('../../assets/SignUp/dob.png')}
                      isFullWidth={true}
                      selectedText={this.state.dateOfBirth}
                      onPressEvent={() => {
                        this.calendar.open();
                      }}
                    />
                  </View>
                </View>
              ) : null}
              {this.state.selectedUserType === 'student' ||
              this.state.selectedUserType === 'individual' ||
              this.state.selectedUserType === 'company' ? (
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
                      imageSource={require('../../assets/SignUp/country.png')}
                      isFullWidth={true}
                      selectedText={this.state.selectedCountry}
                      onPressEvent={() => {
                        this.resetEveryThing();
                        this.countriesSheet.open();
                      }}
                    />
                  </View>
                </View>
              ) : null}

{this.state.selectedUserType === 'student' ||
              this.state.selectedUserType === 'individual' ||
              this.state.selectedUserType === 'company' ? (
              <View style={{ width: 320,}}>

                  <View
                    style={{
                      height: 50,
                      width: 320,
                    }}>
                    <DropDownSelectBox
                      placeholderText={translate('region')}
                      imageSource={require('../../assets/SignUp/region.png')}
                      isFullWidth={true}
                      selectedText={this.state.selectedRegion}
                      onPressEvent={() => {
                        if (this.state.selectedCountryId == 0) {
                          alert('Please select country')
                        } else {
                          this.getRegionByCountry()
                        }
                        
                      }}
                    />
                  </View>
              </View>
              ): null}

{this.state.selectedUserType === 'student' ||
              this.state.selectedUserType === 'individual' ||
              this.state.selectedUserType === 'company' ? (
              <View style={{ width: 320,}}>
              <View
                    style={{
                      height: 50,
                      width: 320,
                    }}>
                    <DropDownSelectBox
                      placeholderText={translate('city')}
                      imageSource={require('../../assets/SignUp/city.png')}
                      isFullWidth={true}
                      selectedText={this.state.selectedCity}
                      onPressEvent={() => {
                        if (this.state.selectedRegionId == 0) {
                          alert('Please select region')
                        } else {
                          this.getCityByRegion()
                        }
                      }}
                    />
                  </View>
              </View>): null}

              {this.state.selectedUserType === 'student' ? (
                <View>
                  <View style={{height: 50, width: 320}}>
                    <DropDownSelectBox
                      placeholderText={translate('university')}
                      imageSource={require('../../assets/SignUp/university.png')}
                      isFullWidth={true}
                      selectedText={this.state.selectedUniversity}
                      onPressEvent={() => {
                        if (this.state.selectedCountryId == 0) {
                          alert('Please select country')
                        } else {
                          this.getUniversities()
                        }
                      }}
                    />
                  </View>
                </View>
              ) : null}

{this.state.selectedUserType === 'student' ? (
                <View>
                  <View
                    style={{
                      height: 50,
                      width: 320,
                      justifyContent: 'space-between',
                      flexDirection: 'row',
                    }}>

                    <DropDownSelectBox
                      placeholderText={translate('college')}
                      imageSource={require('../../assets/SignUp/graduate.png')}
                      isFullWidth={true}
                      selectedText={this.state.selectedCollege}
                      onPressEvent={() => {
                        if (this.state.selectedUniversityId == 0) {
                          alert('Please select university')
                        } else {
                          this.getCollegeByUniversities()
                        }
                      }}
                    />
                  </View>
                </View>): null}

              {this.state.selectedUserType === 'individual' ? (
                <View>
                  <View style={{height: 50, width: 320}}>
                    <InputView
                      changeTextEvent={(newValue) => {
                        this.setState({iqamaNo: newValue});
                      }}
                      imageSource={require('../../assets/SignUp/university.png')}
                      placeholderText={translate('Iqama_number')}
                      style={{width: 150}}
                      isFullWidth={true}
                    />
                  </View>
                </View>
              ) : null}
              {this.state.selectedUserType === 'company' ? (
                <View>
                  <View style={{height: 50, width: 320}}>
                    <InputView
                      changeTextEvent={(newValue) => {
                        this.setState({crNo: newValue});
                      }}
                      imageSource={require('../../assets/SignUp/university.png')}
                      placeholderText={translate('cr_no')}
                      style={{width: 150}}
                      isFullWidth={true}
                    />
                  </View>
                </View>
              ) : null}
              <View style={{height: 50, width: 320}}>
                <ButtonView
                  clickEvent={() => {
                    this.startSignUp();
                  }}
                  name={translate('sign_up_btn_text')}
                />
              </View>
              <View style={style.dontHaveAccountViewStyle}>
                <TouchableOpacity
                  onPress={() => {
                    this.props.navigation.navigate('userSignUpForm');
                  }}>
                  <View style={{flexDirection: 'row'}}>
                    <Text style={style.dontHaveAccountTextStyle}>
                      {translate('already_login_text')}
                    </Text>
                    <Text style={style.dontHaveSignUpTextStyle}>
                      {translate('sign_in_with_dash')}
                    </Text>
                  </View>
                </TouchableOpacity>
              </View>
            </View>
            <RBSheet
              ref={(ref) => {
                this.Standard = ref;
              }}
              height={150}>
              <View>
                <FlatList
                  data={userType}
                  renderItem={({item}) => {
                    return (
                      <TouchableOpacity
                        style={{
                          height: 50,
                          justifyContent: 'center',
                          alignItems: 'center',
                          borderBottomWidth: 1,
                          borderColor: '#D3D3D3',
                          backgroundColor: '#F2F2F2',
                        }}
                        onPress={() => {
                          this.Standard.close();
                          this.setUserType(item);
                          if (item.id == 1) {
                            this.setViewHeight(750 + 80);
                          } else if (item.id == 2) {
                            this.setViewHeight(650 + 80);
                          } else {
                            this.setViewHeight(580 + 60);
                          }
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
            <RBSheet
              ref={(ref) => {
                this.calendar = ref;
              }}
              height={400}>
              <View
                style={{
                  height: 400,
                  justifyContent: 'center',
                  alignItems: 'center',
                  backgroundColor: '#F2F2F2',
                }}>
                <CalendarPicker
                  startFromMonday={true}
                  allowRangeSelection={false}
                  minDate={new Date(1947, 11, 31)}
                  maxDate={new Date()}
                  todayBackgroundColor="#f2e6ff"
                  selectedDayColor="#7300e6"
                  selectedDayTextColor="#FFFFFF"
                  scrollable={true}
                  onDateChange={(STATE_DATE, END_DATE) => {
                    var str = `${STATE_DATE.toObject().years}-${
                      STATE_DATE.toObject().months + 1
                    }-${STATE_DATE.toObject().date}`;
                    this.setDateOfBirth(str);
                  }}
                />
              </View>
            </RBSheet>
            <RBSheet
              ref={(ref) => {
                this.universitySheet = ref;
              }}>
              <FlatList
                data={this.state.universities}
                renderItem={({item}) => {
                  return (
                    <TouchableOpacity
                      style={{
                        height: 50,
                        justifyContent: 'center',
                        alignItems: 'center',
                        borderBottomWidth: 1,
                        borderColor: '#D3D3D3',
                        backgroundColor: '#F2F2F2',
                      }}
                      onPress={() => {
                        this.setState({selectedUniversity: item.name});
                        this.setState({selectedUniversityId: item.id});
                        this.universitySheet.close();
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
                this.collegeSheet = ref;
              }}>
              <FlatList
                data={this.state.colleges}
                renderItem={({item}) => {
                  return (
                    <TouchableOpacity
                      style={{
                        height: 50,
                        justifyContent: 'center',
                        alignItems: 'center',
                        borderBottomWidth: 1,
                        borderColor: '#D3D3D3',
                        backgroundColor: '#F2F2F2',
                      }}
                      onPress={() => {
                        this.setState({selectedCollege: item.college});
                        this.setState({selectedCollegeId: item.id});
                        this.collegeSheet.close();
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
                          {item.college}
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
                        backgroundColor: '#F2F2F2',
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
                        backgroundColor: '#F2F2F2',
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
                        backgroundColor: '#F2F2F2',
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
          </KeyboardAwareScrollView>
        </View>
        {this.state.isLoading ? <Loader loading={this.state.loading} /> : null}
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
    fontFamily: "DMSans-Regular", 
    fontWeight: "700",
    color: '#2C2948',
  },
  dontHaveSignUpTextStyle: {
    textAlignVertical: 'center',
    fontSize: 15,
    fontWeight: '700',
    fontFamily: "DMSans-Regular", 
    color: '#F78A3A',
  },
  container2: {},
  headerContainer: {
    marginTop: 16,
  },
  headerText: {
    color: 'black',
    fontSize: 15,
    fontWeight: '400',
    fontStyle: 'normal',
  },
  tabItemContainer: {
    backgroundColor: '#cf6bab',
  },
});
