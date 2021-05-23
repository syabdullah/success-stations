import React from 'react'
import {View, Text, Image, StyleSheet} from 'react-native'

const ArrowView = ({isSelected}) => {
    return (<View style={{width: "100%", height: 6, justifyContent: "center"}}>
                <View style={{height:6, width:39, justifyContent: "center"}}>
                    {isSelected ?
                    <Image
                        style={{height:5, width:39}} 
                        source={require('../assets/Ads/ads-enable-arrow.png')}
                    />
                    : <Image
                    style={{height:5, width:39}} 
                    source={require('../assets/Ads/ads-disable-arrow.png')}
                /> }
                </View>
            </View>
            )
}

export default ArrowView;