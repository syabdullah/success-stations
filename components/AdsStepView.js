import React from 'react'
import {View, Text, Image, StyleSheet} from 'react-native'

const AdsStepView = ({isSelected, displayText, stepNo}) => {
    imageName = isSelected ? '../assets/Ads/ads-enable-arrow.png' : '../assets/Ads/ads-disable-arrow.png'
    return (<View style={{width: "100%", height: 65, flexDirection: "row", alignitems: "space-between"}}>
                <View style={{width: 80, height: 65, flexDirection: "column", alignitems: "space-between"}}>
                    <View style={{width:80, height:33, justifyContent: "center"}}>
                        <View style={isSelected ? styles.selectedViewStyle: styles.unselectedViewStyle}>
                            <Text style={isSelected ? styles.selectedStepNumberText: styles.unSelectedStepNumberText}>{stepNo}</Text>
                        </View>
                    </View>
                    <View style={{}}>
                        <Text style={isSelected ? styles.selectedStepTitleText: styles.unSelectedStepTitleText}>{displayText}</Text>
                    </View>
                </View>
            </View>
            )
}

const styles = StyleSheet.create({
    selectedStepTitleText: {
      fontSize: 14,
      fontWeight: "400",
      textAlign: "center", 
      color: "white"
    },
    unSelectedStepTitleText: {
        fontSize: 14,
        fontWeight: "400",
        textAlign: "center", 
        color: "#95CACB"
    },
    unSelectedStepNumberText: {
      fontSize: 15,
      fontWeight: "700",
      color: "#95CACB",
      width:20,
      height:20,
      alignSelf: "center",
    },
    selectedStepNumberText: {
      fontSize: 15,
      fontWeight: "700",
      color: "#F78A3A",
      width:20,
      height:20,
      alignSelf: "center",
    },
    selectedViewStyle: {
        width:33, 
        height:33, 
        borderRadius:17.5, 
        backgroundColor: "white", 
        alignSelf: "center", 
        justifyContent: "center"
    },
    unselectedViewStyle: {
        width:33, 
        height:33, 
        borderRadius:17.5, 
        backgroundColor: "#076769", 
        alignSelf: "center", 
        justifyContent: "center"
    }
  });

  export default AdsStepView;