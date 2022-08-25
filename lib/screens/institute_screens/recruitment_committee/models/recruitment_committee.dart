class RecruitmentCommittee {
  RecruitmentCommittee({
      this.id, 
      this.empid, 
      this.name, 
      this.designation, 
      this.department,});

  RecruitmentCommittee.fromJson(dynamic json) {
    id = json['id'];
    empid = json['empid'];
    name = json['name'];
    designation = json['designation'];
    department = json['department'];
  }
  int? id;
  String? empid;
  String? name;
  String? designation;
  String? department;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['empid'] = empid;
    map['name'] = name;
    map['designation'] = designation;
    map['department'] = department;
    return map;
  }

}