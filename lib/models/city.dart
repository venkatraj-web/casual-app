class City{

  int? id;
  String? city_name;
  bool? status;
  String? createAt;
  String? updatedAt;

  City({ this.id, this.city_name, this.status, this.createAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['id'];
    city_name = jsonData['city_name'];
    status = jsonData['status'];
    createAt = jsonData['createAt'];
    updatedAt = jsonData['updatedAt'];
  }

  toJson(){
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['city_name'] = this.city_name;
  data['status'] = this.status;
  data['createAt'] = this.createAt;
  data['updatedAt'] = this.updatedAt;

  return data;
  }
}