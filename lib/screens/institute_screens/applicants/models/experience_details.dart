class ExperienceDetails {
  ExperienceDetails({
      this.designation, 
      this.fromDate, 
      this.toDate, 
      this.institute, 
      this.details,});

  ExperienceDetails.fromJson(dynamic json) {
    designation = json['designation'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    institute = json['institute'];
    details = json['details'];
  }
  String? designation;
  String? fromDate;
  String? toDate;
  String? institute;
  String? details;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['designation'] = designation;
    map['from_date'] = fromDate;
    map['to_date'] = toDate;
    map['institute'] = institute;
    map['details'] = details;
    return map;
  }

}