import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str)["data"].map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({this.id, this.uid, this.name, this.image, this.password, this.role});

  int? id;
  String? uid, name, image, password, role;

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      uid: json['uid'],
      name: json["name"],
      image: json['image'],
      password: json['password'],
      role: json['role']);

  Map<String, dynamic> toJson() => {
        "id": id,
        'uid': uid,
        "name": name,
        'image': image,
        'password': password,
        'role': role
      };
}
