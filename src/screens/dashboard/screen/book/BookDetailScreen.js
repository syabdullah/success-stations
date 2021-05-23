import * as React from 'react';
import {
  View,
  Text,
  SafeAreaView,
  TouchableOpacity,
  StyleSheet,
  Image,
  ScrollView,
  FlatList,
  Platform,
  Linking
} from 'react-native';

import DisplayBookInformation from '../../../../../components/DisplayBookInformation';
import {translate} from '../../../../util/TranslationUtils';
import ProfileView from '../../../../../components/ProfileView';
import AdPostedAtView from '../../../../../components/AdPostedAtView';
import CommentView from '../../../../../components/CommentView';
import ButtonViewWithImage from '../../../../../components/ButtonViewWithImage';
import ApiService from '../../../../network/ApiService';
import Loader from '../../../Loader';
import AsyncStorage from '@react-native-community/async-storage'

export default class BookDetailScreen extends React.Component {

    getBookDetail = () => {
        this.setState({isLoading: true});
        ApiService.get(`listings?id=${this.props.route.params.data.bookId}`)
        .then((response) => {
            this.setState({book: response.data})
            var city = response.data.city.city != null ? response.data.city.city+", ": ""
            var region = response.data.region.region != null ? response.data.region.region+", ": ""
            var country = response.data.country.name != null ? response.data.country.name: ""
            var fullAddress = `${city+region+country}`
            this.setState({fullAddress: response.data.city.city != null ? response.data.city.city: ""})
            this.getBookComments();
        })
        .catch((error) => {
            this.setState({isLoading: false});
        });
    }

    getBookComments = () => {

        ApiService.get(`comments?listing=${this.props.route.params.data.bookId}`)
        .then((response) => {
            this.setState({isLoading: false});
            this.setState({comments: response.data})
        })
    }

    static navigationOptions = ({ navigation, navigationOptions }) => {
        const { params } = navigation.state;
      
        return {
          header: () => null
            };
        };

    constructor(props) {
        super(props);
        
        this.state = {
            isLoading: false,
            book: {},
            userId: 0,
            comments: [],
            fullAddress: '',
            user: {}
        }
        
        AsyncStorage.getItem('userdata').then((value)=> {
            if(!value || 0 != value.length){ 
                this.setState({userId : JSON.parse(value).user_id})
            }
        }).catch(()=> {
        })
    }

    componentDidMount() {
        this.getBookDetail()
    }

    componentWillUnmount() {

    }

