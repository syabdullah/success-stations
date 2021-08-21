import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> storeAddOffer(dataa) async {
  print("adddddddddd offferrrrrrrr jsooonnn encodeeeee");
  print("adddddddddd offferrrrrrrr jsooonnn encodeeeee$dataa");
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}offers");
  print("url prinyed of the story.....................>>>>>>$url");
  http.Response response = await http.post(url, body: json.encode(dataa), headers: ApiHeaders().headersWithToken);
  return response;
}

