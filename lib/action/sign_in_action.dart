 import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> login(dataa) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}login");
  final result = await http.post(url,headers: ApiHeaders().headers,body: json.encode(dataa));  
  return result;
}
