import React from "react";
import * as RNLocalize from 'react-native-localize';
import {translate} from "./../util/TranslationUtils";

import {
  View,
  Text,
  StyleSheet,
  Image,
  TouchableWithoutFeedback,
  Keyboard,SafeAreaView,
} from "react-native";
import ButtonView from "../../components/ButtonView";

export default class RecoveredPassword extends React.Component {

  static navigationOptions = ({ navigation, navigationOptions }) => {
    return {
        title: '',
    };
  };

  constructor(props) {
    super(props);
  }

  componentDidMount() {
  }

  componentWillUnmount() {
  }

  render() {
    return (
      <SafeAreaView style={{flex: 1}}>
      <TouchableWithoutFeedback
        onPress={() => {
          Keyboard.dismiss();
        }}
      >
        <View style={styles.containerView}>
        <View style={styles.cireleStyle}>
            <Image  style={{alignContent:"center"}}
          source={require('../../assets/tick.png')}/>
          </View>
          <View>
            <Text style={styles.recoveredPasswordTextStyle}>{this.props.navigation.state.params.forgot_password ? translate('password_recovered'): translate('password_created')}</Text>
          </View>
          <View>
            <Text style={styles.secondaryTextStyle}>
            {this.props.navigation.state.params.forgot_password ? translate('password_recovered_desc'): translate('password_created_desc')}
            </Text>
          </View>
          <View style={{ height: 50,marginTop:20, width: 320, alignSelf: "center"}}>
            <ButtonView
              clickEvent={() => {
                  this.props.navigation.navigate('login')
              }} name={translate('sign_in_title')}
            />
          </View>
        </View>
      </TouchableWithoutFeedback>
      </SafeAreaView>
    );
  }
};

const styles = StyleSheet.create({
  containerView: {
    backgroundColor: "#F2F2F2",
    flex: 1,
    justifyContent: "center",
  },
  cireleStyle :{
    width: 110,
    height: 110,
    alignContent:"center",
    alignSelf:"center",
    justifyContent:"center",
    alignItems:"center",
    borderRadius: 110 / 2,
     borderColor: "#0A878A",
    borderWidth: 5
  },
  recoveredPasswordTextStyle: {
    textAlignVertical: "center",
    fontSize: 22,
    fontWeight: "400",
    fontFamily: "DMSans-Regular",
    marginTop:20,
    color: "#0B0B0B",
    alignSelf: "center",
  },
  secondaryTextStyle: {
    textAlignVertical: "center",
    fontSize: 12,
    fontWeight: "400",
    fontFamily: "DMSans-Regular",
    color: "#4A4A4A",
    alignSelf: "center",
    marginTop:14,
  },
});