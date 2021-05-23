import React, {useState} from "react";
import { View, Text, Image, StyleSheet, TextInput ,I18nManager} from "react-native";
import * as RNLocalize from 'react-native-localize';
import i18n from 'i18n-js';
import {translate} from "../src/util/TranslationUtils";
import BorderButton from './BorderButton';
import MapView, { Marker } from "react-native-maps";
const AdPostedAtView = ({clickEvent}) => {
    const [region, setRegion] = useState({
        latitude: 21.487301,
        longitude: 39.181339,
        latitudeDelta: 0.009,
        longitudeDelta: 0.009
      });
    const [comment, setComment] = useState('');
    return (
        <View style={{width: "100%", height: 200}}>
            <Text style={{fontSize: 20, fontWeight: "700", fontStyle: "normal", marginTop: 10, marginLeft: 15}}>{translate('ad_posted_at')}</Text>
            <View style={{width: "90%", alignSelf: "center"}}>
                <TextInput
                    autoCapitalize="none"
                    autoCorrect={false}
                    style={{textAlign: I18nManager.isRTL ? 'right' : 'left', borderColor: "#0A878A", borderRadius:4, height: 83, backgroundColor: 'rgba(196, 196, 196, 0.26)', width: "100%", marginTop: 10}}
                    placeholder={`  `+translate('write_comment_here')}
                    multiline={true}
                    onFocus = {(newValue) => {
                    }}
                    onChangeText = {(newValue) => {
                        setComment(newValue);
                    }}
                    clearButtonMode="always"
                    selectedText={comment}
                    value={comment}
                />
            </View>
            <View style={{width: "90%", alignSelf: "center"}}>
                <View style={{width: "40%", marginTop: 10, alignSelf: "flex-end"}}>
                    <BorderButton
                        name={translate("add_a_comment")}
                        clickEvent={() => {
                            setComment('')
                            clickEvent(comment)
                            
                        }}
                    />  
                </View>
            </View>      
            
        </View>
        )
}

const styles = StyleSheet.create({

});

export default AdPostedAtView;