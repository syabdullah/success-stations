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
import { GooglePlacesAutocomplete } from 'react-native-google-places-autocomplete';

export default class SelectMyLocation extends React.Component {

    constructor(props) {
        super(props);
        this.state = {isLoading: false, latlog:{ latitude: 40.7128, longitude:74.0060 ,latitudeDelta: 0.0922,
            longitudeDelta: 0.0421,}}
        
    }

    componentDidMount() {
    }

    componentWillUnmount() {
    }

    render() {
        return (
            <SafeAreaView style={{flex: 1}}>
                <View style={{flex: 1}}>
                    <View style={{width: '100%', height:'40%'}}>
                        <GooglePlacesAutocomplete
                            placeholder='Search'
                            currentLocation={true} // Will add a 'Current location' button at the top of the predefined places list
                            currentLocationLabel="Current location"
                            nearbyPlacesAPI="GooglePlacesSearch"
                            GoogleReverseGeocodingQuery={{
                                // available options for GoogleReverseGeocoding API : https://developers.google.com/maps/documentation/geocoding/intro
                              }}
                              fetchDetails = {true}
                            onPress={(data, details = null) => {
                                
                                this.setState({latlog:{
                                    latitude: details.geometry.location.lat, 
                                    longitude: details.geometry.location.lng,
                                    latitudeDelta: 0.0922,
                                     longitudeDelta: 0.0421,
                                }})
                            
                                
                            }}
                            query={{
                                key: 'AIzaSyA-8PqMvsgO8pwbV9wD9gzFEggUhG4px6Y',
                                language: 'en',
                            }}
                            onFail={(error) => 
                                console.error("this is after fail", error)
                            }
                            
                        />
                    </View>
                    <View style={{width: '100%', height: '60%'}}>
                        <MapView
                            style={{ flex: 1 }}
                            region={this.state.latlog}

                            onRegionChangeComplete={region => this.state.latlog}>
                        <Marker coordinate={this.state.latlog} />
                        </MapView>
                    </View>
                    <View style={{width: '80%', alignSelf: "center",position:'absolute',bottom:10 }}>
                    <ButtonView
                        clickEvent={() => {
                            this.setState({isLoading: true});
                            let data = this.props.route.params.data
                            data.lat = this.state.latlog.latitude
                            data.long = this.state.latlog.longitude
                            ApiService.post('location-create', data)
                            .then((response) => {
                                this.setState({isLoading: false});

                                this.props.navigation.pop(2)
                                
                            })
                            .catch((error) => {
                                this.setState({isLoading: false});
                                alert(error.data.message);
                            });
                        }}
                        name={translate('save')}
                    />
                    </View>    
                </View>
                {this.state.isLoading ?   <Loader
                loading={this.state.loading} /> :null}
            </SafeAreaView>
        )
    }
}