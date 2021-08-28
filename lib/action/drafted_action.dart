import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> draftAdsAction() async {
 var id;
  GetStorage box = GetStorage();
  id  = box.read('user_id');
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}my-ads/draft");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}


Future<http.Response> draftAdsPublished(id) async {

  GetStorage box = GetStorage();
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}publish-ad/$id");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}