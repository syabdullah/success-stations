import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
Future<http.Response> userOffers(id) async {
  await ApiHeaders().getData();
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}offers/user/$id");
  final result =await http.get(url,headers: ApiHeaders().headersWithToken);  
  return result;
}