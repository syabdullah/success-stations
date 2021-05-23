// React Navigate Drawer with Bottom Tab
// https://aboutreact.com/bottom-tab-view-inside-navigation-drawer/

import * as React from 'react';
import {
  View,
  Text,
  SafeAreaView,
  TouchableOpacity,
  StyleSheet,
  FlatList,
} from 'react-native';
import {translate} from '../../../../util/TranslationUtils'
import {Card} from 'react-native-paper';


const FlatListItems = [
  {
    id: 1,
    title: translate("google_maps"),
  },
  {
    id: 2,
    title: translate("telephone_number"),
  },
  {
    id: 3,
    title: translate("Information"),
  }
];

const Header = () => {
  return (
    <View style={{}}>
      <View
        style={{
          width: 77,
          height: 38,
          backgroundColor: '#F78A3A',
          borderRadius: 5,
          alignSelf: 'center',
          justifyContent: 'center',
          marginTop: 25,
        }}>
        <Text
          style={{
            color: 'white',
            fontSize: 20,
            textAlign: 'center',
            fontWeight: 'bold',
          }}>
          PRO
        </Text>
      </View>
      <Text
        style={{
          color: 'black',
          fontSize: 25,
          textAlign: 'center',
          fontWeight: 'bold',
          fontStyle: 'normal',
          marginTop: 10,
        }}>
        Service Provider
      </Text>
      <View
        style={{
          height: 1,
          marginTop: 10,

          borderBottomColor: '#E2E2E2',
          borderBottomWidth: 1,
        }}
      />
    </View>
  );
};
const Bottom = () => {
  return (
    <View
      style={{
        width: '85%',
        height: 50,
        backgroundColor: '#F78A3A',
        borderRadius: 5,
        alignSelf: 'center',
        justifyContent: 'center',
        marginBottom: 10,
      }}>
      <Text
        style={{
          color: 'white',
          fontSize: 17,
          textAlign: 'center',
          fontWeight: 'bold',
        }}>
        Register
      </Text>
    </View>
  );
};
const CardItem = (item) => {
  var header_View = (
    <TouchableOpacity style={{height: 50, justifyContent: 'center'}} onPress={()=>{}}>
      <Text
        style={{
          fontSize: 15,
          color: 'rgba(0, 0, 0, 1)',
          textAlign: 'center',
          lineHeight: 20,
        }}>
        {item.title}
      </Text>
    </TouchableOpacity>
  );

  return header_View;
};
export default class Membership extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    return (
      <SafeAreaView style={{flex: 1}}>
        <View
          style={{height: '30%', backgroundColor: 'rgba(10, 135, 138, 1)'}}
        />
        <View
          style={{
            width: '100%',
            position: 'absolute',
            justifyContent: 'center',
          }}>
          <Card
            style={{
              flexDirection: 'row',
              elevation: 15,
              marginStart: 16,
              marginEnd: 16,
              marginTop:50,
              borderRadius: 10,
            }}>
            <Header />
            <FlatList
              style={{marginBottom: 10, height: '55%'}}
              data={FlatListItems}
              renderItem={({item}) => CardItem(item)}
              ItemSeparatorComponent={() => (
                <View
                  style={{
                    height: 1,

                    borderBottomColor: '#E2E2E2',
                    borderBottomWidth: 1,
                  }}
                />
              )}
            />
            <Bottom />
          </Card>
        </View>
      </SafeAreaView>
    );
  }
}

const styles = StyleSheet.create({
  
});
