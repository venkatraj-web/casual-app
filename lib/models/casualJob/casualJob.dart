import 'package:casual/models/city.dart';
import 'package:casual/models/client/client.dart';
import 'package:casual/models/property/property.dart';

class CasualJob{
  int? id;
  String? casual_job_id;
  String? job_title;
  int? no_of_casuals;
  String? outlet_name;
  String? reporting_person;
  String? designation;
  String? event_type;
  String? start_date;
  String? end_date;
  String? shift_time_start;
  String? shift_time_end;
  String? payment_type;
  int? amount;
  String? job_description;
  String? message_for_casual;
  // List<String>? things_to_bring;
  String? things_to_bring;
  String? created_user_id;
  String? modified_user_id;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? cityId;
  int? propertyId;
  int? clientId;
  City? city;
  Property? property;
  Client? client;

  CasualJob({this.id, this.casual_job_id, this.job_title, this.no_of_casuals, this.outlet_name,
  this.reporting_person, this.designation, this.event_type, this.start_date, this.end_date, this.shift_time_start,
  this.shift_time_end, this.payment_type, this.amount, this.job_description, this.message_for_casual,
  this.things_to_bring, this.created_user_id, this.modified_user_id, this.active, this.createdAt,
  this.updatedAt, this.cityId, this.propertyId, this.clientId, this.city, this.property, this.client});

  CasualJob.fromJson(Map<String, dynamic> json){
    id = json['id'];
    casual_job_id = json['casual_job_id'];
    job_title = json['job_title'];
    no_of_casuals = json['no_of_casuals'];
    outlet_name = json['outlet_name'];
    reporting_person = json['reporting_person'];
    designation = json['designation'];
    event_type = json['event_type'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    shift_time_start = json['shift_time_start'];
    shift_time_end = json['shift_time_end'];
    payment_type = json['payment_type'];
    amount = json['amount'];
    job_description = json['job_description'];
    message_for_casual = json['message_for_casual'];
    // things_to_bring = json['things_to_bring'].cast<String>();
    things_to_bring = json['things_to_bring'].toString();
    created_user_id = json['created_user_id'];
    modified_user_id = json['modified_user_id'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    cityId = json['cityId'];
    propertyId = json['propertyId'];
    clientId = json['clientId'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    property = json['property'] != null ? new Property.fromJson(json['property']) : null;
    client = json['client'] != null ? new Client.fromJson(json['client']) : null;
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['casual_job_id'] = this.casual_job_id;
    data['job_title'] = this.job_title;
    data['no_of_casuals'] = this.no_of_casuals;
    data['outlet_name'] = this.outlet_name;
    data['reporting_person'] = this.reporting_person;
    data['designation'] = this.designation;
    data['event_type'] = this.event_type;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['shift_time_start'] = this.shift_time_start;
    data['shift_time_end'] = this.shift_time_end;
    data['payment_type'] = this.payment_type;
    data['amount'] = this.amount;
    data['job_description'] = this.job_description;
    data['message_for_casual'] = this.message_for_casual;
    data['things_to_bring'] = this.things_to_bring;
    data['created_user_id'] = this.created_user_id;
    data['modified_user_id'] = this.modified_user_id;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['cityId'] = this.cityId;
    data['propertyId'] = this.propertyId;
    data['clientId'] = this.clientId;
    if(this.city != null){
      data['city'] = this.city!.toJson();
    }
    if(this.property != null){
      data['property']= this.property!.toJson();
    }
    if(this.client != null){
      data['client'] = this.client!.toJson();
    }
    return data;
  }


}