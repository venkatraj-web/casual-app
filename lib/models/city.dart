class City{

  int? id;
  String? cityName;
  bool? status;
  String? createAt;
  String? updatedAt;

  City({ this.id, this.cityName, this.status, this.createAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['id'];
    cityName = jsonData['city_name'];
    status = jsonData['status'];
    createAt = jsonData['createAt'];
    updatedAt = jsonData['updatedAt'];
  }

  toJson(){
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['cityName'] = this.cityName;
  data['status'] = this.status;
  data['createAt'] = this.createAt;
  data['updatedAt'] = this.updatedAt;

  return data;
  }
}