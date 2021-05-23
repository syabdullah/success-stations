import React, {useState} from "react";
import { View, Text, Image, StyleSheet, TextInput ,I18nManager, TouchableOpacity} from "react-native";
import * as RNLocalize from 'react-native-localize';
import i18n from 'i18n-js';
import {translate} from "../src/util/TranslationUtils";
import BorderButton from './BorderButton';

const CommentView = ({data, clickEvent}) => {
    let avatar = data.user_name.image != null && data.user_name.image.thumbnail != null ? data.user_name.image.thumbnail: ""
    this.comment = '';
    return (
        <View style={{width: "100%", backgroundColor: "white"}}>
            <View style={{width: "90%", alignSelf: "center", flexDirection: "row"}}>
                <View style={{marginTop: 10}}>
                    {avatar == ""?(
                    <Image style={{width: 40, height: 40, borderRadius: 20}}
                        resizeMode="contain"
                        source={{uri: 'https://storage.googleapis.com/stateless-campfire-pictures/2019/05/e4629f8e-defaultuserimage-15579880664l8pc.jpg'}}
                    />
                    ): <Image style={{width: 40, height: 40, borderRadius: 20}}
                    resizeMode="contain"
                    source={{ uri: avatar}} 
                />}
                </View>
                {/*<Image style={{width: 8, height: 7, position: "absolute", right: 0, marginTop: 10}}
                            resizeMode="contain"
                            source={require('../assets/book/flag-button.png')}
    /> */}
                <View style={{marginLeft: 10, marginTop: 10, marginBottom: 10, flex: 1}}>
                    <View>
                        <Text style={{fontSize:15, fontWeight: "500", fontStyle: "normal", color: "#000000", fontFamily: "DMSans-Regular"}}>{data.user_name.name}</Text>
                        
                    </View>
                    <Text style={{fontSize:12, fontWeight: "normal", fontStyle: "normal", color: "rgba(60, 60, 67, 0.6)", fontFamily: "DMSans-Regular"}}>{data.created_at}</Text>
                    <Text style={{fontSize:12, fontWeight: "500", fontStyle: "normal", color: "#5D648A", marginRight: 20, fontFamily: "DMSans-Regular"}}>{data.comment}</Text>
                    
                    <View style={{backgroundColor:"rgba(158, 166, 190, 0.26)", height: 1, marginTop: 15}}></View>
                </View>
            </View>
        </View>
    )
}

export default CommentView;