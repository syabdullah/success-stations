// React Navigate Drawer with Bottom Tab
// https://aboutreact.com/bottom-tab-view-inside-navigation-drawer/

import  React, {useState} from 'react';
import {
 
  View,
  Text,
  SafeAreaView,
  TouchableOpacity,
  Image,
  StyleSheet,
  Dimensions,
  FlatList,
} from 'react-native';
import WebView from 'react-native-webview'

import {Card, Paragraph} from 'react-native-paper';
import { TabView, SceneMap,TabBar } from 'react-native-tab-view';
import ApiService from '../../../../network/ApiService';
import Loader from '../../../Loader';
import {translate} from '../../../../util/TranslationUtils';
import AsyncStorage from '@react-native-community/async-storage'
import BookDetailView from '../../../../../components/BookDetailView';

const UserCardHeader = ({profile,clickEvent, userData, friendShip,...props}) => {

  let imageURL = profile.image != null && profile.image.url != null ? profile.image.url: "https://storage.googleapis.com/stateless-campfire-pictures/2019/05/e4629f8e-defaultuserimage-15579880664l8pc.jpg"
  var friendshipStatus = friendShip != null && friendShip.status != null ? friendShip.status: ""
  var roleId = profile.roles != null && profile.roles.length > 0 ? profile.roles[0].id: 2
  return (
    <Card style={{margin: 14, elevation: 10}}>
        <View style={{flexDirection: 'column', justifyContent: 'center'}}>
          <Image
            style={[
              { alignSelf: 'center', marginTop: 5},
              styles.image,
              
            ]}
            source={{uri: imageURL}}
          />
          <Text
            style={{
              color: '#151522',
              fontSize: 20,
              alignSelf: 'center',
              marginTop: 25,
              fontWeight: '700',
              fontFamily: "DMSans-Regular",
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
              marginTop: 12,
              marginBottom: 12,
            }}>
          
            <TouchableOpacity 
              style={{height:50, 
                      width:'45%',
                      backgroundColor: friendshipStatus == "new" ? '#ffffff': "#ffffff",
                      borderRadius:5,
                      justifyContent:'center',
                      borderColor:'#0A878A',
                      borderWidth:1}}
                      onPress = {()=> {
              
                        AsyncStorage.getItem('userdata').then((value)=> {
                          if(!value || 0 != value.length){ 
                            let user_id = JSON.parse(value).user_id;
                            if (friendshipStatus == "accepted") {
                              clickEvent(props.route.params.Friendship.requister_id, props.route.params.Friendship.user_requisted_id, friendshipStatus)
                            } else {
                              clickEvent(profile.id, user_id, friendshipStatus)
                            }
                          }
                        })  
                      }
                      }
                      disabled={friendshipStatus == "new" ? true: false}
            >
            <Text style={{color:'#151522',fontSize:17,textAlign:'center',fontWeight:'bold'}}>
            {friendshipStatus == "new" ? translate("request_pending"): friendshipStatus == "accepted"  
                ? roleId == 4 ? translate("Unfollow"): translate('remove_friend')
                : roleId == 4 ? translate("follow") : translate('add_friend')}
            </Text>
            </TouchableOpacity>
            </View>
        </View>
      </Card>

  
  );

};

