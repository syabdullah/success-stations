// React Navigate Drawer with Bottom Tab
// https://aboutreact.com/bottom-tab-view-inside-navigation-drawer/

import * as React from 'react';
import {Button, View, Text, SafeAreaView, FlatList, Image, StyleSheet, TouchableOpacity, TouchableWithoutFeedback} from 'react-native';
import { Searchbar ,DefaultTheme} from 'react-native-paper';
import {translate} from '../../../util/TranslationUtils';
import ApiService from '../../../network/ApiService';
import Loader from '../../Loader';
import AsyncStorage from '@react-native-community/async-storage'
import _ from 'lodash';

const UserProfile =({user, clickEvent, profileOpenEvent,...props}) => {
  var city = user.city.city != null ? user.city.city+", ": ""
  var region = user.region.region != null ? user.region.region+", ": ""
  var country = user.country.name != null ? user.country.name: ""
  var fullAddress = `${city+region+country}`
  var url = (user.image != null && user.image.preview != null) ? user.image.preview  :'https://storage.googleapis.com/stateless-campfire-pictures/2019/05/e4629f8e-defaultuserimage-15579880664l8pc.jpg'
  var friendshipStatus = user.Friendship != null && user.Friendship.status != null ? user.Friendship.status: ""
  var roleId = user.roles != null && user.roles.length > 0 ? user.roles[0].id: 2

  return (
   
    <View style={{ width:'47%',margin:'1.5%', borderColor: "#00000030", borderWidth: 1, borderRadius: 4}}>
     
        <View style={{width: 60, height: 60, borderRadius: 30, alignSelf: "center", marginTop: 21}}>
            <Image style={{width: 60, height: 60, borderRadius: 30}} 
                  source={{uri: url}}
            />
        </View>
        <View style={{height: 40, marginTop:7}}>
          <Text style={{fontSize: 15, fontWeight: "700", textAlign: "center", color: "#000000", fontFamily: "DMSans-Regular",}}>{user.name}</Text>
          <Text style={{fontSize: 15, fontWeight: "400", textAlign: "center", color: "#9EA6BE",marginTop:9, fontFamily: "DMSans-Regular", marginleft: 10, marginRight: 10}}>{user.email}</Text>
        </View>
        <View style={{width: "70%", alignSelf: "center",marginTop:15, justifyContent: "space-between", flexDirection: "row", height: 30}}>
          <Image style={{width: 24, height:24}}
              source={require('../../../../assets/friends/graduation-icon.png')}
          />
          <Text style={{fontSize: 11, fontWeight: "400",marginStart:4, color: "#9EA6BE" , fontFamily: "DMSans-Regular",}}>{fullAddress}</Text>
        </View>
        <View style={{width: "80%", alignSelf: "center", height: 35, marginBottom: 10,marginTop:13}}>
        <View style={friendshipStatus == "new" ? styles.mainView: styles.mainView}>
            <TouchableOpacity onPress = {()=> {
              
              AsyncStorage.getItem('userdata').then((value)=> {
                if(!value || 0 != value.length){ 
                  let user_id = JSON.parse(value).user_id;
                  if (user.Friendship.status == "accepted") {
                    clickEvent(user.Friendship.requister_id, user.Friendship.user_requisted_id, user.Friendship.status)
                  } else {
                    clickEvent(user.id, user_id, user.Friendship.status)
                  }
                  
                }
              })  
              
            }
            }
            disabled={friendshipStatus == "new" ? true: false}
            >
              <Text style={styles.buttonStyle}>
              { friendshipStatus == "new" ? translate("request_pending"):
              user.Friendship != null && user.Friendship.status == "accepted"  
                ? roleId == 4 ? translate("unfollow"): translate('remove_friend')
                : roleId == 4 ? translate("follow") : translate('add_friend')}
              </Text>
            </TouchableOpacity>
        </View>
        </View>
        <View style={{width: "80%", alignSelf: "center", height: 35, marginBottom: 10,marginTop:5}}>
        <View style={styles.mainView}>
            <TouchableOpacity onPress = {()=> 
      {
        profileOpenEvent()
        
      }}
           
            >
              <Text style={styles.buttonStyle}>
              {translate('view_profile')}
              </Text>
            </TouchableOpacity>
        </View>
        </View>
    
    </View>
  
  )
}


const theme = {
  ...DefaultTheme,
 
  colors: {
    ...DefaultTheme.colors,
    primary: '#0A878A',
    accent: 'black',
    secondary:'black'
  },
};

