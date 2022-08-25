class ApplicantExperienceDetailsModel {
  List<ExperienceData>? data;

  ApplicantExperienceDetailsModel({this.data});

  ApplicantExperienceDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ExperienceData>[];
      json['data'].forEach((v) {
        data!.add(ExperienceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExperienceData {
  String? designation;
  String? fromDate;
  String? toDate;
  String? institute;
  String? details;

  ExperienceData(
      {this.designation,
      this.fromDate,
      this.toDate,
      this.institute,
      this.details});

  ExperienceData.fromJson(Map<String, dynamic> json) {
    designation = json['designation'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    institute = json['institute'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['designation'] = designation;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['institute'] = institute;
    data['details'] = details;
    return data;
  }
}
