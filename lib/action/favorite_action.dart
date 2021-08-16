import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> favorite() async {
  await ApiHeaders().getData();
  final Config config = Config();
  print("jkdhkjdhkjdhhj....!!!!!!! $config");
  var url = Uri.parse("${config.baseUrl}favorite-list");
  print("url printed of the friend list ........$url");
  http.Response response = await http.get(url, headers: ApiHeaders().headers);
  print(",d.sdm.s,dmlkdjlkjdkljekl$response");
  return response;
}