const CONTACT = ({data}) => {
  
   var user = data
   var city = user.city.city != null ? user.city.city+", ": ""
   var country = user.country.name != null ? user.country.name: ""
   var fullAddress = `${city+country}`
  return (
    <View style={{flex: 1, background: 'white', margin: 16}}>
      <View style={{width: '100%'}}>
        <Text style={{fontSize: 14, lineHeight: 19, fontWeight: '400', color: '#9EA6BE', fontFamily: "DMSans-Regular"}}>
        {translate('name')}
        </Text>
        <Text style={{fontSize: 15, lineHeight: 19,fontWeight: 'bold', color: '#2C2948', fontFamily: "DMSans-Regular"}}>
            {user.name != null ? user.name : "N/A"}
        </Text>
      </View>
      <View style={{width: '100%',marginTop: 10}}>
        <Text style={{fontSize: 14, lineHeight: 19, fontWeight: '400', color: '#9EA6BE', fontFamily: "DMSans-Regular"}}>
        {translate('email')}
        </Text>
        <Text style={{fontSize: 15, lineHeight: 19,fontWeight: 'bold', color: '#2C2948', fontFamily: "DMSans-Regular"}}>
            {user.email != null ? user.email : "N/A"}
        </Text>
      </View>
      <View style={{width: '100%',marginTop: 10}}>
        <Text style={{fontSize: 14, lineHeight: 19, fontWeight: '400', color: '#9EA6BE', fontFamily: "DMSans-Regular"}}>
        {translate('mobile')}
        </Text>
        <Text style={{fontSize: 15, lineHeight: 19,fontWeight: 'bold', color: '#2C2948', fontFamily: "DMSans-Regular"}}>
            {user.mobile != null? user.mobile: "N/A"}
        </Text>
      </View>
      <View style={{width: '100%',marginTop: 10}}>
        <Text style={{fontSize: 14, lineHeight: 19, fontWeight: '400', color: '#9EA6BE', fontFamily: "DMSans-Regular"}}>
        {translate('address')}
        </Text>
        <Text style={{fontSize: 15, lineHeight: 19,fontWeight: 'bold', color: '#2C2948', fontFamily: "DMSans-Regular"}}>
            {fullAddress}
        </Text>
      </View>
    </View>
  );
}
   
  const ADS = ({data}) => {

    var adsData = data.route.params.ads
   return <View style={{flex:1,margin:16}} >
    <FlatList
      keyExtractor={(item) => item.id}
      data={adsData}
      numColumns={2}
      renderItem={({item}) => (
        <BookDetailView book={item} props = {data} isBookDetail={true}  />
      )}
    />
    </View>
  
  }
  const STUDY = ({data}) => {
    var user = data
    return (
      <View style={{flex: 1, background: 'white', margin: 16}}>
      <View style={{width: '100%'}}>
        <Text style={{fontSize: 14, lineHeight: 19, fontWeight: '400', color: '#9EA6BE', fontFamily: "DMSans-Regular"}}>
          {translate('college')}
        </Text>
        <Text style={{fontSize: 15, lineHeight: 19,fontWeight: 'bold', color: '#2C2948', fontFamily: "DMSans-Regular"}}>
            {user.college != null && user.college.region != null ? user.college.region: "N/A"}
        </Text>
      </View>
      <View style={{width: '100%',marginTop: 10}}>
        <Text style={{fontSize: 14, lineHeight: 19, fontWeight: '400', color: '#9EA6BE', fontFamily: "DMSans-Regular"}}>
        {translate('university')}
        </Text>
        <Text style={{fontSize: 15, lineHeight: 19,fontWeight: 'bold', color: '#2C2948', fontFamily: "DMSans-Regular"}}>
            {user.university != null && user.university.name != null? user.university.name: "N/A"}
        </Text>
      </View>
      {user.iqama_number != null ?(
      <View style={{width: '100%',marginTop: 10}}>
        <Text style={{fontSize: 14, lineHeight: 19, fontWeight: '400', color: '#9EA6BE', fontFamily: "DMSans-Regular"}}>
          {translate('Iqama_number')}
        </Text>
        <Text style={{fontSize: 15, lineHeight: 19,fontWeight: 'bold', color: '#2C2948', fontFamily: "DMSans-Regular"}}>
            {user.iqama_number}
        </Text>
      </View>
      ): null}
    </View>
  )
}
   
const ABOUT = ({data}) => (
<View style={{flex:1,margin:16}} >
    <Text style={{fontSize:15 ,lineHeight:19}}> {data}</Text>
  </View>
);

