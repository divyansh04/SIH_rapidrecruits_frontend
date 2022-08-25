class ApplicantDetails {
  String? username;
  String? email;
  String? profilePic;
  String? description;
  String? fullName;
  String? dOB;
  String? gender;
  String? address;
  String? state;
  int? pincode;
  String? category;
  bool? maritalStatus;
  int? phoneNumber;
  double? totalExperience;
  List<String>? skillset;
  String? resume;

  ApplicantDetails(
      {this.username,
      this.email,
      this.profilePic,
      this.description,
      this.fullName,
      this.dOB,
      this.gender,
      this.address,
      this.state,
      this.pincode,
      this.category,
      this.maritalStatus,
      this.phoneNumber,
      this.totalExperience,
      this.skillset,
      this.resume});

  ApplicantDetails.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    profilePic = json['profile_pic'];
    description = json['description'];
    fullName = json['full_name'];
    dOB = json['DOB'];
    gender = json['gender'];
    address = json['address'];
    state = json['state'];
    pincode = json['pincode'];
    category = json['category'];
    maritalStatus = json['marital_status'];
    phoneNumber = json['phone_number'];
    totalExperience = json['total_experience'];
    skillset = json['skillset'].cast<String>();
    resume = json['resume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['profile_pic'] = profilePic;
    data['description'] = description;
    data['full_name'] = fullName;
    data['DOB'] = dOB;
    data['gender'] = gender;
    data['address'] = address;
    data['state'] = state;
    data['pincode'] = pincode;
    data['category'] = category;
    data['marital_status'] = maritalStatus;
    data['phone_number'] = phoneNumber;
    data['total_experience'] = totalExperience;
    data['skillset'] = skillset;
    data['resume'] = resume;
    return data;
  }
}
