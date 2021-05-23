import React, { useState } from "react";
import { Text, View, StyleSheet, TextInput } from "react-native";

const TextScreen = () => {

    const validateTextInput = (text) => {
        return name.length > 5? true : false
    };

    const [name, setName] = useState('');

    return (
        <View>
            <Text>Enter Name</Text>
            <TextInput
                autoCapitalize="none"
                autoCorrect={false}
                style={styles.input}
                value={name}
                onChangeText={(newValue) => {
                    setName(newValue); 
                    
                }
                                
                             }
            />
            <Text>My Name is: {name}</Text>
            {validateTextInput({name}) ? <Text>Your name must not be longer than 5</Text>: null }
        </View>
    );
};

const styles = StyleSheet.create({
    input: {
        margin: 15,
        height: 40,
        borderRadius: 5,
        borderColor: "#cecece",
        borderWidth: 1,
    }
});

export default TextScreen;