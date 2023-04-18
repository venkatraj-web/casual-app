class Manager{
  int? id;
  String? manager_id;
  String? manager_first_name;
  String? manager_last_name;
  String? email;
  String? manager_phone_no;
  String? date_of_birth;
  String? gender;
  String? manager_avatar;
  String? email_verified_at;
  String? password;
  String? role;
  String? created_user_id;
  String? modified_user_id;
  String? join_role;
  String? remember_token;
  String? password_reset_token;
  String? password_reset_expires;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? clientId;
  int? cityId;

  Manager({this.id, this.manager_id, this.manager_first_name, this.manager_last_name, this.email, this.manager_phone_no,
    this.date_of_birth, this.gender, this.manager_avatar, this.email_verified_at, this.password, this.role, this.created_user_id,
    this.modified_user_id, this.join_role, this.remember_token, this.password_reset_token, this.password_reset_expires, this.active,
    this.createdAt, this.updatedAt, this.clientId, this.cityId});

  Manager.fromJson(Map<String, dynamic> json){
    id = json['id'];
    manager_id = json['manager_id'];
    manager_first_name = json['manager_first_name'];
    manager_last_name = json['manager_last_name'];
    email = json['email'];
    manager_phone_no = json['manager_phone_no'];
    date_of_birth = json['date_of_birth'];
    gender = json['gender'];
    manager_avatar = json['manager_avatar'];
    email_verified_at = json['email_verified_at'];
    password = json['password'];
    role = json['role'];
    created_user_id = json['created_user_id'];
    modified_user_id = json['modified_user_id'];
    join_role = json['join_role'];
    remember_token = json['remember_token'];
    password_reset_token = json['password_reset_token'];
    password_reset_expires = json['password_reset_expires'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    clientId = json['clientId'];
    cityId = json['cityId'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manager_id'] = this.manager_id;
    data['manager_first_name'] = this.manager_first_name;
    data['manager_last_name'] = this.manager_last_name;
    data['email'] = this.email;
    data['manager_phone_no'] = this.manager_phone_no;
    data['date_of_birth'] = this.date_of_birth;
    data['gender'] = this.gender;
    data['manager_avatar'] = this.manager_avatar;
    data['email_verified_at'] = this.email_verified_at;
    data['password'] = this.password;
    data['role'] = this.role;
    data['created_user_id'] = this.created_user_id;
    data['modified_user_id'] = this.modified_user_id;
    data['join_role'] = this.join_role;
    data['remember_token'] = this.remember_token;
    data['password_reset_token'] = this.password_reset_token;
    data['password_reset_expires'] = this.password_reset_expires;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['clientId'] = this.clientId;
    data['cityId'] = this.cityId;
    return data;
  }

}