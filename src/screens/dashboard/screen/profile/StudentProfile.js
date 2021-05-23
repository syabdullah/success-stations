// React Navigate Drawer with Bottom Tab
// https://aboutreact.com/bottom-tab-view-inside-navigation-drawer/

import * as React from 'react';
import {
 
  View,
  Text,
  SafeAreaView,
  TouchableOpacity,
  Image,
  StyleSheet,

  FlatList,
} from 'react-native';

import {Card, Paragraph} from 'react-native-paper';
import {cardFollower, cardLocation} from './../../../../util/ImageConstant';
import ApiService from '../../../../network/ApiService';
import Loader from '../../../Loader';
import AsyncStorage from '@react-native-community/async-storage'
import {translate} from '../../../../util/TranslationUtils';

const UserCardHeader = ({profile,data,...props}) => { 

  let image = profile.image != null && profile.image.url != null ? profile.image.url :""
  return (
    <View style={{flex: 1}}>
      <View style={[styles.parent, {position: 'absolute'}]} />

      <Card style={{margin: 14, elevation: 10}}>
        <View style={{flexDirection: 'column', justifyContent: 'center'}}>
        <TouchableOpacity onPress={() => {
              props.navigation.navigate('EditProfile',{data:data});

            }}>
          <Image
            source={require('./../../../../../assets/drawer/edit.png')}
            style={{
              tintColor: '#F78A3A',
              width: 15,
              height: 15,
              alignSelf: 'flex-end',
              marginEnd: 25,
              marginTop: 15,
            }}
          />
          </TouchableOpacity>
          <Image
            style={[
              { alignSelf: 'center', marginTop: 5},
              styles.image,
            ]}
            source={{uri: image}}
          />
          <Text
            style={{
              color: '#151522',
              fontSize: 20,
              alignSelf: 'center',
              marginTop: 25,
              fontWeight: 'bold',
              fontFamily: "DMSans-Regular"
            }}>
            {profile.name}
          </Text>
          <Card.Content>
            <Paragraph
              style={{
                fontSize: 13,
                color: '#666666',
                lineHeight: 18,
                textAlign: 'center',
                fontFamily: "DMSans-Regular"
              }}>
              {profile.profileMsg}
            </Paragraph>
          </Card.Content>
          <View
            style={{
              marginTop: 20,
              height: 1,
              marginEnd: 28,
              marginStart: 28,
              borderBottomColor: '#E2E2E2',
              borderBottomWidth: 1,
            }}
          />
          <View
            style={{
              flexDirection: 'row',
              justifyContent: 'center',
              justifyContent: 'space-evenly',
              marginTop: 10,
              marginBottom: 24,
            }}>
            <View style={{flexDirection: 'column', justifyContent: 'center'}}>
              <Text style={styles.countTextStye}>{profile.ads}</Text>
              <Text style={styles.titleCountTextStye}>Ads</Text>
            </View>
            <View style={{flexDirection: 'column', justifyContent: 'center'}}>
              <Text style={styles.countTextStye}>{profile.follower}</Text>
              <Text style={styles.titleCountTextStye}>Follower</Text>
            </View>
            <View style={{flexDirection: 'column', justifyContent: 'center'}}>
              <Text style={styles.countTextStye}>{profile.following}</Text>
              <Text style={styles.titleCountTextStye}>Following</Text>
            </View>
          </View>
        </View>
      </Card>

      <Text style={{fontSize:15,marginStart:14,marginTop:28}}>{translate('my_ads')}</Text>
    </View>
  );

};

