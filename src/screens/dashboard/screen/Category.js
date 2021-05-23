import * as React from 'react';
import {
  View,
  Text,
  SafeAreaView,
  TouchableOpacity,
  Image,
  StyleSheet,
  FlatList,
  Dimensions,
} from 'react-native';
import RBSheet from 'react-native-raw-bottom-sheet';
import DynamicTabView from 'react-native-dynamic-tab-view';
import {Card, Paragraph, Searchbar} from 'react-native-paper';
import CheckBox from '@react-native-community/checkbox';
import {
  cardFollower,
  cardLocation,
  filter,
} from './../../../util/ImageConstant';
import {translate} from '../../../util/TranslationUtils';
import MultiSlider from '@ptomasroos/react-native-multi-slider';
import ApiService from '../../../network/ApiService';
import Loader from '../../Loader';
import _ from 'lodash';




const CardItem = ({item,refreshCallBack,...props}) => {
  var city = item.city.city != null ? item.city.city+", ": ""
  var region = item.region.region != null ? item.region.region+", ": ""
  var country = item.country.name != null ? item.country.name: ""
  var fullAddress = `${city+region+country}`
  var imageURL = item.image != null && item.image.length > 0 ? item.image[0].url: "";
  var header_View = (
    <TouchableOpacity style={{flex: 1}} onPress= {()=>{
    
    props.navigation.navigate('BookDetailScreen', { data: { bookId: item.id, callBack: ()=> {
      refreshCallBack()
    }} }) 
  }
    }>
      <Card style={{margin: 7, elevation: 5}} >
        <View style={{flexDirection: 'column', justifyContent: 'center'}}>
          <Image style={styles.cardImageItem} source={{uri: imageURL}} />
          <View style={{flexDirection: 'column', marginStart: 10}}>
            <Text
              style={{
                fontSize: 15,
                color: 'rgba(0, 0, 0, 1)',
                lineHeight: 20,
              }}>
              {item.title}
            </Text>

            <Text style={{color: '#0A878A', fontSize: 15, marginTop: 11, fontFamily: "DMSans-Regular"}}>
              SR {item.price}
            </Text>
            <View
              style={{
                flexDirection: 'column',
                justifyContent: 'center',
                justifyContent: 'space-evenly',
                marginTop: 12,
                marginBottom: 11,
              }}>
              <View style={{flexDirection: 'row'}}>
                <Image style={{width: 11, height: 12}} source={cardLocation} />
                <Text
                  style={{
                    fontSize: 10,
                    color: 'rgba(0, 0, 0, 0.6)',
                    marginStart: 5,
                    marginEnd: 5,
                    fontFamily: "DMSans-Regular"
                  }}>
                  {fullAddress}
                </Text>
              </View>
              <View style={{flexDirection: 'row'}}>
                <Image style={{width: 11, height: 12}} source={cardFollower} />
                <Text
                  style={{
                    fontSize: 10,
                    color: 'rgba(0, 0, 0, 0.6)',
                    marginStart: 5,
                    fontFamily: "DMSans-Regular"
                  }}>
                  {item.contact_name}
                </Text>
              </View>
            </View>
          </View>
          {item.if_favorite == true? (
          <View style={{right: 5, top: 5, position: "absolute", borderRadius: 11, width: 22, height: 22, backgroundColor: "#ffffff", justifyContent: 'center'}}>
              <Image 
                style={{width: 11, height: 11, alignSelf: "center"}}
                source={ require('../../../../assets/heart.png') }
              />
          </View>
          ): null}
        </View>
      </Card>
    </TouchableOpacity>
  );

  return header_View;
};
export default class StudentProfile extends React.Component {
  constructor(props) {
    super(props);
    this.onChangeTextDelayed = _.debounce(this.onChangeText, 1000);
    this.state = {
     
      index: 0,
      books: [],
      categories: [],
      isLoading: false,
      types: [],
      searchText:props.route != null && props.route.params != null && props.route.params.searchText != null ? props.route.params.searchText: "",
      oldType : false,
      newType :false,
      multiSliderValue: [1, 500],
      key:1,
      selectedCategoryId: props.route.params.selectedTab,
      selectedTabIndex: props.route.params.selectedTab
    };
   
    this.range =''
  
  }
  onChangeTab = (index) => {
    this.getBooksByCategory(this.state.categories[index].key)
  };

