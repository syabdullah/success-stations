import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
Future<http.Response>  adwithusAction(data) async {
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}advertise-us");
  http.Response response = await http.post(url, body:jsonEncode(data),headers: ApiHeaders().headersWithToken);
  return response;
}