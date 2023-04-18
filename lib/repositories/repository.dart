import 'dart:io';

import 'package:casual/models/casual.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

class Repository{

  String _baseUrl = "http://www.qikcasual.com/api";
  // String _baseUrl = "http://192.168.1.8:3006/api";

  String formater(String url){
    return _baseUrl + "/" + url;
  }

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

  Future httpGetById(String api,paramId) async{
    return await http.get(Uri.parse(_baseUrl + "/" + api + "/" + paramId.toString()), headers: await getHeaders());
  }

  Future<dynamic> httpPost(String api, data) async {
    // print("email last = ${data}");
    return await http.post(Uri.parse(_baseUrl + "/" + api), body: data, headers:await getHeaders());
  }

  Future<dynamic> httpPostFormData(String api, List<dynamic> images,Casual data) async{
    // print(images);
    var request = await http.MultipartRequest("POST", Uri.parse(_baseUrl + "/" + api));
    // request.files.add(await http.MultipartFile.fromPath("casual_avatar", data, contentType: new MediaType("image", 'jpg')));
    List<http.MultipartFile> newList = [];
    request.headers.addAll({
      "Content-type" : "multipart/form-data",
    });
    // for(File file in images){
    //   print(file);
    //   var f = await http.MultipartFile.fromPath("casual_avatar", file.path, contentType: new MediaType("image", "jpg"));
    //   newList.add(f);
    // }
    for(var file in images){
      // print(file.runtimeType);
      File image = file['file'];
      // print(image);
      var f = await http.MultipartFile.fromPath(file['name'], image.path, contentType: new MediaType("image", "jpg"));
      newList.add(f);
    }
    // print(data.cityId != null ? data.cityId.toString() : null.toString() );
    // print(data.cityId.toString() );
    request.fields['casual_first_name'] = data.casual_first_name!;
    request.fields['casual_last_name'] = data.casual_last_name!;
    request.fields['email'] = data.email!;
    request.fields['casual_phone_no'] = data.casual_phone_no!;
    request.fields['cityId'] = data.cityId != null ? data.cityId.toString() : null.toString();
    request.fields['password'] = data.password!;
    request.fields['passwordConfirmation'] = data.passwordConfirmation!;
    request.fields['thaiNationalId'] = data.thaiNationalId!;
    request.fields['date_of_birth'] = data.date_of_birth!;
    request.files.addAll(newList);
    var streamedResponse = await request.send();
    // print("streamedResponse");
    // print(streamedResponse.stream);
    var response = await http.Response.fromStream(streamedResponse);
    print("response");
    print(response.body);
    return response;
  }

}