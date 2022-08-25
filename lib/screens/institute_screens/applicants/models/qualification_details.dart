class QualificationDetails {
  QualificationDetails({
      this.qualificationTitle, 
      this.institute, 
      this.passingYear, 
      this.marks,});

  QualificationDetails.fromJson(dynamic json) {
    qualificationTitle = json['qualification_title'];
    institute = json['institute'];
    passingYear = json['passing_year'];
    marks = json['marks'];
  }
  String? qualificationTitle;
  String? institute;
  String? passingYear;
  double? marks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['qualification_title'] = qualificationTitle;
    map['institute'] = institute;
    map['passing_year'] = passingYear;
    map['marks'] = marks;
    return map;
  }

}