  onChangeText = (text) => {
    this.setState({searchText:text})
    setTimeout( () => {
      this.getBooks(`?search=${text}`)
   },1000);
    
  }

  getAddType= () =>{
    ApiService.get('listing-types')
      .then((response) => {
        this.setState({types: response.data}) 
        let  data = this.state.types
        for( i in data){
          data[i].selected = false
        }
        this.setState({types: data}) 
       
      })
      .catch((error) => {
      });
  }

  getBookCategories = () => {
    this.setState({isLoading: true});
    ApiService.get('listing-categories')
      .then((response) => {
        var tempArray = []
        tempArray.push({
          key: 0,
          title : translate('all')
        })
        for (var key in response.data) {
         var temp = {
            key: response.data[key].id,
            title : response.data[key].category
          }
          tempArray.push(temp)
        }
        this.setState({categories: tempArray})
        var searchString = ""
        if (this.state.searchText != null && this.state.searchText != "") {
          searchString = "?search="+ this.state.searchText
          this.getBooks(searchString);
        } else if (this.state.selectedCategoryId > 0) {
          this.getBooksByCategory(this.state.selectedCategoryId)
        }
        
      })
      .catch((error) => {
        this.setState({isLoading: false});
      });
  }

  getBooks = (searchData = "") => {
    var path = 'listings'
    if (searchData != "") {
      path += searchData
    }
    ApiService.get(path)
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({books: response.data})
      })
      .catch((error) => {
        this.setState({isLoading: false});
      });
  }

  filterBooks = (filter) => {
    this.setState({isLoading: true});
    return
    var path = 'listings'+filter
    ApiService.get(path)
      .then((response) => {
        this.setState({isLoading: false});
        this.setState({books: response.data})
      })
      .catch((error) => {
        this.setState({isLoading: false});
      });
  }

  getBooksByCategory = (id) => {

    if (id > 0) {
      this.setState({isLoading: true});
      ApiService.get(`listings?category=${id}`)
      .then((response) => {

        this.setState({books: response.data, isLoading: false})
      })
      .catch((error) => {
      });
    } else {
      var searchString = ""
      if (this.searchText != null && this.searchText != "") {
        searchString = "?search="+ this.searchText
      }
      this.getBooks(searchString)
    }
  }
 
  componentDidMount() {
    this.getAddType()
    this.getBookCategories();
  }
 
  render() {
    return (
      <SafeAreaView style={{flex: 1,backgroundColor:'white'}}>
        <View
          style={{backgroundColor: 'rgba(10, 135, 138, 1)', paddingBottom: 28}}>
          <Searchbar
            style={{marginStart:10,marginEnd:10, fontStyle: "DMSans-Regular", fontSize:15}}
            placeholder={translate('search_book')}
            onChangeText={(value)=>{
        
              this.onChangeText(value)

            }}
            icon={() => (
              <Image source={require('./../../../../assets/search.png')} />
            )}
            style={{fontStyle: "DMSans-Regular", fontSize:15}}
            value={this.state.searchText}
          />
        </View>
        <View style={{flexDirection: 'row', margin: 7, height: 30}}>
          <Text
            style={{
              flex: 1,
              alignSelf: 'flex-start',
              textAlignVertical: 'center',
              height: 30,
              fontSize: 18,
            }}>
            {translate('book_list')}
          </Text>
          <View style={{flex: 1, alignItems: 'flex-end'}}>
            <TouchableOpacity
              style={{
                backgroundColor: '#F78A3A',
                flexDirection: 'row',
                borderRadius: 4,
                width: 84,
                justifyContent: 'center',
                height: 30,
              }}
              onPress={() => {
                this.Standard.open();
              }}>
              <Image
                style={{alignSelf: 'center', marginRight: 10}}
                source={filter}
              />
              <Text
                style={{
                  color: 'white',
                  fontSize: 15,
                  textAlignVertical: 'center',
                  marginTop: 5
                }}>
                {translate('filter')}
              </Text>
            </TouchableOpacity>
          </View>
        </View>
        <View style={{width: "100%", height: 60}}>
            <DynamicTabView
            data={this.state.categories}
            renderTab={() => <View
            style={{flex: 1, height: 1 }}
          />}
        
            defaultIndex={this.state.selectedTabIndex}
            containerStyle={styles.container2}
            headerBackgroundColor={'white'}
            headerTextStyle={styles.headerText}
            onChangeTab={this.onChangeTab}
            headerUnderlayColor={'#F78A3A'}
          
          />
            </View>
        <FlatList
          style={{marginTop:10,marginBottom:10}}
          data={this.state.books}
          renderItem={({item}) => <CardItem 
                                  item = {item}
                                  refreshCallBack = { () =>{
                                      this.getBooks()
                                  }

                                  }
                                  {...this.props}/>} 
          numColumns={2}
        />
        <RBSheet
          ref={(ref) => {
            this.Standard = ref;
          }}
          height={400}
          customStyles={{
            container: {
              borderTopLeftRadius: 20,
              borderTopRightRadius: 20,
            },
          }}
          >
          <View style={{flex: 1, margin: 16,}}>
            <View
              style={{
                flexDirection: 'row',
           
               
        
              }}>
              <View  style={{
                flex:1,
                flexDirection: 'row',
                justifyContent:'space-between'
               
        
              }}>
                  <TouchableOpacity style={{padding: 0}} onPress={()=>{
                       const newArray = [...this.state.types];
                       for( i in newArray){
                       newArray[i].selected = false;
                       }
                       this.setState({ types: newArray,newType:false,oldType:false,key:this.state.key+1});
                       this.range =''
                  }}>
              <Text style={{color: 'black'}}>{translate('reset')}</Text>
              </TouchableOpacity>
              <Text >{translate('filter')}</Text>
              <TouchableOpacity style={{padding: 0}} onPress={()=>{
              var data = this.state.types
              var arrTypes = []
              var arrCondition = []
              var queryString = "?"
              for(i in data){
                  if(data[i].selected){
                    arrTypes.push(data[i].id)
                  }
              }

              queryString += `range=${this.state.multiSliderValue[0]}-${this.state.multiSliderValue[1]}`

              if (this.state.newType != '') {
                arrCondition.push("new")
              }

              if (this.state.oldType != '') {
                arrCondition.push("old")
              }

              if (arrCondition.length > 0) {
                queryString += `&condition=${arrCondition.join(",")}`
              }

              if (arrTypes.length > 0) {
                queryString += `&type=${arrTypes.join(",")}`
              }
              //this.Standard.close();
              this.filterBooks(queryString)
              }}>
                <Text style={{color: '#F78A3A'}}>{translate('done')}</Text>
              </TouchableOpacity>
              </View>
            </View>
            <View
              style={{
                height: 1,
                marginTop: 16,
                backgroundColor: '#EAECEF',
                width: '100%',

              }}></View>
            <Text style={{fontSize: 21, marginTop: 13}}>
              {translate('type')}
            </Text>
            <FlatList style={{}}
              data={this.state.types}
              renderItem={({item,index}) => <View
              style={{ flexDirection:'row', marginBottom: 10,
              }}>
              <CheckBox    
                value={this.state.types[index].selected}
                onValueChange={(newValue) => {
                  const newArray = [...this.state.types];
                  newArray[index].selected = newValue;
                  this.setState({ types: newArray });
                }
              }
                
                />
                
              <Text style={styles.checkBoxHeading}>{item.type}</Text>
            </View>} 
              numColumns={1}
            />
            
            <Text style={{fontSize: 21}}>
              {translate('condition')}
            </Text>

            <View
              style={{
                flexDirection: 'row',
                marginBottom: 10
               
              }}>
              <CheckBox
                  value= {this.state.newType}
                 onValueChange={(newValue) => {
                  this.setState({newType:newValue})
                  
                  }
                  
                 }
              />
              <Text style={styles.checkBoxHeading}>{translate('new')}</Text>
            </View>
            <View
              style={{
                flexDirection: 'row',
              
              }}>
              <CheckBox
                  value= {this.state.oldType}
                 onValueChange={(newValue) => {
                   this.setState({oldType:newValue})
           
                }  
              }
              />
              <Text style={styles.checkBoxHeading}>{translate('old')}</Text>
            </View>

            <Text style={{fontSize: 21, marginTop: 13}}>
              {translate('price')}
            </Text>
            <View
              style={{
               
              }} key = {this.state.key}>
               
             <MultiSlider
          values={this.state.multiSliderValue}
          sliderLength={Dimensions.get('window').width-40}
          onValuesChange={(i)=>{this.range = i}}
          min={this.state.multiSliderValue[0]}
          max={this.state.multiSliderValue[1]}
          step={1}
          isMarkersSeparated={true}
          customMarkerLeft={(e) => {
            return (<View style={{marginTop:20}}>
              <View style= {{width:20,height:20,borderRadius:10,backgroundColor: 'rgba(10, 135, 138, 1)'}}/>
              <Text style={{textAlign:'center'}}>{e.currentValue}</Text></View>)
             
       }}
   
       customMarkerRight={(e) => {
            return  (<View style={{marginTop:20}}>
              <View style= {{width:20,height:20,borderRadius:10,backgroundColor: 'rgba(10, 135, 138, 1)'}}/>
              <Text style={{textAlign:'center'}}>{e.currentValue}</Text></View>)
       }}
          allowOverlap
          snapped
        
        />
        </View>
            </View>
      
         
        </RBSheet>
        {this.state.isLoading ?   <Loader
                loading={this.state.loading} /> :null}
      </SafeAreaView>
    );
  }
}

