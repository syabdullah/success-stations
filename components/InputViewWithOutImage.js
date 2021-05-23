import React, {useState} from "react";
import { View, Text, Image, StyleSheet, TextInput ,I18nManager} from "react-native";

const InputViewWithOutImage = ({ changeTextEvent, placeholderText, isFullWidth, keyboardTypeValue = "default"}) => {
    const [borderWidth, setBorderWidth] = useState(0);
    return (
        <View style={[isFullWidth ? style.inputFullViewStyle : style.inputHalfViewStyle, {borderWidth: borderWidth}]}>
            <View style={{width: isFullWidth ? "100%": "50%", justifyContent: "center"}}>
                <TextInput
                    autoCapitalize="none"
                    autoCorrect={false}
                    style={isFullWidth ? style.inputFullFieldStyle : style.inputHalfFieldStyle,{textAlign: I18nManager.isRTL ? 'right' : 'left'}}
                    onChangeText = {(newValue) => 
                        changeTextEvent(newValue)
                    }
                    placeholder={`  `+placeholderText}
                    onFocus = {(newValue) => {
                        setBorderWidth(1);
                    }}
                    keyboardType={keyboardTypeValue}
                />
            </View>
        </View>
    );
};

const style = StyleSheet.create({

    inputFullFieldStyle: {
        height: 45,
        alignSelf: "center",
        width: 270,
    },
    inputHalfFieldStyle: {
        height: 45,
        alignSelf: "center",
        width: 85,
    },
    imageStyle: {
        width: 18,
        height: 15,
        left: 12,
        borderWidth: 0,
        borderColor: "red",
        resizeMode: "contain",
    },
    inputFullViewStyle: {
        borderWidth: 0,
        borderColor: "#0A878A",
        height: 50,
        width: 320,
        borderRadius: 4,
        alignItems: "stretch",
        alignSelf: "center",
        justifyContent: "space-between",
        flexDirection: "row",
        backgroundColor: "#FFFFFF",
    },
    inputHalfViewStyle: {
        borderWidth: 0,
        borderColor: "#0A878A",
        height: 50,
        width: 150,
        borderRadius: 4,
        alignItems: "stretch",
        alignSelf: "center",
        justifyContent: "space-between",
        flexDirection: "row",
        backgroundColor: "#FFFFFF",
    }
});

export default InputViewWithOutImage;