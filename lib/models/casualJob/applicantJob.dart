class ApplicantJob {
  int? id;
  String? applicant_job_id;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? casualId;
  int? casualJobId;

  ApplicantJob({this.id,
    this.applicant_job_id,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.casualId,
    this.casualJobId});

  ApplicantJob.fromJson(Map<String, dynamic> json){
    id = json['id'];
    applicant_job_id = json['applicant_job_id'];
    active = json['active'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    casualId = json['casualId'];
    casualJobId = json['casualJobId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicant_job_id'] = this.applicant_job_id;
    data['active'] = this.active;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['casualId'] = this.casualId;
    data['casualJobId'] = this.casualJobId;
    return data;
  }


}