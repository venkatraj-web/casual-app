import 'package:casual/models/casualJob/casualJob.dart';
import 'package:casual/models/city.dart';
import 'package:casual/models/client/client.dart';
import 'package:casual/models/manager/manager.dart';
import 'package:casual/models/property/propertyGrade.dart';
import 'package:casual/models/property/propertyType.dart';

class Property{
  int? id;
  String? property_id;
  String? property_name;
  String? property_avatar;
  String? address;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? cityId;
  int? clientId;
  int? propertyTypeId;
  int? propertyGradeId;
  City? city;
  Client? client;
  PropertyType? propertyType;
  PropertyGrade? propertyGrade;
  List<CasualJob>? casual_jobs;
  List<Manager>? managers;


  Property({this.id, this.property_id, this.property_name, this.property_avatar,
  this.address, this.active, this.createdAt, this.updatedAt, this.cityId, this.clientId,
  this.propertyTypeId, this.propertyGradeId, this.city, this.client, this.propertyType,
  this.propertyGrade, this.casual_jobs, this.managers});

  Property.fromJson(Map<String, dynamic> json){
    id = json['id'];
    property_id = json['property_id'];
    property_name = json['property_name'];
    property_avatar = json['property_avatar'];
    address = json['address'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cityId = json['cityId'];
    clientId = json['clientId'];
    propertyTypeId = json['propertyTypeId'];
    propertyGradeId = json['propertyGradeId'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    client = json['client'] != null ? new Client.fromJson(json['client']) : null;
    propertyType = json['property_type'] != null ? new PropertyType.fromJson(json['property_type']) : null;
    propertyGrade = json['property_grade'] != null ? new PropertyGrade.fromJson(json['property_grade']) : null;
    if(json['casual_jobs'] != null){
      casual_jobs = <CasualJob>[];
      json['casual_jobs'].forEach((v){
        casual_jobs!.add(new CasualJob.fromJson(v));
      });
    }
    if(json['managers'] != null){
      managers = <Manager>[];
      json['managers'].forEach((v){
        managers!.add(Manager.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['property_id'] = this.property_id;
    data['property_name'] = this.property_name;
    data['property_avatar'] = this.property_avatar;
    data['address'] = this.address;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cityId'] = this.cityId;
    data['clientId'] = this.clientId;
    data['propertyTypeId'] = this.propertyTypeId;
    data['propertyGradeId'] = this.propertyGradeId;
    if(this.city != null){
      data['city'] = this.city!.toJson();
    }
    if(this.client != null){
      data['client'] = this.client!.toJson();
    }
    if(this.propertyType != null){
      data['city'] = this.propertyType!.toJson();
    }
    if(this.propertyGrade != null){
      data['client'] = this.propertyGrade!.toJson();
    }

    if(this.casual_jobs != null){
      data['casual_jobs'] = this.casual_jobs!.map((v) => v.toJson()).toList();
    }

    if(this.managers != null){
      data['managers'] = this.managers!.map((v) => v.toJson()).toList();
    }

    return data;
  }

}