 import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
 
Future<http.Response> adDeleting(dataa) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}delete-ad/$dataa");
  final result = await http.post(url,headers: ApiHeaders().headersWithToken,body: json.encode(dataa));  
  
  return result;
  
}
