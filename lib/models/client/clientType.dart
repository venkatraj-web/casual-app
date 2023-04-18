class ClientType{
  int? id;
  String? client_type;
  bool? status;
  String? createdAt;
  String? updatedAt;

  ClientType({this.id, this.client_type, this.status, this.createdAt, this.updatedAt});
  
  ClientType.fromJson(Map<String, dynamic> json){
    id = json['id'];
    client_type = json['client_type'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  
  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_type'] = this.client_type;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

}