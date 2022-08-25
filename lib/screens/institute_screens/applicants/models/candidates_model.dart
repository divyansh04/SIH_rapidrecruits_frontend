import 'personal_details.dart';
import 'qualification_details.dart';
import 'experience_details.dart';

class CandidatesModel {
  CandidatesModel(
      {this.personaldetails,
      this.qualificationdetails,
      this.experiencedetails,
      this.status});

  CandidatesModel.fromJson(dynamic json) {
    personaldetails = json['personal details'] != null
        ? PersonalDetails.fromJson(json['personal details'])
        : null;
    if (json['qualification details'] != null) {
      qualificationdetails = [];
      json['qualification details'].forEach((v) {
        qualificationdetails?.add(QualificationDetails.fromJson(v));
      });
    }
    if (json['experience details'] != null) {
      experiencedetails = [];
      json['experience details'].forEach((v) {
        experiencedetails?.add(ExperienceDetails.fromJson(v));
      });
    }
    status = json['status'];
  }
  PersonalDetails? personaldetails;
  List<QualificationDetails>? qualificationdetails;
  List<ExperienceDetails>? experiencedetails;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (personaldetails != null) {
      map['personal details'] = personaldetails?.toJson();
    }
    if (qualificationdetails != null) {
      map['qualification details'] =
          qualificationdetails?.map((v) => v.toJson()).toList();
    }
    if (experiencedetails != null) {
      map['experience details'] =
          experiencedetails?.map((v) => v.toJson()).toList();
    }
    map['status'] = status;
    return map;
  }
}
