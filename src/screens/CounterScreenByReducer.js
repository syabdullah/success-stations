import React, { useReducer  } from "react";
import { View, Button, StyleSheet, Text } from "react-native";

const COUNTER_CONSTANT = parseInt(15)
const COUNTER_DEFAULT = parseInt(0)

const counterReducer = (state, action) => {
    console.log("value is:", state.value, "payload is:", action.payload);
    return parseInt(state.value) + parseInt(action.payload) < 0 || parseInt(state.value) + parseInt(action.payload) > 1000
           ? state
           : {state, value: parseInt(parseInt(state.value) + parseInt(action.payload))}
};

const CounterScreenByReducer = () => {
    const [state, action] = useReducer(counterReducer, {value: parseInt(0)});
    return (
        <View>
            <Button
                title = "Increase Counter"
                onPress = {() => {
                    action({type: 'change_counter', payload: parseInt(COUNTER_CONSTANT)})
                }} 
            />
            <Button
                title = "Decrease Counter"
                onPress = {() => {
                    action({type: 'change_counter', payload: parseInt(-1 * COUNTER_CONSTANT)})
                }}
             />
            <Text>
                Counter is: {parseInt(state.value)}
            </Text>
        </View>
    )
};

const styles = StyleSheet.create({

});

export default CounterScreenByReducer;