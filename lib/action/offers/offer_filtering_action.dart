import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';


Future<http.Response> offerFilteringAction(dataa) async {
  await ApiHeaders().getData();
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}offers-filter");
  final result = await http.post(url,body: json.encode(dataa),headers: ApiHeaders().headersWithToken );
  return result;
}
