import React from "react";
import { Text, StyleSheet, View, TouchableOpacity } from "react-native";

const BorderButton = ({name, clickEvent}) => {
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

        width: "100%",
        height: 50,
        borderRadius: 4,
        backgroundColor: "#F2F2F2",
        alignSelf: "center",
        justifyContent: "center",
        alignItems: "stretch",
        borderColor: "#F78A3A",
        borderWidth: 1
    },
    buttonStyle: {color: "#F78A3A", fontSize: 17, fontWeight: "700", textAlign: "center"}
});

export default BorderButton;