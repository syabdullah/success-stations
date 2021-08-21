
import 'package:get_storage/get_storage.dart';

String? token;
class ApiHeaders {

  getData() {
    GetStorage box =  GetStorage(); 
    token = box.read('access_token');
  } 

   var headers = {
    "Content-Type": "application/json;charset=UTF-8",
    "accept": "application/json",   
  };

  var headersWithToken = {
     "Content-Type": "application/json;charset=UTF-8",
    "accept": "application/json",  
    'authorization' : 'Bearer $token'
  };
}