

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:success_stations/utils/app_headers.dart';
import 'package:success_stations/utils/config.dart';

Future<http.Response> createconvo(data) async{
  final Config conf = Config();
  await ApiHeaders().getData();
  var url = Uri.parse("${conf.baseUrl}chats/$data");
  final result = await http.post(
    url,headers: ApiHeaders().headersWithToken);
    return result;
}

Future<http.Response> getconvo(data,page) async{
  await ApiHeaders().getData();
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}chats/$data/messages/?page=$page");
  final result = await http.get(
    url,headers: ApiHeaders().headersWithToken);
    return result;
}

Future<http.Response> getAllChats() async{
  await ApiHeaders().getData();
  final Config conf = Config();
  var url = Uri.parse("${conf.baseUrl}chats/my?page=1");
  final result = await http.get(
    url,headers: ApiHeaders().headersWithToken);
  return result;
}

Future<http.Response> readMessage(data) async{
  final Config conf = Config();
  await ApiHeaders().getData();
  var url = Uri.parse("${conf.baseUrl}read-message");
  final result = await http.post(
    url,body: jsonEncode(data),headers: ApiHeaders().headersWithToken);
    return result;
}