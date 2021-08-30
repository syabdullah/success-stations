
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> userfav(id) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}user/favourite");
  final result = await http.post(url,headers: ApiHeaders().headersWithToken,body: json.encode(id));  
  return result;
}
Future<http.Response> remuserfav(id) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}user/un-favourite");
  final result = await http.post(url,headers: ApiHeaders().headersWithToken,body: json.encode(id));  
  return result;
}