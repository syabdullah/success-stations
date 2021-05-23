import React from "react";
import { View, Image, StyleSheet, Text } from "react-native";

const ImageCard = (props) => {

    return (
        <View style={styles.viewStyle}>
            <Image source={props.source} />
            <Text>{props.title}</Text>
        </View>
    )
};


const styles = StyleSheet.create({
    viewStyle: {
        alignContent: "center",
        marginVertical: 10,
        backgroundColor: "#cecece"
    }
});

export default ImageCard