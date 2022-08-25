class InstituteDetails {
  InstituteDetails({
      this.username, 
      this.email, 
      this.empid, 
      this.location, 
      this.website, 
      this.directorMail, 
      this.registrarMail, 
      this.hodMail,});

  InstituteDetails.fromJson(dynamic json) {
    username = json['username'];
    email = json['email'];
    empid = json['empid'];
    location = json['location'];
    website = json['website'];
    directorMail = json['director_mail'];
    registrarMail = json['registrar_mail'];
    hodMail = json['hod_mail'];
  }
  String? username;
  String? email;
  int? empid;
  String? location;
  String? website;
  String? directorMail;
  String? registrarMail;
  String? hodMail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['email'] = email;
    map['empid'] = empid;
    map['location'] = location;
    map['website'] = website;
    map['director_mail'] = directorMail;
    map['registrar_mail'] = registrarMail;
    map['hod_mail'] = hodMail;
    return map;
  }

}