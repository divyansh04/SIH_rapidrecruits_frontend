
class VacancyModel {
  VacancyModel(
      {this.id,
      this.collegeId,
      this.title,
      this.type,
      this.experience,
      this.dateOfPosting,
      this.state,
      this.description,
      this.responsibilities,
      this.qualifications,
      this.skills,
      this.compensation,
      this.collegeName,
      this.location,
      this.website,
      this.recruitmentCommittee});

  VacancyModel.fromJson(dynamic json) {
    id = json['id'];
    collegeId = json['college_id'];
    title = json['title'];
    type = json['type'];
    experience = json['experience'];
    dateOfPosting = json['date_of_posting'];
    state = json['state'];
    description = json['description'];
    responsibilities = json['responsibilities'];
    qualifications = json['qualifications'];
    skills = json['skills'] != null ? json['skills'].cast<String>() : [];
    compensation = json['compensation'];
    collegeName = json['college_name'];
    location = json['location'];
    website = json['website'];
    recruitmentCommittee = json['recruitment_committee'];
  }
  int? id;
  int? collegeId;
  String? title;
  String? type;
  String? experience;
  String? dateOfPosting;
  bool? state;
  String? description;
  String? responsibilities;
  String? qualifications;
  List<String>? skills;
  double? compensation;
  String? collegeName;
  String? location;
  String? website;
  bool? recruitmentCommittee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['college_id'] = collegeId;
    map['title'] = title;
    map['type'] = type;
    map['experience'] = experience;
    map['date_of_posting'] = dateOfPosting;
    map['state'] = state;
    map['description'] = description;
    map['responsibilities'] = responsibilities;
    map['qualifications'] = qualifications;
    map['skills'] = skills;
    map['compensation'] = compensation;
    map['college_name'] = collegeName;
    map['location'] = location;
    map['website'] = website;
    map['recruitment_committee'] = recruitmentCommittee;
    return map;
  }
}
