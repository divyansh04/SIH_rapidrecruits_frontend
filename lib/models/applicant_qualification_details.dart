class ApplicantQualificationDetailsModel {
  List<QualificationData>? data;

  ApplicantQualificationDetailsModel({this.data});

  ApplicantQualificationDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <QualificationData>[];
      json['data'].forEach((v) {
        data!.add(QualificationData.fromJson(v));
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

class QualificationData {
  String? qualificationTitle;
  String? institute;
  String? passingYear;
  double? marks;

  QualificationData({this.qualificationTitle, this.institute, this.passingYear, this.marks});

  QualificationData.fromJson(Map<String, dynamic> json) {
    qualificationTitle = json['qualification_title'];
    institute = json['institute'];
    passingYear = json['passing_year'];
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qualification_title'] = qualificationTitle;
    data['institute'] = institute;
    data['passing_year'] = passingYear;
    data['marks'] = marks;
    return data;
  }
}
