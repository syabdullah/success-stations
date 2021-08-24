import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> createAdsFilteringAction(data) async {
  final Config conf = Config();
  print("....conf.!!!!!!!!......!!!!!.....$conf");
  var url = Uri.parse("${conf.baseUrl}offers-filter");
  print("..url...!!!!...!!!!.....1111......$url");
  final result = await http.post(url,
      body: json.encode(data), headers: ApiHeaders().headersWithToken);
  print("........@@@@@@@@....222.........222........$result");
  return result;
}
