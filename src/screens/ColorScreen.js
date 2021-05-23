import React, { useState } from "react";
import { Text, View, Button, StyleSheet } from "react-native";
import { FlatList } from "react-native-gesture-handler";
import { Value } from "react-native-reanimated";

const COLOR_CONSTANT = 15

const ColorScreen = () => {

    const [color, setColor] = useState([])
    console.log(color);
    return (
        <View>
            <Button
                title = "Add Color"
                onPress = {() => {
                    setColor([...color, getRandomColor()])
                }} 
            />
            <FlatList
                keyExtractor = {(item) => item}
                data = {color}
                renderItem = {({item}) => {
                    return <View style={{height: 100, width: 100, backgroundColor: item, marginVertical: 5}}></View>
                }} 
            />
        </View>
    )
};

const getRandomColor = () => {
    
    const red = Math.random() * 256;
    const green = Math.random() * 256;
    const blue = Math.random() * 256;
    return `rgb(${red}, ${green}, ${blue})`
}

const style = StyleSheet.create({

});

export default ColorScreen;