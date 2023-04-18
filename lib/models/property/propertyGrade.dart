class PropertyGrade{
  int? id;
  String? property_grade;
  bool? status;
  String? createdAt;
  String? updatedAt;
  int? propertyTypeId;


  PropertyGrade({this.id, this.property_grade, this.status, this.createdAt,
  this.updatedAt, this.propertyTypeId});

  PropertyGrade.fromJson(Map<String, dynamic> json){
    id = json['id'];
    property_grade = json['property_grade'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    propertyTypeId = json['propertyTypeId'];
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['property_grade'] = this.property_grade;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['propertyTypeId'] = this.propertyTypeId;
    return data;
  }

}