class UserModel {
  int id;
  String name;
  String email;
  String phoneNo;
  String picture;
  String description;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phoneNo,
      this.picture,
      this.description});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    picture = json['picture'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['picture'] = this.picture;
    data['description'] = this.description;
    return data;
  }
}