export default class FreindsScreen extends React.Component {

  static navigationOptions = {
    header: null,
    options: {
      
    }
  };

  constructor(props) {
    super(props);
    this.onChangeTextDelayed = _.debounce(this.onChangeText, 1000);
    this.state = { isLoading :false}
    this.friendList = []
  }

  onChangeText = (text) => {
    this.getFriendList(`?search=${text}`)
  }

  getFriendList = (searchData = '') => {
    this.setState({isLoading: true});
    var path = 'users'
    if (searchData != "") {
      path += searchData
    }
    ApiService.get(path)
      .then((response) => {
        this.friendList = response.data;
        this.setState({isLoading: false});
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data);
      });
  };

  sendFriendRequest(friendId, myId) {
    this.setState({isLoading: true})
    ApiService.post('friendship-request',{
      "requister_id": `${myId}`,
      "user_requisted_id": `${friendId}`,
      "status": "new"
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

  componentDidMount() {
   this.getFriendList()
  }
  componentWillUnmount() {
    console.log("componentWillUnmount")
  }

  render() {
    return (
      <SafeAreaView style={{flex: 1,backgroundColor:'white'}}>
        <View style={{flex: 1 ,marginBottom:0}}>
          <View
            style={{
              flex: 1,
            }}>
            <View style={{height: 72, width: "100%" ,backgroundColor:"rgba(10, 135, 138, 1)"}}>
            <Searchbar style ={{marginStart:10,marginEnd:10, fontStyle: "DMSans-Regular", fontSize:15}} 
              placeholder={translate('search_friend')}
              onChangeText={this.onChangeTextDelayed}
              icon={()=><Image source = {require('./../../../../assets/search.png')} />}
            />
            </View>
            <View style={{ backgroundColor: "white",marginBottom:70}}>
               
                <FlatList

                    keyExtractor = {(item) => item.id} 
                    data = {this.friendList}
                    numColumns={2}
                    renderItem={({item}) => <UserProfile 
                    user = {item} {...this.props}
                    clickEvent={(friendId, myId, status) => {
                      if (status == "accepted") {
                        this.removeFriendRequest(friendId, myId)
                      } else {
                        this.sendFriendRequest(friendId, myId)
                      }
                      
                    }}
                    profileOpenEvent={() => {
                      let userType = item.roles != null && item.roles.length > 0 ? item.roles[0].id: 2
                      if (userType == 7) {
                        let path = `user-profile?user_id=${item.id}`;
                        this.setState({isLoading: true});
                        ApiService.get(path)
                          .then((response) => {
                            var profileData = response.data;
                          
                            this.props.navigation.navigate('ServiceDetails',{  
                              book: profileData
                            })
                            this.setState({isLoading: false});
                          })
                          .catch((error) => {
                            this.setState({isLoading: false});
                            alert(error.data);
                          });
                      } else {
                        this.setState({isLoading: true});
                        ApiService.get(`user-profile?user_id=${item.id}`)
                            .then((response) => {
                              let userData = response.data
                              ApiService.get(`listings?user_id=${item.id}`)
                              .then((response) => {
                                this.setState({isLoading: false});
                                this.props.navigation.navigate('ProfileDetail',{  
                                  user: userData, ads: response.data, Friendship: item.Friendship, callBack: ()=>{
                                    this.getFriendList()
                                  }
                                })
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
                    }}
                    />
                  } 
                />
                </View>
            </View>
          
            
        </View>
        {this.state.isLoading ? (
            <Loader loading={this.state.loading} />
          ) : null}
      </SafeAreaView>
    );
  }
}
const styles = StyleSheet.create({

  mainView: {

      width: "100%",
      height: 35,
      borderRadius: 4,
      backgroundColor: "#FFFFFF",
      alignSelf: "center",
      justifyContent: "center",
      alignItems: "stretch",
      borderColor: "#F78A3A",
      borderWidth: 1
  },
  disableMainView: {

    width: "100%",
    height: 35,
    borderRadius: 4,
    backgroundColor: "#cecece",
    alignSelf: "center",
    justifyContent: "center",
    alignItems: "stretch",
    borderColor: "#F78A3A",
    borderWidth: 1
},
  buttonStyle: {color: "#F78A3A", fontSize: 17, fontWeight: "700", textAlign: "center", fontFamily: "DMSans-Regular"}
});