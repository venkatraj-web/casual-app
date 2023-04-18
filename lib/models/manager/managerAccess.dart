class ManagerAccess{
  int? id;
  String? created_user_id;
  String? modified_user_id;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? propertyId;
  int? managerId;

  ManagerAccess({this.id, this.created_user_id, this.modified_user_id,
  this.active, this.createdAt, this.updatedAt, this.propertyId, this.managerId});

  ManagerAccess.fromJson(Map<String, dynamic> json){
    id = json['id'];
    created_user_id = json['created_user_id'];
    modified_user_id = json['modified_user_id'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    propertyId = json['propertyId'];
    managerId = json['managerId'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_user_id'] = this.created_user_id;
    data['modified_user_id'] = this.modified_user_id;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['propertyId'] = this.propertyId;
    data['managerId'] = this.managerId;
    return data;
  }

}