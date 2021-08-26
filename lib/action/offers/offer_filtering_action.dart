import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
GetStorage box = GetStorage();
Future<http.Response> offerFilteringAction(data) async {
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}offers-filter");
  final result = await http.post(url,headers: ApiHeaders().headersWithToken,
      body: json.encode(data));
      return result;
  }
  var id=box.read('offerID');
Future<http.Response> offerGetFilteringAction(id) async {
  print("..........offer idddddd.....$id");
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}offers-filter/$id");
  print('.....offerGetFilteringAction...$url');
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}