import React from "react";
import { View, Text, FlatList, StyleSheet } from "react-native";

const MyListScreen = () => {
    const persons = [
        {name: 'Person #1', age: 14},
        {name: 'Person #2', age: 14},
        {name: 'Person #3', age: 14},
        {name: 'Person #4', age: 14},
        {name: 'Person #5', age: 14},
        {name: 'Person #6', age: 14},
        {name: 'Person #7', age: 14},
        {name: 'Person #8', age: 14},
        {name: 'Person #9', age: 14},
        {name: 'Person #10', age: 14}
    ];
    return (
        <View>
            <Text style={styles.heading}>Welcome to Listing</Text>
            <FlatList
            keyExtractor = {(item) => item.name} 
            data = {persons}
            renderItem = { ({item}) => {
                return (
                    <View style={styles.itemStyle}>
                        <Text>Name: {item.name}</Text>
                        <Text>Age: {item.age}</Text>
                    </View>
                )
            }

            } />
        </View>
    ) 
};

const styles = StyleSheet.create({
    heading: {
        fontSize: 20,
        textAlign: "center",
        fontWeight: "bold"
    },
    itemStyle: {
        fontSize: 15,
        textAlign: "left",
        fontFamily:'Times New Roman',
        color: '#fff',
        backgroundColor: "#cecece",
        marginTop: 5,
        height: 60,
        borderBottomWidth: 1
    }
});

export default MyListScreen;