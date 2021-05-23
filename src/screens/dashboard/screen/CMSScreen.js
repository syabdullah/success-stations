import React, { useState } from 'react';
import {
    SafeAreaView,
    View,
    Text,
    ScrollView
 } from 'react-native'; 
import HTML from "react-native-render-html";
import ApiService from '../../../network/ApiService';
import Loader from '../../Loader';

export default class CMSScreen extends React.Component {

 
    getCMSPageContent = (page) => {
      
        this.setState({isLoading: true});
        var path = page
        ApiService.get(path)
          .then((response) => {
            this.props.navigation.setOptions({ title: response.data.title })
            this.setState({pageContent: response.data.page_text, pageHeading: response.data.title});
            this.setState({isLoading: false});
          })
          .catch((error) => {
            this.setState({isLoading: false});
            alert(error.data);
          });
      };

    constructor(props) {
        super(props);
        this.state = {
            pageContent: '',
            pageHeading: '',
            isLoading: false
        }
    }

    componentDidMount() {
        this.getCMSPageContent(this.props.route.params.cms)
    }

    render() {
        return (
                <SafeAreaView style={{flex: 1, backgroundColor: 'white'}}>
                    <View style={{flex: 1, backgroundColor: 'white'}}>
                    <ScrollView style={{ flex: 1, paddingLeft: 15}}>
                        <HTML source={{ html: this.state.pageContent }} />
                    </ScrollView>
                    </View>
                    {this.state.isLoading ?   <Loader
                loading={this.state.loading} /> :null}
                </SafeAreaView>)
    }
 }