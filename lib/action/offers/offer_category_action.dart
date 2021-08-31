import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> offersCategory() async {
  await ApiHeaders().getData();
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}offers-categories");
  final result =await http.get(url,headers: ApiHeaders().headersWithToken);  
  return result;
}
Future<http.Response> offersCategoryById(id) async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url =  Uri.parse("${config.baseUrl}category-offer/$id");
  print("url of the beased api .....offerrrr Category...........>>>>>$url");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}


Future<http.Response>editOffers(id, data) async {
  await ApiHeaders().getData();
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}edit-offers/$id");
  final result = await http.post(url,body: json.encode(data),headers: ApiHeaders().headersWithToken );
  return result;
}

