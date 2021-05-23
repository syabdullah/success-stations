import React from "react";
import { Text, StyleSheet, View, TouchableOpacity } from "react-native";

const ButtonView = ({name, clickEvent}) => {
    return (
        <View style={styles.mainView}>
            <TouchableOpacity
                onPress = { () => clickEvent()}
            >
            <Text style={styles.buttonStyle}>
                {name}
            </Text>
            </TouchableOpacity>
        </View>
    )
}

const styles = StyleSheet.create({

    mainView: {
        fontFamily: "DMSans-Regular",
        width: "100%",
        height: 50,
        borderRadius: 4,
        backgroundColor: "#F78A3A",
        alignSelf: "center",
        justifyContent: "center",
        alignItems: "stretch"
    },
    buttonStyle: {color: "#ffffff", fontSize: 17, fontWeight: "700", textAlign: "center"}
});

export default ButtonView;