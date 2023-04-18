import 'package:casual/models/property/propertyGrade.dart';

class PropertyType{
  int? id;
  String? property_type;
  bool? status;
  String? createdAt;
  String? updatedAt;
  List<PropertyGrade>? property_grades;

  PropertyType({this.id, this.property_type, this.status, this.createdAt,
  this.updatedAt, this.property_grades});

  PropertyType.fromJson(Map<String, dynamic> json){
    id = json['id'];
    property_type = json['property_type'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if(json['property_grades'] != null){
      property_grades = <PropertyGrade>[];
      json['property_grades'].forEach((v) {
        property_grades!.add(new PropertyGrade.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_type'] = this.property_type;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    if(this.property_grades != null){
      data['property_grades'] = this.property_grades!.map((v) => v.toJson()).toList();
    }

    return data;
  }



}