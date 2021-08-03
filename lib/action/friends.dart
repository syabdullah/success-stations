

import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> allFriends(dataa) async{
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}friendships");
  final result = await http.get(url,headers: ApiHeaders().headers);  
  return result;
}