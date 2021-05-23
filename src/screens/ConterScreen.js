import React, { useState  } from "react";
import { View, Button, StyleSheet, Text } from "react-native";

const CounterScreen = () => {
    const [counter, setCounter] = useState(0);
    return (
        <View>
            <Button
                title = "Increase Counter"
                onPress = {() => {
                    setCounter(counter + 1);
                }} 
            />
            <Button
                title = "Decrease Counter"
                onPress = {() => {
                    setCounter(counter - 1);
                }}
             />
            <Text>
                Counter is: {counter}
            </Text>
        </View>
    )
};

const styles = StyleSheet.create({

});

export default CounterScreen;