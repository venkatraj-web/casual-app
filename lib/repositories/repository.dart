import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Repository{
  String _baseUrl = "http://192.168.1.7:3006/api";

  getHeaders() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    Map<String, String> headers = {
      "Content-type" : "application/json",
      "Accept" : "application/json",
      "Access-Control-Allow-Origin" : "*",
      "Authorization" : "Bearer $token"
    };
    return await headers;
  }

  Future httpGet(String api) async {
    return await http.get(Uri.parse(_baseUrl + "/" + api), headers: await getHeaders());
  }

  Future<dynamic> httpPost(String api, data) async {
    // print("email last = ${data}");
    return await http.post(Uri.parse(_baseUrl + "/" + api), body: data, headers:await getHeaders());
  }

}