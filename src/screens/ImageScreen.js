import React from "react"
import { Text, StyleSheet, View } from "react-native";
import ImageCard from "../../components/ImageCard";

const ImageScreen = () => {
    return (
        <View>
            <Text style={styles.textStyle}>Welcome to Image Screen</Text>
            <View>
                <ImageCard title="Forest" source={require('../../assets/forest.jpg')} />
                <ImageCard title="Beach" source={require('../../assets/beach.jpg')} />
                <ImageCard title="Mountains" source={require('../../assets/mountain.jpg')} />
            </View>
        </View>
    )
};

const styles = StyleSheet.create({
    textStyle: {
        textAlign: "center",
        fontSize: 20,
        fontWeight: "bold"
    }
});

export default ImageScreen;