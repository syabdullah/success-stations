import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future <http.Response> subCategory() async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}ads-categories?change_language=ar");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}

Future <http.Response> categoryTypes() async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}ads-categories-with-type");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}

Future <http.Response> havingAdds() async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}categories-having-ads");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}
Future <http.Response> myaddsHaving() async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}categories-my-ads");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}