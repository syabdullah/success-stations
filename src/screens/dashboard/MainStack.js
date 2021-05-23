// React Navigate Drawer with Bottom Tab
// https://aboutreact.com/bottom-tab-view-inside-navigation-drawer/

import 'react-native-gesture-handler';

import * as React from 'react';
import {
  View,
  TouchableOpacity,
  Image,
  StatusBar,
  StyleSheet,
  Text,
  useFocusEffect,
} from 'react-native';

import {createStackNavigator} from '@react-navigation/stack';

import {createBottomTabNavigator} from '@react-navigation/bottom-tabs';
import Offers from './screen/Offers';
import Friends from './screen/Friends';
import Services from './screen/Services';
import AdsScreen from './screen/Ads';

import AdDetail from './screen/AdDetail';
import EnterPublisherDetail from './screen/EnterPublisherDetail';

import StudentProfile from './screen/profile/StudentProfile';
import ServiceDetails from './screen/service/ServiceDetails';
import ProfileDetail from './screen/profileDetails/ProfileDetails';
import Category from './screen/Category';
import Membership from './screen/membership/Membership';
import EditProfile from './../Edit-Profile/EditProfileScreen';
import FriendRequest from '../../screens/dashboard/screen/FriendRequest';
import BookDetailScreen from './screen/book/BookDetailScreen';
import { connect } from 'react-redux';
import {bindActionCreators} from 'redux';

import * as Action from '../../redux/ReduxAction';

import {
  adsTabIcon,
  offerTabIcon,
  serviceTabIcon,
  friendTabIcon,
} from './../../util/ImageConstant';
import {translate} from '../../util/TranslationUtils';
import MyAdsListScreen from './screen/MyAdsList';
import AddAds from './screen/AddAds';
import MyLocationScreen from './screen/MyLocation';
import SelectMyLocation from './screen/SelectMyLocation';
import AsyncStorage from '@react-native-community/async-storage';
import ApiService from '../../network/ApiService';
import CMSScreen from './screen/CMSScreen';

const NavigationRight = (props) => {

  return (
    <View style={{flexDirection: 'row', justifyContent: 'center'}}>
      <Image
        source={{uri: props.url}}
        style={{width: 36, height: 36, borderRadius: 16, margin: 16}}
      />
    </View>
  );
};

const NavigationDrawerStructure = (props) => {
  //Structure for the navigatin Drawer
  const toggleDrawer = () => {
    //Props to open/close the drawer
    props.navigationProps.toggleDrawer();
  };

  return (
    <View style={{flexDirection: 'row', justifyContent: 'flex-end', flex: 1}}>
      <StatusBar
        barStyle="dark-content"
        hidden={false}
        backgroundColor="#0A878A"
        translucent={true}
      />
      <View style={{flexDirection: 'row', width: '100%'}}>
        <TouchableOpacity
          onPress={() => toggleDrawer()}
          style={{alignSelf: 'center'}}>
          {/*Donute Button Image */}
          <Image
            source={require('../../../assets/tabs/menu.png')}
            style={{width: 25, height: 25, marginLeft: 10, alignSelf: 'center'}}
          />
        </TouchableOpacity>

        { (props.location!=null &&props.location.length != 0) ? (
          <Image
            source={require('../../../assets/card/location.png')}
            style={{
              width: 14,
              height: 14,
              marginLeft: 5,
              alignSelf: 'center',
              tintColor: 'white',
              
            }}
          />
        ) : null}

        <Text style={{color: 'white', marginLeft: 5, alignSelf: 'center', fontFamily: "DMSans-Bold"}}>
          {props.location}
        </Text>
      </View>
    </View>
  );
};

const BottomTabStack = () => {
  return (
    <Tab.Navigator
      initialRouteName="Offers"
      tabBarOptions={{
        activeTintColor: '#000000',
        inactiveTintColor: '#9EA6BE',

        style: {
          backgroundColor: '#ffffff',
        },
        labelStyle: {
          textAlign: 'center',
          fontSize: 16,
        },
      }}>
      <Tab.Screen
        name="Offers"
        component={Offers}
        options={{
          tabBarLabel: `${translate('offer')}`,
          tabBarIcon: ({color, focused}) => (
            <TabIcon src={offerTabIcon} focused={focused} />
          ),
        }}
      />
      <Tab.Screen
        name="Friends"
        component={Friends}
        options={{
          tabBarLabel: `${translate('friends')}`,
          tabBarIcon: ({color, focused}) => (
            <TabIcon src={friendTabIcon} focused={focused} />
          ),
        }}
      />
      <Tab.Screen
        name="Services"
        component={Services}
        options={{
          tabBarLabel: `${translate('services')}`,
          tabBarIcon: ({color, focused}) => (
            <TabIcon src={serviceTabIcon} focused={focused} />
          ),
        }}
      />
      <Tab.Screen
        name="Ads"
        component={AdScreenStack}
        options={{
          tabBarLabel: `${translate('ads')}`,
          tabBarIcon: ({color, focused}) => (
            <TabIcon src={adsTabIcon} focused={focused} />
          ),
          headerShown: false,
        }}
      />
    </Tab.Navigator>
  );
};
export const AdScreenStack = ({navigation}) => {
  return (
    <Stack.Navigator
      initialRouteName="AdsScreen"
      screenOptions={{
        headerStyle: null,
        headerTintColor: '#fff', //Set Header text color
        headerTitleStyle: null,
        headerShown: false,
      }}>
      <Stack.Screen
        name="AdsScreen"
        component={AdsScreen}
        options={{
          headerShown: false,
        }}
      />
      <Stack.Screen
        name="EnterPublisherDetail"
        component={EnterPublisherDetail}
        options={{
          headerShown: false,
        }}
      />
      <Stack.Screen
        name="AdDetail"
        component={AdDetail}
        options={{
          headerShown: false,
        }}
      />
    </Stack.Navigator>
  );
};