const CardItem = (item) => {
  let image = item.image != null && item.image.length > 0 ? item.image[0].url: "";
  var city = item.city.city != null ? item.city.city+", ": ""
  var country = item.country.name != null ? item.country.name: ""
  var fullAddress = `${city+country}`
  var header_View = (
    <View style={{flex: 1}}>
      <Card style={{margin: 7, elevation: 10}}>
        <View style={{flexDirection: 'column', justifyContent: 'center'}}>
          <Image
            style={styles.cardImageItem}
            source={{uri : image}}          />
          <View style={{flexDirection: 'column', marginStart: 10}}>
            <Text
              style={{
                fontSize: 15,
                color: 'rgba(0, 0, 0, 1)',
                lineHeight: 20,
                fontFamily: "DMSans-Regular"
              }}>
              {item.title}
            </Text>

            <Text style={{color: '#0A878A', fontSize: 15, marginTop: 11, fontFamily: "DMSans-Regular"}}>
              SR {item.price}
            </Text>
            <View
              style={{
                flexDirection: 'column',
                justifyContent: 'center',
                justifyContent: 'space-evenly',
                marginTop: 12,
                marginBottom: 11,
              }}>
              <View style={{flexDirection: 'row'}}>
                <Image style={{width: 11, height: 12}} source={cardLocation} />
                <Text style={{fontSize: 10, color: 'rgba(0, 0, 0, 0.6)',marginStart:5, fontFamily: "DMSans-Regular"}}>
                  {fullAddress}
                </Text>
              </View>
              <View style={{flexDirection: 'row'}}>
                <Image style={{width: 11, height: 12}} source={cardFollower} />
                <Text style={{fontSize: 10, color: 'rgba(0, 0, 0, 0.6)' ,marginStart:5, fontFamily: "DMSans-Regular"}}>
                  {item.contact_name}
                </Text>
              </View>
            </View>
          </View>
        </View>
      </Card>
    </View>
  );

  return header_View;
};
export default class StudentProfile extends React.Component {
  
  getMyData() {

    this.setState({isLoading: true});
    AsyncStorage.getItem('userdata').then((value)=> {
      if(!value || 0 != value.length){ 
        this.setState({data:JSON.parse(value)})
        let user_id = JSON.parse(value).user_id;
        this.getMyProfileData(user_id)
      }
    })
  }

  getMyAds(userId) {

    ApiService.get(`listings?user_id=${userId}`)
    .then((response) => {
      this.setState({FlatListItems: response.data});
      this.setState({isLoading: false});
    })
    .catch((error) => {
      this.setState({isLoading: false});
    });
  }

  getMyProfileData(userId) {

    ApiService.get(`user-profile?user_id=${userId}`)
    .then((response) => {
      this.setState({profileData: response.data});
      this.getMyAds(userId)
    })
    .catch((error) => {
      this.setState({isLoading: false});
      alert(error.data.message);
    });
  }

  constructor(props) {
    super(props);
    this.state = { isLoading :false, FlatListItems: [], profileData: {},data:{}}
  }

  componentDidMount() {
    this.getMyData()
  }

  componentWillUnmount() {

  }

  render() {
    return (
      <SafeAreaView style={{flex: 1}}>
        <FlatList
          style={{}}
          data={this.state.FlatListItems}
          renderItem={({item}) => CardItem(item)}
          numColumns={2}
          ListHeaderComponent={<UserCardHeader profile = {this.state.profileData} data = {this.state.data} {...this.props}/>}
        />
        {this.state.isLoading ? (
            <Loader loading={this.state.loading} />
          ) : null}
      </SafeAreaView>
    );
  }
}

const styles = StyleSheet.create({
  image: {
    width: 100,
    height: 100,
    borderRadius: 100 / 2,
    overflow: 'hidden',
  },
  parent: {
    height: '65%',
    width: '100%',
    transform: [{scaleX: 2}],
    borderBottomStartRadius: 200,
    borderBottomEndRadius: 200,
    overflow: 'hidden',
    backgroundColor: '#0A878A',
  },
  child: {
    flex: 1,
    transform: [{scaleX: 0.5}],

    backgroundColor: '#0A878A',
    alignItems: 'center',
    justifyContent: 'center',
  },
  MainContainer: {
    justifyContent: 'center',
    flex: 1,
    paddingTop: Platform.OS === 'iOS' ? 20 : 0,
  },

  FlatList_Item: {
    padding: 10,
    fontSize: 18,
    height: 44,
  },

  header_footer_style: {
    width: '100%',
    height: 44,
    backgroundColor: '#4CAF50',
    alignItems: 'center',
    justifyContent: 'center',
  },

  textStyle: {
    textAlign: 'center',
    color: '#fff',
    fontSize: 21,
    fontFamily: "DMSans-Regular"
  },
  countTextStye: {
    color: '#151522',
    fontSize: 17,
    fontWeight: 'bold',
    textAlign: 'center',
    fontFamily: "DMSans-Regular"
  },
  titleCountTextStye: {
    color: '#666666',
    fontSize: 13,
    textAlign: 'center',
    fontFamily: "DMSans-Regular"
  },
  cardImageItem: {
    width: 'auto',
    height: 'auto',
    aspectRatio: 16 / 9,
  },
});
