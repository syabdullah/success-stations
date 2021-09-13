
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> countries() async {
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}countries");
  http.Response response = await http.get(url, headers: ApiHeaders().headers);
  return response;
}

Future<http.Response> regionGetByCountryID(id) async {
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}regions/$id");
  http.Response response = await http.get(url, headers: ApiHeaders().headers);
  return response;
}

Future<http.Response> cityGetByRegionID(id) async {
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}cities/$id");
  http.Response response = await http.get(url, headers: ApiHeaders().headers);
  return response;
}