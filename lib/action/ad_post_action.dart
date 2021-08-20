 import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> adPosting(dataa) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}all-ads");
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
