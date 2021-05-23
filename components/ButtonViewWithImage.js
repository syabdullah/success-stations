import React from "react";
import { Text, StyleSheet, View, TouchableOpacity, Image } from "react-native";

const ButtonViewWithImage = ({name, imgSource, clickEvent, isBackground}) => {
    return (
        <View style={isBackground ? styles.mainViewWithBG: styles.mainViewWithoutBG}>
            <TouchableOpacity style={{flexDirection: "row"}}
                onPress = { () => clickEvent()}
            >
            <Image style={{width: 16, height: 16, marginLeft: 18}}
                resizeMode="contain"
                source={imgSource} 
            />
            <Text style={isBackground ? styles.buttonWithBackGroundStyle: styles.buttonWithOutBackGroundStyle}>{name}</Text>    
            </TouchableOpacity>
        </View>
    )
}

const styles = StyleSheet.create({

    mainViewWithBG: {
        width: "100%",
        height: 50,
        borderRadius: 4,
        backgroundColor: "#F78A3A",
        justifyContent: "center"
    },
    mainViewWithoutBG: {

        width: "100%",
        height: 50,
        borderRadius: 4,
        borderWidth: 1,
        backgroundColor: "white",
        justifyContent: "center",
        borderColor: "rgba(0, 0, 0, 0.23)"
    },
    buttonWithBackGroundStyle: {color: "#ffffff", fontSize: 17, fontWeight: "700", textAlign: "center", marginLeft: 2},
    buttonWithOutBackGroundStyle: {color: "#F78A3A", fontSize: 17, fontWeight: "700", textAlign: "center", marginLeft: 2}
});

export default ButtonViewWithImage;