const styles = StyleSheet.create({
  image: {
    width: 60,
    height: 60,
    borderRadius: 60 / 2,
    overflow: 'hidden',
  },
  parent: {
    height: '65%',
    width: '100%',
    transform: [{scaleX: 2}],
    borderBottomStartRadius: 200,
    borderBottomEndRadius: 200,
    overflow: 'hidden',
    backgroundColor: '#0A878A',
  },
  child: {
    flex: 1,
    transform: [{scaleX: 0.5}],

    backgroundColor: '#0A878A',
    alignItems: 'center',
    justifyContent: 'center',
  },
  MainContainer: {
    justifyContent: 'center',
    flex: 1,
    paddingTop: Platform.OS === 'iOS' ? 20 : 0,
  },

  FlatList_Item: {
    padding: 10,
    fontSize: 18,
    height: 44,
  },

  header_footer_style: {
    width: '100%',
    height: 44,
    backgroundColor: '#4CAF50',
    alignItems: 'center',
    justifyContent: 'center',
  },

  textStyle: {
    textAlign: 'center',
    color: '#fff',
    fontSize: 21,
  },
  countTextStye: {
    color: '#151522',
    fontSize: 17,
    fontWeight: 'bold',
    textAlign: 'center',
  },
  titleCountTextStye: {
    color: '#666666',
    fontSize: 13,
    textAlign: 'center',
  },
  cardImageItem: {
    width: 'auto',
    height: 'auto',
    aspectRatio: 16 / 9,
  },
  container2: {

  },
  headerContainer: {
    marginTop: 16,
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
  checkBoxHeading: {
    textAlignVertical:'center', marginLeft: 5, fontFamily: "DMSans-Regular"
  }
});
