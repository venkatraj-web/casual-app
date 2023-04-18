import 'package:casual/models/city.dart';
import 'package:casual/models/client/clientType.dart';
import 'package:casual/models/manager/manager.dart';

class Client{
  int? id;
  String? client_id;
  String? client_name;
  String? client_phone_no;
  String? client_avatar;
  int? no_of_properties;
  String? address;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? cityId;
  int? clientTypeId;
  City? city;
  ClientType? clientType;
  List<Manager>? managers;

  Client({this.id, this.client_id, this.client_name, this.client_phone_no, this.client_avatar,
    this.no_of_properties, this.address, this.active, this.createdAt, this.updatedAt,this.cityId,
    this.clientTypeId, this.city, this.clientType, this.managers});

  Client.fromJson(Map<String, dynamic> json){
    id = json['id'];
    client_id = json['client_id'];
    client_name = json['client_name'];
    client_phone_no = json['client_phone_no'];
    client_avatar = json['client_avatar'];
    no_of_properties = json['no_of_properties'];
    address = json['address'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cityId = json['cityId'];
    clientTypeId = json['clientTypeId'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    clientType = json['client_type'] != null ? 
        new ClientType.fromJson(json['client_type']): null;
    if(json['managers'] != null){
      managers = <Manager>[];
      json['managers'].forEach((v) {
        managers!.add(new Manager.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.client_id;
    data['client_name'] = this.client_name;
    data['client_phone_no'] = this.client_phone_no;
    data['client_avatar'] = this.client_avatar;
    data['no_of_properties'] = this.no_of_properties;
    data['address'] = this.address;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cityId'] = this.cityId;
    data['clientTypeId'] = this.clientTypeId;
    if(this.city != null){
      data['city'] = this.city!.toJson();
    }
    if(this.clientType != null){
      data['client_type'] = this.clientType!.toJson();
    }
    if(this.managers != null){
      data['managers'] = this.managers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}