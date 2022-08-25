class PersonalDetails {
  PersonalDetails({
      this.username, 
      this.email, 
      this.id, 
      this.userId, 
      this.profilePic, 
      this.description, 
      this.fullName, 
      this.dob, 
      this.gender, 
      this.address, 
      this.state, 
      this.pincode, 
      this.category, 
      this.maritalStatus, 
      this.phoneNumber, 
      this.totalExperience, 
      this.resume,
    this.skillSet
  });

  PersonalDetails.fromJson(dynamic json) {
    username = json['username'];
    email = json['email'];
    id = json['id'];
    userId = json['user_id'];
    profilePic = json['profile_pic'];
    description = json['description'];
    fullName = json['full_name'];
    dob = json['DOB'];
    gender = json['gender'];
    address = json['address'];
    state = json['state'];
    pincode = json['pincode'];
    category = json['category'];
    maritalStatus = json['marital_status'];
    phoneNumber = json['phone_number'];
    totalExperience = json['total_experience'];
    resume = json['resume'];
    skillSet=json['skillset'] != null ? json['skillset'].cast<String>() : [];
  }
  String? username;
  String? email;
  int? id;
  int? userId;
  String? profilePic;
  String? description;
  String? fullName;
  String? dob;
  String? gender;
  String? address;
  String? state;
  int? pincode;
  String? category;
  bool? maritalStatus;
  int? phoneNumber;
  double? totalExperience;
  String? resume;
  List<String>? skillSet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['id'] = id;
    map['user_id'] = userId;
    map['profile_pic'] = profilePic;
    map['description'] = description;
    map['full_name'] = fullName;
    map['DOB'] = dob;
    map['gender'] = gender;
    map['address'] = address;
    map['state'] = state;
    map['pincode'] = pincode;
    map['category'] = category;
    map['marital_status'] = maritalStatus;
    map['phone_number'] = phoneNumber;
    map['total_experience'] = totalExperience;
    map['resume'] = resume;
    map['skillset']=skillSet;
    return map;
  }

}