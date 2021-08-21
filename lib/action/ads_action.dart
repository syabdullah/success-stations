

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> createAdsAction(data) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}all-ads");
  final result = await http.post(
    url,body: jsonEncode(data),headers: ApiHeaders().headers);
    return result;
}

Future<http.Response> getUserAds(id) async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}friend-profile-ads/$id");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}
Future<http.Response> addAdsFav(id) async {
  print("...........add to favorite adds.....>$id");
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}add-to-favorites-ads");
  http.Response response = await http.post(url, body: jsonEncode(id), headers: ApiHeaders().headersWithToken);
  return response;
}
Future<http.Response> removeAdsFav(id) async {
  print("......removeAdsFav........removeAdsFav.......removeAdsFav....$id");
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}remove-from-favorites");
  http.Response response = await http.post(url, body: jsonEncode(id), headers: ApiHeaders().headersWithToken);
  return response;
}
