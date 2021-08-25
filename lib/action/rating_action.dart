 import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

GetStorage box = GetStorage();
Future<http.Response> adRating(dataa) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}rating");
  final result = await http.post(url,headers: ApiHeaders().headersWithToken,body: json.encode(dataa));  
  return result;
  
}

var id=box.read('ratingID');
Future<http.Response> getRating(id) async {
  print("..........rating idddddd.....$id");
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}rating/$id");
  print('   my      $url');
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}