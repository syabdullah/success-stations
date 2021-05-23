import axios from 'axios'
import { LOGOUT } from '../redux/ReduxConstants';
import AsyncStorage from '@react-native-community/async-storage'

const client = axios.create({
  baseURL: 'http://eshgksa.com/success_station/api/v1/',
  headers: {'content-type':'application/json'}
});


export const interceptor = (store) => {
  client.interceptors.response.use(
    async (response) => {
      return response;
    },
    async (error) => {
      console.log('hhhh',error)
      if(error.response.status === 401){
        console.log("invalid refresh token");
        console.log(error.response)
        store.dispatch({
          type:LOGOUT,
          isLogout : true
        });
        AsyncStorage.removeItem('userdata')
        
      }
      return error.response;
    }
  )
};

/**
 * Request Wrapper with default success/error actions
 */
const request = function(options) {
  const onSuccess = function(response) {
   
    return response.data;
  }

  const onError = function(error) {
    if (error.response) {
      // Request was made but server responded with something
      // other than 2xx
      console.error('Status:',  error.response.status);
      console.error('Data:',    error.response.data);
      console.error('Headers:', error.response.headers);

    } else {
      // Something else happened while setting up the request
      // triggered the error
      console.error('Error Message:', error.message);
    }

    return Promise.reject(error.response || error.message);
  }
console.log(options)
  return client(options)
            .then(onSuccess)
            .catch(onError);
}
function get(endpoint,params) {
    return request({
      url:    endpoint,
      method: 'GET',
      params: params
    });
  }
  
function post(endPoint, postData) {
 
    return request({
      url:    endPoint,
      method: 'POST',
      data:   postData
    });
  }

  function setToken(token) {
      console.log(token)
      if (token) {
        client.defaults.headers.common['Authorization'] = `Bearer ${token}`;
       } else {
        delete client.defaults.headers.common['Authorization'];
       } 
  
   }
  
  const ApiService = {
    get, post,setToken
  }
  
  export default ApiService;