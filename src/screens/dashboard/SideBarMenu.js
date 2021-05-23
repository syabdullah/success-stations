import React from 'react';
import {
  SafeAreaView,
  View,
  StyleSheet,
  Image,
  Text,
  TouchableOpacity,
  Linking,
} from 'react-native';
import AsyncStorage from '@react-native-community/async-storage';
import {DrawerContentScrollView, DrawerItem} from '@react-navigation/drawer';
import {
  adsIcon,
  userAgreementIcon,
  profileIcon,
  privacyIcon,
  contactIcon,
  notificationIcon,
  messageIcon,
  membershipIcon,
  cardLocation,
} from './../../util/ImageConstant';
import {drawerIconStyle} from './../../styles/CommonStyleSheet';
import {translate} from './../../util/TranslationUtils';

const DrawerProfile = ({data,url, ...props}) => {

  return (
    <View style={{flexDirection: 'column', height: 142, marginTop: 24}}>
  
      <TouchableOpacity
        style={{
          width: 20,
          height: 20,
          alignSelf: 'flex-end',
          marginEnd: 25,
          marginTop: 20,
        }}
        onPress={() => {
          props.navigation.navigate('EditProfile',{data:data});
        }}>
        <Image
          source={require('./../../../assets/drawer/edit.png')}
          style={{width: 15, height: 15}}
        />
      </TouchableOpacity>

      <View style={{flexDirection: 'row', marginTop: 20, marginStart: 20}}>
        <Image source={{uri: url}} style={styles.image} />
        <View
          style={{
            flexDirection: 'column',
            marginStart: 20,
            justifyContent: 'center',
          }}>
          
          <Text style={styles.name} ellipsizeMode='tail' numberOfLines={1}>{data!=null ?data.name :""}</Text>
          <Text style={styles.email} ellipsizeMode='tail' numberOfLines={1}>{data!=null ?data.email:""}</Text>
        </View>
      </View>

      <View
        style={{
          marginTop: 16,
          height: 1,
          borderBottomColor: '#E2E2E2',
          borderBottomWidth: 1,
        }}
      />
    </View>
  );
};

