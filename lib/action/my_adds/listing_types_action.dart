import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> listingTypesAdds() async {
  await ApiHeaders().getData();
  final Config config = Config();
  var url = Uri.parse("${config.baseUrl}ads-types");
  print("listing to add type in $url");
  http.Response response = await http.get(url, headers: ApiHeaders().headersWithToken);
  return response;
}