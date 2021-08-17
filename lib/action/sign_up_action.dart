import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> createAccount(data) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}register");
  final result = await http.post(
    url,body: jsonEncode(data),headers: ApiHeaders().headers);
    return result;
}


Future<http.Response> individualUser(data) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}individual-register");
  final result = await http.post(
    url,body: jsonEncode(data),headers: ApiHeaders().headers);
    return result;
}

Future<http.Response> companyUser(data) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}company-register");
  final result = await http.post(
    url,body: jsonEncode(data),headers: ApiHeaders().headers);
    return result;
}