    render() {

        return (
            <SafeAreaView style={{flex: 1}}>
                <View style={{flex: 1}}>
                    <View style={{width: '100%', marginBottom: 90}}>
                        <ScrollView style={{}}>
                        <View style={{height: 280, width: "100%"}}>
                            {this.state.book.media != null?
                            (<Image style={{width: "100%", height: 280}}
                            source={{ uri: this.state.book.media[0].url }} 
                                 />) : (
                            <Image style={{width: "100%", height: 280}}
                                source={require('../../../../../assets/book-image.png')} 
                            />)
    }
                            <TouchableOpacity style={{width: 22, height: 22, position: "absolute", marginLeft: 15, marginTop: 5, backgroundColor: 'rgba(52, 52, 52, 0.5)'}} 
                                onPress={() =>{
                                    this.props.navigation.pop();
                                }}
                            >
                            <Image 
                                resizeMode="contain"
                                source={require('../../../../../assets/book/back-icon.png')}
                            />
                            </TouchableOpacity>
                            {/*<TouchableOpacity style={{width: 22, height: 22, position: 'absolute', marginTop: 55, right:10}}>
                            <Image  
                                resizeMode="contain"
                                source={require('../../../../../assets/book/share-icon.png')}
                            />
                            </TouchableOpacity>*/}
                            {this.state.book.if_favorite == true ? (
                            <View style={{right: 5, top: 5, position: "absolute", borderRadius: 12.5, width: 25, height: 25, backgroundColor: "#ffffff", justifyContent: 'center'}}>
                                <Image 
                                    style={{width: 10, height: 10, alignSelf: "center"}}
                                    source={ require('../../../../../assets/heart.png') }
                                />
                            </View>): null}
                        </View>
                        <View style={{width: "100%"}}>
                            <Text style={{marginLeft: 15, marginTop: 15, marginRight: 15, fontSize: 20, fontStyle: "normal", color: "#000"}}>
                                {this.state.book != null? this.state.book.title: "N/A"}
                            </Text>
                            <Text style={{marginLeft: 15, marginTop: 15, marginRight: 15, fontSize: 20, fontStyle: "normal", color: "#0A878A"}}>
                                SR {this.state.book.price}
                            </Text>
                        </View>
                        <View style={{width: "100%", height: 6, backgroundColor: "#F4F7FC", marginTop: 15}}></View>
                        <View style={{width: "100%", height: 115, justifyContent: 'space-between', flexDirection: "column"}}>
                                <View style={{width: "100%", height: 40, justifyContent: 'space-between', flexDirection: "row", marginTop: 15}}>
                                    <View style={{width: "45%", marginLeft: 5}}>
                                        <DisplayBookInformation 
                                            heading={translate("city")}
                                            headingValue={this.state.fullAddress != '' ? this.state.fullAddress: "N/A"}
                                        />
                                    </View>
                                    <View style={{width: "45%", marginLeft: 10,}}>
                                        <DisplayBookInformation 
                                            heading={translate("type")}
                                            headingValue={this.state.book.category != null ? this.state.book.category.category: "N/A"}
                                        />
                                    </View>
                                </View>
                                <View style={{width: "100%", height: 40, justifyContent: 'space-between', flexDirection: "row"}}>
                                    <View style={{width: "45%", marginLeft: 5}}>
                                        <DisplayBookInformation 
                                            heading={translate("ad_number")}
                                            headingValue={this.state.book.phone != null ? this.state.book.phone: "N/A"}
                                        />
                                    </View>
                                    <View style={{width: "45%", marginLeft: 15}}>
                                        <DisplayBookInformation 
                                            heading={translate("status")}
                                            headingValue={this.state.book.status != null? this.state.book.status: "N/A"}
                                        />
                                    </View>
                                </View>
                                <View style={{width: "100%", height: 40, justifyContent: 'space-between', flexDirection: "row", marginBottom: 15}}>
                                    <View style={{width: "100%", marginLeft: 5}}>
                                        <DisplayBookInformation 
                                            heading={translate("section")}
                                            headingValue="Books"
                                        />
                                    </View>
                                </View>
                            </View>
                            <View style={{width: "100%", height: 6, backgroundColor: "#F4F7FC", marginTop: 15}}></View>
                            <View style={{width: "100%", flexDirection: "column", justifyContent: "space-between", marginTop: 15}}>
                                <Text style={{marginLeft: 15, fontSize: 20, fontStyle: "normal", color: "#000", fontWeight: "700"}}>
                                {translate('details')}
                                </Text>
                                <Text style={{marginLeft: 15, fontSize: 12, fontStyle: "normal", color: "#000", fontWeight: "500", marginTop: 15}}>
                                    {this.state.book.description}
                                </Text>
                            </View>
                            <View style={{width: "100%", height: 6, backgroundColor: "#F4F7FC", marginTop: 15}}></View>
                            <View style={{width: "100%"}}>
                                <ProfileView 
                                    data = {this.state.book}
                                    clickEvent={(userId) => {
                                        this.setState({isLoading: true});
                                        ApiService.get(`user-profile?user_id=${userId}`)
                                            .then((response) => {
                                            let userData = response.data
                                            this.setState({isLoading: false});
                                            this.props.navigation.navigate('ProfileDetail',{  
                                            user: userData, ads: response.data, Friendship: {}
                                            })
                                            })
                                            .catch((error) => {
                                            this.setState({isLoading: false});
                                            alert(error.data.message);
                                            });
                                    }}
                                />
                            </View>
                            <View style={{width: "100%", height: 6, backgroundColor: "#F4F7FC", marginTop: 15}}></View>
                            <View style={{width: "100%", height: 200}}>
                                <AdPostedAtView
                                    clickEvent={(comment) => {
                                        
                                        if (comment.length > 0) {
                                            this.setState({isLoading: true});
                                            var data = {
                                                "user_name_id": this.state.userId,
                                                "listing_id": this.props.route.params.data.bookId,
                                                "comment": comment,
                                                "parent_comment": "0"
                                              }
                                            ApiService.post('add-comment', data)
                                            .then((response) => {
                                                this.setState({isLoading: false});
                                                this.getBookComments();
                                            })
                                            .catch((error) => {
                                                this.setState({isLoading: false});
                                                alert(error.data.message);
                                            });
                                        } else {
                                            alert(translate('please_enter_comment'));
                                        }
                                    }}
                                />

                            </View>
                            <View style={{width: "100%", height: 6, backgroundColor: "#F4F7FC", marginTop: 15}}></View>
                            <FlatList
                                style={{marginTop:10,marginBottom:10}}
                                data={this.state.comments}
                                renderItem={({item}) => <View style={{width: "100%"}}>
                                <CommentView
                                    clickEvent={() => {

                                    }}
                                    data = {item}
                                />
                            </View>} 
                                numColumns={2}
                            />
                        </ScrollView>
                    </View>
                    <View style={{width: "100%", backgroundColor: "white", position: "absolute", bottom: 0, justifyContent: "center",}}>
                        <View style={{height: 80, width: "100%", justifyContent: "center", alignContent: "center",}}>
                            <View style={{flex: 1,flexDirection: 'row', justifyContent: 'space-around', height: "100%"}}>
                                <View style={{width: "42%", height: "100%", justifyContent: "center"}}>
                                    <ButtonViewWithImage 
                                        name={translate('contact')}
                                        clickEvent={() => {
                                            let phoneNumber = '';
                                            if (Platform.OS === 'android') {
                                                phoneNumber = `tel:${this.state.book.phone}`;
                                            }
                                            else {
                                                phoneNumber = `telprompt:${this.state.book.phone}`;
                                            }
                                            Linking.openURL(phoneNumber);
                                        }}
                                        imgSource={require('../../../../../assets/book/phone-icon.png')}
                                        isBackground={true}
                                    />    
                                </View>
                                <View style={{width: "52%", height: "100%", justifyContent: "center"}}>
                                    <ButtonViewWithImage 
                                        name={this.state.book.if_favorite == true ? translate('remove_from_favourites'): translate('add_to_favourites')}
                                        clickEvent={() => {
                                            this.setState({isLoading: true});
                                            ApiService.post('mark-favorite', {
                                                "user_name_id": this.state.userId,
                                                "listing_id": this.props.route.params.data.bookId
                                              }).then(() => {
                                                this.setState({isLoading: false});
                                                this.getBookDetail();
                                                this.props.route.params.data.callBack();
                                              }).catch(() => {
                                                this.setState({isLoading: false});
                                              })
                                        }}
                                        imgSource={require('../../../../../assets/book/heart-icon.png')}
                                        isBackground={false}
                                    /> 
                                </View>
                            </View>
                        </View>
                    </View>
                </View>
                {this.state.isLoading ?   <Loader
                loading={this.state.loading} /> :null}
            </SafeAreaView>
        )
    }
}

const styles = StyleSheet.create({

});