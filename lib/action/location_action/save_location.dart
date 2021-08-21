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