const Stack = createStackNavigator();
const Tab = createBottomTabNavigator();

class MainScreenStack extends React.Component {
  static navigationOptions = ({navigation, navigationOptions}) => {
    return {
      header: null,
    };
  };

  constructor(props) {
    super(props);
    this.state = {
      userdata: {},
      url:
        'https://storage.googleapis.com/stateless-campfire-pictures/2019/05/e4629f8e-defaultuserimage-15579880664l8pc.jpg',
      
      isLoading: false,
    };
  }

  

  
  render() {

    return (
      <Stack.Navigator>
        <Stack.Screen
          name=" "
          component={BottomTabStack}
          options={({route}) => ({
            headerLeft: () => (
              <NavigationDrawerStructure
                navigationProps={this.props.navigation}
                location={this.props.state.address}
              />
            ),
            headerRight: () => (
            
              <NavigationRight
                navigationProps={this.props.navigation}
                url={this.props.state.url}
              />
            ),
            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
              elevation: 0,
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          })}
        />
        <Stack.Screen
          name="StudentProfile"
          component={StudentProfile}
          options={{
            title: 'Profile', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />
        <Stack.Screen
          name="EditProfile"
          component={EditProfile}
          options={{
            title: 'Edit Profile', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />
        <Stack.Screen
          name="Membership"
          component={Membership}
          options={{
            title: 'Membership', //Set Header Title
            headerShown: true,
            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />
        <Stack.Screen
          name="ProfileDetail"
          component={ProfileDetail}
          options={{
            title: 'Profile', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />

        <Stack.Screen
          name="ServiceDetails"
          component={ServiceDetails}
          options={{
            title: 'Profile', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />

        <Stack.Screen
          name="MyAdsList"
          component={MyAdsListScreen}
          options={{
            title: 'My Ads', //Set Header Title
            headerRight: () => (
              <TouchableOpacity
                style={{marginRight: 10}}
                onPress={() => this.props.navigation.navigate('AddAds')}>
                <Image
                  source={require('./../../../assets/plus.png')}
                  style={{width: 35, height: 35, tintColor: 'white'}}
                />
              </TouchableOpacity>
            ),
            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />

<Stack.Screen
          name="CMSScreen"
          component={CMSScreen}
          options={{
            title: '', //Set Header Title
            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />
        
        <Stack.Screen
          name="AddAds"
          component={AddAds}
          options={{
            title: 'Add Ads', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />
        <Stack.Screen
          name="EnterPublisherDetail"
          component={EnterPublisherDetail}
          options={{
            title: 'Add Ads', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />
        <Stack.Screen
          name="AdDetail"
          component={AdDetail}
          options={{
            title: 'Add Ads', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />

        <Stack.Screen
          name="MyLocation"
          component={MyLocationScreen}
          options={{
            title: 'My Location', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />

        <Stack.Screen
          name="FriendRequest"
          component={FriendRequest}
          options={{
            title: 'Friend Request', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />

        <Stack.Screen
          name="SelectMyLocation"
          component={SelectMyLocation}
          options={{
            title: 'Select Location', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />

        <Stack.Screen
          name="Category"
          component={Category}
          options={{
            title: '', //Set Header Title

            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />
        <Stack.Screen
          name="BookDetailScreen"
          component={BookDetailScreen}
          options={{
            title: '', //Set Header Title
            headerShown: false,
            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />

        <Stack.Screen
          name="ServiceProfileScreen"
          component={ServiceDetails}
          options={{
            title: '', //Set Header Title
            headerShown: false,
            headerStyle: {
              backgroundColor: '#0A878A', //Set Header color
            },
            headerTintColor: '#fff', //Set Header text color
            headerTitleStyle: {
              fontWeight: 'bold', //Set Header text style
            },
          }}
        />
      </Stack.Navigator>
    );
  }
}

  
  
  export default connect((state) => (
  {
    state: state.updateProfile,
  }),(dispatch) => ({
    actions: bindActionCreators(Action, dispatch)
  }))(MainScreenStack);
const TabIcon = ({src, focused}) => {
  return (
    <Image
      source={src}
      style={{
        width: 28,
        height: 18,
        tintColor: focused ? '#FFA733' : '#9EA6BE',
        resizeMode: 'contain',
      }}
    />
  );
};
