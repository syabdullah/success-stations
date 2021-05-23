import React, {useState} from "react";
import {View, Text, Image, FlatList, TouchableOpacity} from "react-native"
const BookDetailView = ({book,props,isBookDetail=false}) => {
    let url = (book.image != null && book.image.length > 0) ? book.image[0].url: "";
    return (
      <TouchableOpacity
        style={{
          width:'47%',margin:'1.5%', 
          
          borderColor: '#00000030',
          borderWidth: 1,
          borderRadius: 4,
          
        }}
        onPress={() => isBookDetail?    props.navigation.navigate('BookDetailScreen', { data: { bookId: book.id }})  : props.navigation.navigate('ServiceProfileScreen', {book})}>
        <View style={{}}>
          <View style={{width: '100%', height: 140}}>
            <Image
              source={{uri: url}}
              style={{width: '100%', height: '100%'}}
            />
          </View>
          <View style={{width: '100%'}}>
            <View style={{marginLeft: 10}}>
              <Text
                style={{
                  fontSize: 15,
                  fontStyle: 'normal',
                  fontWeight: '500',
                  color: '#000000',
                  marginTop: 10,
                  fontFamily: "DMSans-Regular", 
                }}>
              {book.title}
              </Text>
              <Text
                style={{
                  fontSize: 15,
                  fontStyle: 'normal',
                  fontWeight: '500',
                  color: '#0A878A',
                  marginTop: 5,
                  marginBottom:5,
                  fontFamily: "DMSans-Regular", 
                }}>
               SR {book.price}
              </Text>
             
            </View>
          </View>
        </View>
      </TouchableOpacity>
    );
  };

  export default BookDetailView;