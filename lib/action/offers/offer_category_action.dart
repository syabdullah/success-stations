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
  // var url = uId == null ? Uri.parse("${config.baseUrl}offers/$id") :  Uri.parse("${config.baseUrl}offers/$id/$uId");
  var url =  Uri.parse("${config.baseUrl}offers/$id");
  print("url of the beased api .....offerrrr Category...........>>>>>$url");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}