const initialLayout = { width: Dimensions.get('window').width };
export default class ProfileDetails extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      userData: props.route.params.user,
      ads: props.route.params.ads,
      study: props.route.params.user,
      friendship: props.route.params.Friendship,
      index: 0,
      routes: [
        { key: 'contact', title: 'CONTACT'  },
        { key: 'ads', title: 'ADS'},
        { key: 'study', title: 'STUDY' },
      ],
      isLoading: false
    };
    
  }

  getProfileDetails() {
      ApiService.get(`user-profile?user_id=${this.state.profile.id}`)
      .then((response) => {
        let userData = response.data
        this.setState({profile: userData});
        ApiService.get(`listings?user_id=${this.state.profile.id}`)
        .then((response) => {
          this.setState({isLoading: false});
        })
        .catch((error) => {
          this.setState({isLoading: false});
        });
        
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data.message);
      });
    }

    sendFriendRequest(friendId, myId) {
      this.setState({isLoading: true})
      ApiService.post('friendship-request',{
        "requister_id": `${myId}`,
        "user_requisted_id": `${friendId}`,
        "status": "new"
      })
      .then((response) => {
        this.setState({friendship: response.data, isLoading: false});
        if (this.props.route.params.callBack !== undefined) {
          this.props.route.params.callBack()
        }
      })
      .catch((error) => {
        alert(error.data.message);
        this.setState({isLoading: false});
      });
    }

    removeFriendRequest(requisterId, userRequistedId) {
      this.setState({isLoading: true})
      ApiService.post('remove-friend',{
        "requister_id": `${requisterId}`,
        "user_requisted_id": `${userRequistedId}`
      })
      .then((response) => {
        this.getFriendList()
        this.setState({isLoading: false})
      })
      .catch((error) => {
        alert(error.data.message);
        this.setState({isLoading: false});
      });
    }

  _handleIndexChange = index => this.setState({ index });
     renderTabBar = props => (
   
      <TabBar
        {...props}
        
        renderLabel={({ route, focused, color }) => (
          <Text style={{ color:'black', margin: 8, fontFamily: "DMSans-Regular", fontSize: 15}}>
            {route.title}
          </Text>
        )}
  
      
        indicatorStyle={{ backgroundColor: '#F78A3A'}}
        style={{ backgroundColor: 'white' }}
      />
    );
    renderScene = ({ route }) => {
      switch (route.key) {
        case 'contact':
          return <CONTACT data={this.props.route.params.user}  />;
        case 'ads':
          return <ADS data={this.props} />;
          case 'study':
          return <STUDY data={this.props.route.params.user}  />;
        case 'about':
          return <ABOUT data={this.props.route.params.user.about}/>;
        default:
          return null;
      }
    };

  render() {
    const data = this.props.route.params.user
    return (
      <SafeAreaView style={{flex: 1,flexDirection:'column'}}>
           <View style={[styles.parent, {position: 'absolute'}]} />
           <View style={{flex:1}}>
              <UserCardHeader 
                  profile = {data} {...this.props} 
                  clickEvent={(friendId, myId, status) => {
                              if (status == "accepted") {
                                this.removeFriendRequest(friendId, myId)
                              } else {
                                this.sendFriendRequest(friendId, myId)  
                              }
                            }}
                  userData = {this.state.userData}
                  friendShip = {this.state.friendship}
              />
              <TabView 
              navigationState={this.state}
              renderScene={this.renderScene}
              renderTabBar={this.renderTabBar}
              onIndexChange={this._handleIndexChange}
              />
          </View>
      {this.state.isLoading ? <Loader loading={this.state.loading} /> : null}
      </SafeAreaView>
    );
  }

  getProfileDetail = () => {
    this.setState({isLoading: true});
    ApiService.get(`user-profile?user_id=${this.props.route.params.user.user_id}`)
      .then((response) => {
        this.setState({isLoading: false, userData: response.data});
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data.message);
      });
  };

  componentDidMount() {
    this.getProfileDetail();
  }

  componentWillUnmount() {

  }
}



const styles = StyleSheet.create({
  image: {
    width: 60,
    height: 60,
    borderRadius: 60 / 2,
    overflow: 'hidden',
  },
  parent: {
    height: 200,
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
  },
  countTextStye: {
    color: '#151522',
    fontSize: 17,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  titleCountTextStye: {
    color: '#666666',
    fontSize: 13,
    textAlign: 'center',
  },
  cardImageItem: {
    width: 'auto',
    height: 'auto',
    aspectRatio: 16 / 9,
  },
});
