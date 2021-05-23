import React from "react";
import { Text, StyleSheet, View, Button } from "react-native";

const HomeScreen = (props) => {
  const subtitle = 'My name is iMran'
  return (
    <View>
      <Text style={styles.text}>Welcome to React Native</Text>
      <Button 
        title = "Go to Listing"
        onPress = {() => props.navigation.navigate('MyList')}
      />
      <Button 
        title = "Go to Image"
        onPress = {() => props.navigation.navigate('ImageSc')}
      />
      <Button 
        title = "Go to Counter"
        onPress = {() => props.navigation.navigate('counterScreenByReducer')}
      />
      <Button 
        title = "Go to Color"
        onPress = {() => props.navigation.navigate('colorScreen')}
      />
      <Button 
        title = "Go to Square"
        onPress = {() => props.navigation.navigate('squareScreenByReducer')}
      />
      <Button 
        title = "Go to Text Screen"
        onPress = {() => props.navigation.navigate('textScreen')}
      />
      <Button 
        title = "Go to Country Select Screen"
        onPress = {() => props.navigation.navigate('countrySelectScreen')}
      />
      
    </View>
    )
};

const styles = StyleSheet.create({
  text: {
    fontSize: 45,
    textAlign: "center"
  }
});

export default HomeScreen;
