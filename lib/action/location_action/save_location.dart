import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> saveLocation(data) async{
  print("PPPPPPPP-----$data");
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}locations");
  final result = await http.post(
    url,body: jsonEncode(data),headers: ApiHeaders().headersWithToken);
    return result;
}

Future<http.Response> editLocation(id,data) async{;
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}update-locations/$id");
  final result = await http.post(
    url,body:jsonEncode(data),headers: ApiHeaders().headersWithToken);
    return result;
}

Future<http.Response> deleteLocation(id) async{;
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}delete-locations/$id");
  final result = await http.post(
    url,headers: ApiHeaders().headersWithToken);
    return result;
} 
Future<http.Response> getMyLocation(id) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}locations/$id");
  final result = await http.get(
    url,headers: ApiHeaders().headersWithToken);
    return result;
}

Future<http.Response> getAllLocation() async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}locations");
  final result = await http.get(
    url,headers: ApiHeaders().headersWithToken);
    return result;
}