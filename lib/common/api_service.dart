import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';

import 'config.dart';

class ApiService{
  static header(){
    // config.basicAuth();
    return {
      'Authorization': Config.basicAuth(),
      'Content-Type': 'application/json'
    };
  }

  static void put( String path , params, Function callback) async{
    var request = Request('PUT', Uri.parse('https://${Config.host}/$path'));
    request.body = json.encode(params);
    request.headers.addAll(header());
    StreamedResponse response = await request.send();
    callback(response);
  }

  static void patch( String path , params, Function callback) async{
    var request = Request('PATCH', Uri.parse('https://${Config.host}/$path'));
    request.body = json.encode(params);
    request.headers.addAll(header());
    StreamedResponse response = await request.send();
    callback(response);
  }

  static void delete( String path, Function callback) async{
    var request = Request('DELETE', Uri.parse('https://${Config.host}/$path'));
    request.headers.addAll(header());
    var response = await request.send();
    callback(response);
  }

  static void get( String path, Function callback) async{
    var request = Request('GET', Uri.parse('https://${Config.host}/$path'));
    request.headers.addAll(header());
    var response = await request.send();
    callback(response);
  }

}