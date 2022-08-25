class Vacancies {
  List<VacanciesData>? vacancies;

  Vacancies({this.vacancies});

  Vacancies.fromJson(Map<String, dynamic> json) {
    if (json['vacancies'] != null) {
      vacancies = <VacanciesData>[];
      json['vacancies'].forEach((v) {
        vacancies!.add(VacanciesData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.vacancies != null) {
      data['vacancies'] = this.vacancies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VacanciesData {
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
  int? compensation;
  String? collegeName;
  String? location;
  String? website;

  VacanciesData(
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
      this.website});

  VacanciesData.fromJson(Map<String, dynamic> json) {
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
    skills = json['skills'].cast<String>();
    compensation = json['compensation'];
    collegeName = json['college_name'];
    location = json['location'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['college_id'] = collegeId;
    data['title'] = title;
    data['type'] = type;
    data['experience'] = experience;
    data['date_of_posting'] = dateOfPosting;
    data['state'] = state;
    data['description'] = description;
    data['responsibilities'] = responsibilities;
    data['qualifications'] = qualifications;
    data['skills'] = skills;
    data['compensation'] = compensation;
    data['college_name'] = collegeName;
    data['location'] = location;
    data['website'] = website;
    return data;
  }
}
