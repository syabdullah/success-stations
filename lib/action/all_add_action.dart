import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> addsCateg() async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}ads?change_language=ar");
  print(".......URl of the category.........$url");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}