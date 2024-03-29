import 'dart:io';

import 'package:casual/exceptions/app_exception.dart';
import 'package:casual/exceptions/exception_handlers.dart';
import 'package:casual/repositories/repository.dart';

class CasualPropertyService{

  Repository? _repository;
  ExceptionHandlers? _exceptionHandlers;
  var responsedJson;

  CasualPropertyService(){
    _repository = Repository();
    _exceptionHandlers = ExceptionHandlers();
  }


  getProperties() async{
    try {
      var response = await _repository!.httpGet('property/all');
      responsedJson = _exceptionHandlers!.returnResponse(response);
    } on SocketException{
      throw FetchDataException("No Internet Connection");
    } on Exception catch (e) {
      throw e;
    }
    return responsedJson;
  }



}