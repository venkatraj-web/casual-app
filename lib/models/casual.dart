import 'city.dart';

class Casual{
  int? id;
  String? casual_id;
  String? casual_name;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? casual_phone_no;
  int? cityId;
  String? date_of_birth;
  String? gender;
  String? id_proof;
  String? casual_avatar;
  String? role;
  int? identification_number;
  String? id_card_front_photo;
  String? id_card_back_photo;
  // String? qrCode;
  // String? emailVerifiedAt;
  String? remember_token;
  String? password_reset_token;
  String? password_reset_expires;
  String? created_user_id;
  String? modified_user_id;
  bool? active;
  String? createdAt;
  String? updatedAt;
  City? city;

  Casual({this.id, this.casual_id, this.casual_name, this.email, this.password, this.passwordConfirmation,
  this.casual_phone_no, this.cityId, this.date_of_birth, this.gender, this.id_proof, this.casual_avatar, this.role, this.identification_number,
  this.id_card_front_photo, this.id_card_back_photo, this.remember_token, this.password_reset_token, this.password_reset_expires, this.active,
  this.created_user_id, this.modified_user_id, this.createdAt, this.updatedAt, this.city});

  Casual.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    casual_id = json['casual_id'];
    casual_name = json['casual_name'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['passwordConfirmation'];
    casual_phone_no = json['casual_phone_no'];
    cityId = json['cityId'];
    date_of_birth = json['date_of_birth'];
    gender = json['gender'];
    id_proof = json['id_proof'];
    casual_avatar = json['casual_avatar'];
    role = json['role'];
    identification_number = json['identification_number'];
    id_card_front_photo = json['id_card_front_photo'];
    id_card_back_photo = json['id_card_back_photo'];
    remember_token = json['remember_token'];
    password_reset_token = json['password_reset_token'];
    password_reset_expires = json['password_reset_expires'];
    active = json['active'];
    created_user_id = json['created_user_id'];
    modified_user_id = json['modified_user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    city = json['city'] != null 
      ? new City.fromJson(json['city'])
      : null;
  }

  toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['casual_id'] = this.casual_id;
    data['casual_name'] = this.casual_name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['passwordConfirmation'] = this.passwordConfirmation;
    data['casual_phone_no'] = this.casual_phone_no;
    data['cityId'] = this.cityId;
    data['date_of_birth'] = this.date_of_birth;
    data['gender'] = this.gender;
    data['id_proof'] = this.id_proof;
    data['casual_avatar'] = this.casual_avatar;
    data['role'] = this.role;
    data['identification_number'] = this.identification_number;
    data['id_card_front_photo'] = this.id_card_front_photo;
    data['id_card_back_photo'] = this.id_card_back_photo;
    data['remember_token'] = this.remember_token;
    data['password_reset_token'] = this.password_reset_token;
    data['password_reset_expires'] = this.password_reset_expires;
    data['active'] = this.active;
    data['created_user_id'] = this.created_user_id;
    data['modified_user_id'] = this.modified_user_id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;

    if(this.city != null){
      data['city'] = this.city!.toJson();
    }

    return data;
  }

  getCasualDataWithNull(){
    Map<String, dynamic> casualDataWithNull = {
      'id' : null,
      'casual_id' : null,
      'casual_name' : null,
      'email' : null,
      'password' : null,
      'passwordConfirmation' : null,
      'casual_phone_no' : null,
      'cityId' : null,
      'date_of_birth' : null,
      'gender' : null,
      'id_proof' : null,
      'casual_avatar' : null,
      'role' : null,
      'identification_number' : null,
      'id_card_front_photo' : null,
      'id_card_back_photo' : null,
      'remember_token' : null,
      'password_reset_token' : null,
      'password_reset_expires' : null,
      'active' : null,
      'created_user_id' : null,
      'modified_user_id' : null,
      'createdAt' : null,
      'updatedAt' : null,
    };

    return casualDataWithNull;
  }

}