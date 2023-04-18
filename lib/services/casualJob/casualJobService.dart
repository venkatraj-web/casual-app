import 'dart:io';

import 'package:casual/exceptions/app_exception.dart';
import 'package:casual/exceptions/exception_handlers.dart';
import 'package:casual/repositories/repository.dart';

class CasualJobService{
  Repository? _repository;
  ExceptionHandlers? _exceptionHandlers;
  var responsedJson;
  CasualJobService(){
    _repository = Repository();
    _exceptionHandlers = ExceptionHandlers();
  }

  getJobs() async{
    try {
      var response =await _repository!.httpGet("casual-job/all");
      responsedJson = await _exceptionHandlers!.returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }on Exception catch (e) {
      throw e;
    }
    return responsedJson;
  }

  getCasualJobsByPropertyId(int? propertyId) async{
    try {
      var response = await _repository!.httpGetById("casual-job/list-by-property", propertyId);
      responsedJson = _exceptionHandlers!.returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    } on Exception catch (e) {
      throw e;
    }
    return responsedJson;
  }


}