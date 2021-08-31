 import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
 
Future<http.Response> adPosting(dataa) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}ads");
  final result = await http.post(url,headers: ApiHeaders().headersWithToken,body: json.encode(dataa));  
  
  return result;
  
}

Future<http.Response> commentPosting(data) async{
  print("pi actionalkdnasdklnaskdl    ---------  $data");
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}comments");
  final result = await http.post(url,body: json.encode(data),headers: ApiHeaders().headersWithToken,);  
  
  return result;
  
}
Future<http.Response> editAdPosting(dataa,adID) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}edit-ads/$adID");
  final result = await http.post(url,headers: ApiHeaders().headersWithToken,body: json.encode(dataa));  
  
  return result;
  
}
Future<http.Response> adActive(dataa) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}active/$dataa/active");
  final result = await http.get(url,headers: ApiHeaders().headersWithToken,);  
  
  return result;
  
}
Future<http.Response> adDeActive(dataa) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}active/$dataa/de-active");
  final result = await http.get(url,headers: ApiHeaders().headersWithToken,);  
  
  return result;
  
}