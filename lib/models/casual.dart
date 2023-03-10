import 'city.dart';

class Casual{
  int? id;
  String? casualId;
  String? casualName;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? casualPhoneNo;
  int? cityId;
  String? dateOfBirth;
  String? gender;
  String? idProof;
  String? casualAvatar;
  String? role;
  int? identificationNumber;
  String? idCardFrontPhoto;
  String? idCardBackPhoto;
  // String? qrCode;
  // String? emailVerifiedAt;
  String? rememberToken;
  String? passwordResetToken;
  String? passwordResetExpires;
  String? createdUserId;
  String? modifiedUserId;
  bool? active;
  String? createdAt;
  String? updatedAt;
  City? city;

  Casual({this.id, this.casualId, this.casualName, this.email, this.password, this.passwordConfirmation,
  this.casualPhoneNo, this.cityId, this.dateOfBirth, this.gender, this.idProof, this.casualAvatar, this.role, this.identificationNumber,
  this.idCardFrontPhoto, this.idCardBackPhoto, this.rememberToken, this.passwordResetToken, this.passwordResetExpires, this.active,
  this.createdUserId, this.modifiedUserId, this.createdAt, this.updatedAt, this.city});

  Casual.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    casualId = json['casual_!d'];
    casualName = json['casual_name'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['passwordConfirmation'];
    casualPhoneNo = json['casual_phone_no'];
    cityId = json['cityId'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    idProof = json['id_proof'];
    casualAvatar = json['casual_avatar'];
    role = json['role'];
    identificationNumber = json['identification_number'];
    idCardFrontPhoto = json['id_card_front_photo'];
    idCardBackPhoto = json['id_card_back_photo'];
    rememberToken = json['remember_token'];
    passwordResetToken = json['password_reset_token'];
    passwordResetExpires = json['password_reset_expires'];
    active = json['active'];
    createdUserId = json['created_user_id'];
    modifiedUserId = json['modified_user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    city = json['city'] != null 
      ? new City.fromJson(json['city'])
      : null;
  }

  toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['casualId'] = this.casualId;
    data['casualName'] = this.casualName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['passwordConfirmation'] = this.passwordConfirmation;
    data['casualPhoneNo'] = this.casualPhoneNo;
    data['cityId'] = this.cityId;
    data['dateOfBirth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['idProof'] = this.idProof;
    data['casualAvatar'] = this.casualAvatar;
    data['role'] = this.role;
    data['identificationNumber'] = this.identificationNumber;
    data['idCardFrontPhoto'] = this.idCardFrontPhoto;
    data['idCardBackPhoto'] = this.idCardBackPhoto;
    data['rememberToken'] = this.rememberToken;
    data['passwordResetToken'] = this.passwordResetToken;
    data['passwordResetExpires'] = this.passwordResetExpires;
    data['active'] = this.active;
    data['createdUserId'] = this.createdUserId;
    data['modifiedUserId'] = this.modifiedUserId;
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
      'casualId' : null,
      'casualName' : null,
      'email' : null,
      'password' : null,
      'passwordConfirmation' : null,
      'casualPhoneNo' : null,
      'cityId' : null,
      'dateOfBirth' : null,
      'gender' : null,
      'idProof' : null,
      'casualAvatar' : null,
      'role' : null,
      'identificationNumber' : null,
      'idCardFrontPhoto' : null,
      'idCardBackPhoto' : null,
      'rememberToken' : null,
      'passwordResetToken' : null,
      'passwordResetExpires' : null,
      'active' : null,
      'createdUserId' : null,
      'modifiedUserId' : null,
      'createdAt' : null,
      'updatedAt' : null,
    };

    return casualDataWithNull;
  }

}