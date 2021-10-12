import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

//adds havings adds
Future<http.Response> basedAddById(id,uId) async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url = uId == null ? Uri.parse("${config.baseUrl}ads/category/$id?country=$countryIDD") :  Uri.parse("${config.baseUrl}ads/category/$id/$uId?country=$countryIDD");
  print("all adds category .....$url");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}