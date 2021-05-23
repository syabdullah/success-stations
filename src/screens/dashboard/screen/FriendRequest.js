import * as React from 'react';
import {Button, View, Text, SafeAreaView, FlatList, Image, StyleSheet, TouchableOpacity, TouchableWithoutFeedback} from 'react-native';
import { Searchbar ,DefaultTheme} from 'react-native-paper';
import {translate} from '../../../util/TranslationUtils';
import ApiService from '../../../network/ApiService';
import Loader from '../../Loader';
import AsyncStorage from '@react-native-community/async-storage'

const UserProfile =({user, acceptRequestEvent, rejectRequestEvent,...props}) => {
    var url = (user.requister.image != null && user.requister.image.preview != null) ? user.requister.image.preview  :'https://storage.googleapis.com/stateless-campfire-pictures/2019/05/e4629f8e-defaultuserimage-15579880664l8pc.jpg'
    return (
      <View style={{ width:'47%',margin:'1.5%', borderColor: "#00000030", borderWidth: 1, borderRadius: 4, height: 250}}>
          <View style={{width: 60, height: 60, borderRadius: 30, alignSelf: "center", marginTop: 21}}>
              <Image style={{width: 60, height: 60, borderRadius: 30}} 
                    source={{uri: url}}
              />
          </View>
          <View style={{height: 40, marginTop:7}}>
            <Text style={{fontSize: 15, fontWeight: "700", textAlign: "center", color: "#000000"}}>{user.requister.name}</Text>
            <Text style={{fontSize: 15, fontWeight: "400", textAlign: "center", color: "#9EA6BE",marginTop:9,marginLeft: 10,}}>{user.requister.email}</Text>
          </View>
          <View style={{width: "80%", alignSelf: "center", height: 35, marginBottom: 10, marginTop: 25}}>
          <View style={styles.mainView}>
              <TouchableOpacity onPress = {()=> {
                AsyncStorage.getItem('userdata').then((value)=> {
                  if(!value || 0 != value.length){ 
                    let user_id = JSON.parse(value).user_id;
                    acceptRequestEvent(user.requister.id, user_id, user.id)
                  }
                })  
              }
              }>
                <Text style={styles.buttonStyle}>
                {translate('accept')}
                </Text>
              </TouchableOpacity>
          </View>

          <View style={styles.mainView}>
              <TouchableOpacity onPress = {()=> {
                AsyncStorage.getItem('userdata').then((value)=> {
                  if(!value || 0 != value.length){ 
                    let user_id = JSON.parse(value).user_id;
                    rejectRequestEvent(user.requister.id, user_id, user.id)
                  }
                })  
              }
              }>
                <Text style={styles.buttonStyle}>
                {translate('reject')}
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

export default class FriendRequest extends React.Component {

    static navigationOptions = {
        header: null,
        options: {
          
        }
    };

    constructor(props) {
        super(props);
        this.state = { isLoading :false, friendList: []}
    }

    componentDidMount() {
        this.getFriendList()
    }

    componentWillUnmount() {

    }

    getFriendList = () => {
        this.setState({isLoading: true});
        ApiService.get('my-requests')
        .then((response) => {
          this.setState({friendList: response.data});
          this.setState({isLoading: false});
        })
        .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data);
        });
    };

    acceptRejectFriendRequest(requestId, status) {
        this.setState({isLoading: true})
        ApiService.post('accept-reject-request',{
            "request_id": `${requestId}`,
            "status": `${status}`
        })
        .then((response) => {
            this.setState({isLoading: false});
            this.getFriendList()
        })
        .catch((error) => {
            alert(error.data.message);
            this.setState({isLoading: false});
        });
    }

    render() {
        return (
          <SafeAreaView style={{flex: 1,backgroundColor:'white'}}>
            <View style={{flex: 1 ,marginBottom:0}}>
              <View
                style={{
                  flex: 1,
                }}>
                <View style={{ backgroundColor: "white", height: "90%", justifyContent: "center"}}>
                    
                    {this.state.friendList.length > 0 ? 
                    <FlatList
                        keyExtractor = {(item) => item.id} 
                        data = {this.state.friendList}
                        numColumns={2}
                        renderItem={({item}) => <UserProfile 
                        user = {item} {...this.props}
                        acceptRequestEvent={(friendId, myId, requestId) => {
                            this.acceptRejectFriendRequest(requestId, "accepted")
                        }}
                        rejectRequestEvent={(friendId, myId, requestId) => {
                            this.acceptRejectFriendRequest(requestId, "rejected")
                        }}
                        />
                      } 
                    />:
                    <Text style={{ height: 50,alignSelf: 'center', fontFamily: "DMSans-Bold",fontSize:15, textAlign: 'center'}}>No Friend Request found</Text>}
                    
                </View>
                </View>
                {this.state.isLoading ? (
                <Loader loading={this.state.loading} />
              ) : null}
            </View>
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
        borderWidth: 1,
        marginTop: 5
    },
    buttonStyle: {color: "#F78A3A", fontSize: 17, fontWeight: "700", textAlign: "center"}
  });