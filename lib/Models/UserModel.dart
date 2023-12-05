class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? photo;
  String? mobile;

  UserModel({this.email, this.firstName, this.lastName, this.photo, this.mobile});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    photo = json['photo'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['photo'] = photo;
    data['mobile'] = mobile;
    return data;
  }
}