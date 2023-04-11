

import 'dart:convert';
import 'dart:io';

import 'package:casual/exceptions/app_exception.dart';
import 'package:casual/exceptions/exception_handlers.dart';
import 'package:casual/repositories/repository.dart';

import '../models/casual.dart';

class CasualService {
  Repository? _repository;
  ExceptionHandlers? exceptionHandlers;

  CasualService(){
    _repository = Repository();
    exceptionHandlers = ExceptionHandlers();
  }

  Future<dynamic> getLogin(Casual data) async{
    var responsedJson;
    // print("email = ${data.email}");
    try {
      var response = await _repository!.httpPost("casual/login", jsonEncode(data.toJson()));
      // print(response.statusCode);
      responsedJson = exceptionHandlers?.returnResponse(response);
      print("getLogin");
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on Exception catch (e) {
      print(e);
      throw e;
    }
    return await responsedJson;
  }

  Future<dynamic> getCasualProfile() async {
    var responsedJson;
    try {
      var response = await _repository!.httpGet("casual/profile");
      // print(response.body);
      responsedJson = exceptionHandlers!.returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on Exception catch (e) {
      throw e;
    }
    return await responsedJson;
  }

  Future<dynamic> registerCasual(List<dynamic> images, Casual data) async{
    var responsedJson;

    try {
      var response = await _repository!.httpPostFormData("casual/store", images, data);
      responsedJson = exceptionHandlers!.returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on Exception catch (e) {
      print(e);
      throw e;
    }
    return responsedJson;
  }

  Future getCities() async{
    var responsedJson;
    try {
      var response = await _repository!.httpGet('city/allCities');
      responsedJson = exceptionHandlers!.returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    on Exception catch (e) {
      throw e;
    }
    return await responsedJson;
  }

}