const LinkMenuItem = ({title, src, link}) => {
  return (
    <TouchableOpacity
      style={styles.customItem}
      onPress={() => {
        Linking.openURL(link);
      }}>
      <View style={drawerIconStyle.menuIconBg}>
        <Image source={src} style={drawerIconStyle.menuIcon} />
      </View>
      <Text style={{marginStart: 35, color: '#9EA6BE'}}>{title}</Text>
    </TouchableOpacity>
  );
};

 
const SidebarMenu = ({props,data,logout,icon}) => {

  return (
    <View style={{flex: 1}}>
      {/*Top Large Image */}

      <DrawerProfile data={data} url={icon} {...props} />
      <DrawerContentScrollView {...props}>
        <DrawerItem
          icon={({color, size}) => <DrawerIcon src={profileIcon} />}
          label={translate('profile')}
          onPress={() => {
            props.navigation.navigate('StudentProfile');
          }}
          labelStyle={styles.drawerLabelStyle}
        />
        <DrawerItem
          icon={({color, size}) => <DrawerIcon src={adsIcon} />}
          label={translate('my_ads')}
          onPress={() => {
            props.navigation.navigate('MyAdsList');
          }}
          labelStyle={styles.drawerLabelStyle}
        />
        {(data!=null && data.user_type == 4) ?
        <DrawerItem 
          icon={({color, size}) => <DrawerIcon src={cardLocation} />}
          label={translate('my_location')}
          onPress={() => {
            props.navigation.navigate('MyLocation');
          }}
          labelStyle={styles.drawerLabelStyle}
        />: null}

        <DrawerItem 
          icon={({color, size}) => <DrawerIcon src={cardLocation} />}
          label={translate('friend_requests')}
          onPress={() => {
            props.navigation.navigate('FriendRequest');
          }}
          labelStyle={styles.drawerLabelStyle} 
        />
        {/*
        <DrawerItem
          icon={({color, size}) => <DrawerIcon src={messageIcon} />}
          label={translate('messeges')}
          onPress={() => {
            props.navigation.navigate('Messages');
          }}
          labelStyle={styles.drawerLabelStyle}
        />
        */}
        <DrawerItem
          icon={({color, size}) => <DrawerIcon src={membershipIcon} />}
          label={translate('membership')}
          onPress={() => {
            props.navigation.navigate('Membership');
          }}
          labelStyle={styles.drawerLabelStyle}
        />
        {/*
        <DrawerItem
          icon={({color, size}) => <DrawerIcon src={notificationIcon} />}
          label={translate('notification')}
          onPress={() => {
            props.navigation.navigate('SupportScreen');
          }}
          labelStyle={styles.drawerLabelStyle}
        />
        */}

        <View
          style={{
            marginTop: 10,
            height: 1,
            borderBottomColor: '#E2E2E2',
            borderBottomWidth: 1,
          }}
        />
        <Text
          style={{
            marginTop: 10,
            marginStart: 25,
            color: '#181725',
            fontSize: 18,
            fontFamily: 'DMSans-Regular'
          }}>
          Success Station
        </Text>

        <DrawerItem
          icon={({color, size}) => <DrawerIcon src={profileIcon} />}
          label={translate('about_us')}
          onPress={() => {
            props.navigation.navigate('CMSScreen',{cms: 'about-us'});
          }}
          labelStyle={styles.drawerLabelStyle}
        />

<DrawerItem
          icon={({color, size}) => <DrawerIcon src={adsIcon} />}
          label={translate('advertise_with_us')}
          onPress={() => {
            props.navigation.navigate('CMSScreen',{cms: 'advertise'});
          }}
          labelStyle={styles.drawerLabelStyle}
        />

<DrawerItem
          icon={({color, size}) => <DrawerIcon src={privacyIcon} />}
          label={translate('privacy')}
          onPress={() => {
            props.navigation.navigate('CMSScreen',{cms: 'privacy'});
          }}
          labelStyle={styles.drawerLabelStyle}
        />

<DrawerItem
          icon={({color, size}) => <DrawerIcon src={userAgreementIcon} />}
          label={translate('user_agreement')}
          onPress={() => {
            props.navigation.navigate('CMSScreen',{cms: 'user-agreement'});
          }}
          labelStyle={styles.drawerLabelStyle}
        />

<DrawerItem
          icon={({color, size}) => <DrawerIcon src={contactIcon} />}
          label={translate('cntact_us')}
          onPress={() => {
            props.navigation.navigate('CMSScreen',{cms: 'contact-us'});
          }}
          labelStyle={styles.drawerLabelStyle}
        />

        
          <DrawerItem
          icon={({color, size}) => <DrawerIcon src={notificationIcon} />}
          label={translate('logout')}
          onPress={() => logout()}
          labelStyle={styles.drawerLabelStyle}
        />
      </DrawerContentScrollView>
    </View>
  );
};

const DrawerIcon = ({src}) => {
  return (
    <View style={drawerIconStyle.menuIconBg}>
      <Image source={src} style={drawerIconStyle.menuIcon} />
    </View>
  );
};

const styles = StyleSheet.create({
  sideMenuProfileIcon: {
    resizeMode: 'center',
    width: 100,
    height: 100,
    borderRadius: 100 / 2,
    alignSelf: 'center',
  },
  iconStyle: {
    width: 15,
    height: 15,
    marginHorizontal: 5,
  },
  customItem: {
    padding: 16,
    flexDirection: 'row',
    alignItems: 'center',
  },
  image: {
    width: 64,
    height: 64,
    borderRadius: 64 / 2,
    overflow: 'hidden',
  },
  name: {
    fontSize: 20,
    color: '#181725',
    width: 170,
    fontFamily: 'DMSans-Regular',
  },
  email: {
    fontSize: 16,
    color: '#7C7C7C',
    width: 170,
    fontFamily: 'DMSans-Regular',

  },

  drawerContent: {
    flex: 1,
  },
  userInfoSection: {
    paddingLeft: 20,
  },
  title: {
    fontSize: 16,
    marginTop: 3,
    fontWeight: 'bold',
  },
  caption: {
    fontSize: 14,
    lineHeight: 14,
  },
  row: {
    marginTop: 20,
    flexDirection: 'row',
    alignItems: 'center',
  },
  section: {
    flexDirection: 'row',
    alignItems: 'center',
    marginRight: 15,
  },
  paragraph: {
    fontWeight: 'bold',
    marginRight: 3,
  },
  drawerSection: {
    marginTop: 15,
  },
  bottomDrawerSection: {
    marginBottom: 15,
    borderTopColor: '#f4f4f4',
    borderTopWidth: 1,
  },
  preference: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: 12,
    paddingHorizontal: 16,
  },
  drawerLabelStyle: {
    fontFamily: 'DMSans-Regular',
    fontSize: 15,
  }
});

export default SidebarMenu;
