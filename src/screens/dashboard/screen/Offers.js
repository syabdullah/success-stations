// React Navigate Drawer with Bottom Tab
// https://aboutreact.com/bottom-tab-view-inside-navigation-drawer/
import * as React from 'react';
import {
  Button,
  View,
  Text,
  Dimensions,
  SafeAreaView,
  FlatList,
  Image,
  StyleSheet,
  TouchableOpacity,
  TouchableWithoutFeedback,
} from 'react-native';

import {Searchbar, DefaultTheme, Card} from 'react-native-paper';
import {translate} from '../../../util/TranslationUtils';
import DynamicTabView from 'react-native-dynamic-tab-view';
import ApiService from '../../../network/ApiService';
import Loader from '../../Loader';
import _ from 'lodash';

const ITEM_WIDTH = Dimensions.get('window').width;





const BookCard = ({book, ...props}) => {

  return (
    <TouchableOpacity>
      <View  >
        <Image
        
          source={{uri:book.image_ads.url}}
          style={{
            
            marginLeft:10,
            marginTop:10,
            marginRight: 10,
            borderColor: '#00000030',
            borderWidth: 1,
            borderRadius: 4,
            height: 150,
          }}
        />
      </View>
    </TouchableOpacity>
  );
};





export default class OffersScreen extends React.Component {
  static navigationOptions = {
    header: null,
    options: {},
  };

  getCategories = ()=> {
    this.setState({isLoading: true});
    ApiService.get('ads-categories')
      .then((response) => {
      
        var tempArray = []
        tempArray.push({
          key: 0,
          title :translate('all')
        })
        for (var key in response.data) {
         var temp = {
            key: response.data[key].id,
            title : response.data[key].category_name
          }
          tempArray.push(temp)
      } 

        this.categoryData = tempArray
        this.getAllBanners()
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data);
      });
  }
  
  getAllBanners = (searchdata = "") =>{
    let path = 'all-ads'
    if(searchdata!= ""){
        path += searchdata
    }
    this.setState({isLoading: true});
    ApiService.get(path)
      .then((response) => {
       this.bannersData = response.data
       this.setState({isLoading: false});
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data);
      });
  }

  getBannersByCategory = (categoryId) =>{
    this.setState({isLoading: true});
    if (categoryId > 0) {
      ApiService.get(`all-ads?category=${categoryId}`)
      .then((response) => {
       this.bannersData = response.data
       this.setState({isLoading: false});
      })
      .catch((error) => {
        this.setState({isLoading: false});
        alert(error.data);
      });
    } else {
      this.getAllBanners();
    }
    
  }

  constructor(props) {
    super(props);
    this.onChangeTextDelayed = _.debounce(this.onChangeText, 1000);
    this.state = {
       isLoading: false,
      index: 0,
    
    };
    this.categoryData =[]
    this.bannersData =[]

  }
  _renderItem = (item, index) => {
   
    return (
      <View key={item['id']} style={{backgroundColor: item['color'],}} />
    );
  };
  
  onChangeTab = (index) => {
    this.getBannersByCategory(this.categoryData[index].key)
  };

  onChangeText = (text) => {
    this.getAllBanners(`?search=${text}`)
  }

  componentDidMount() {
    this.getCategories()
  }
  componentWillUnmount() {}

  render() {
   
    return (
      <SafeAreaView style={{flex: 1, backgroundColor: 'white'}}>
        <View style={{flex: 1}}>
          <View
            style={{
              fontSize: 25,
              textAlign: 'center',
              marginBottom: 16,
            }}>
            <View
              style={{
                height: 60,
                width: '100%',
                backgroundColor: 'rgba(10, 135, 138, 1)',
              }}>
              <Searchbar 
                style={{marginStart: 10, marginEnd: 10, fontStyle: "DMSans-Regular", fontSize:15}}
                placeholder={translate('search_offer')}
                onChangeText={this.onChangeTextDelayed}
                icon={() => (
                  <Image source={require('./../../../../assets/search.png')} />
                )}
              />
            </View>
            <View style={{width: "100%", height: 60}}>
            <DynamicTabView
            data={this.categoryData}
            renderTab={() => {
            <View
            style={{flex: 1, height: 1 }}
          />
        }}
        
            defaultIndex={this.state.defaultIndex}
            containerStyle={styles.container2}
            headerBackgroundColor={'white'}
            headerTextStyle={styles.headerText}
            onChangeTab={this.onChangeTab}
            headerUnderlayColor={'#F78A3A'}
          
          />
            </View>
            <FlatList
              style={{width: '100%',marginBottom:120}}
              keyExtractor={(item) => item.id}
              data={this.bannersData}
              renderItem={({item}) => <BookCard book={item} {...this.props} />}
            />
          </View>
        </View>
        {this.state.isLoading ?   <Loader
                loading={this.state.loading} /> :null}
      </SafeAreaView>
    );
  }
}
const styles = StyleSheet.create({
  mainView: {
    width: '100%',
    height: 35,
    borderRadius: 4,
    backgroundColor: '#FFFFFF',
    alignSelf: 'center',
    justifyContent: 'center',
    alignItems: 'stretch',
    borderColor: '#F78A3A',
    borderWidth: 1,
  },
  buttonStyle: {
    color: '#F78A3A',
    fontSize: 17,
    fontWeight: '700',
    textAlign: 'center',
  },
  container: {
    backgroundColor: 'white',

    borderRadius: 8,
    width: ITEM_WIDTH,
    height: 150,
    paddingBottom: 40,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 3,
    },
    shadowOpacity: 0.29,
    shadowRadius: 4.65,
    elevation: 0,
  },
  image: {
    width: ITEM_WIDTH,
    padding: 8,
    aspectRatio: 16 / 9,
  },
  container2: {

  },
  headerContainer: {
    marginTop: 16,
  },
  header: {
    color: 'white',
    fontSize: 18,
    fontWeight: 'bold',
    paddingLeft: 10,
    paddingTop: 20,
    shadowColor: 'black',
  },
  body: {
    color: 'white',
    fontSize: 15,

    padding: 10,
    marginEnd: 10,
  },
  headerText: {
    color: 'black',
    fontSize: 15,
    fontWeight: '400',
    fontStyle: 'normal',
  },
  tabItemContainer: {
    backgroundColor: '#cf6bab',
  },
});
