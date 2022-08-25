class EmployeeModel {
  EmployeeModel({
    this.id,
    this.collegeId,
    this.name,
    this.dob,
    this.gender,
    this.category,
    this.status,
    this.email,
    this.phoneNumber,
    this.empId,
    this.department,
    this.designation,
  });

  EmployeeModel.fromJson(dynamic json) {
    id = json['id'];
    collegeId = json['college_id'];
    name = json['name'];
    dob = json['DOB'];
    gender = json['gender'];
    category = json['category'];
    status = json['status'];
    empId = json['empid'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    designation = json['designation'];
    department = json['department'];
  }
  int? id;
  int? collegeId;
  String? name;
  String? dob;
  String? gender;
  String? category;
  String? status;
  String? empId;
  String? email;
  int? phoneNumber;
  String? designation;
  String? department;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['college_id'] = collegeId;
    map['name'] = name;
    map['DOB'] = dob;
    map['gender'] = gender;
    map['category'] = category;
    map['status'] = status;
    map['empid'] = empId;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['designation'] = designation;
    map['department'] = department;

    return map;
  }
}
