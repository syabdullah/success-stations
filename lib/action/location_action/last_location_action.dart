
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';
Future<http.Response> lastLocatin(id) async {
  await ApiHeaders().getData();
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}user-location/$id");
  final result =await http.get(url,headers: ApiHeaders().headersWithToken);  
  return result;
}