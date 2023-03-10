import 'dart:convert';

List<Student> studentFromJson(String str) =>
    List<Student>.from(json.decode(str).map((x) => Student.fromJson(x)));

String studentToJson(List<Student> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Student {
  Student(
      {required this.aridNo,
      required this.name,
      required this.image,
      required this.password,
      this.isSelected});

  String aridNo;
  String name;
  String image;
  String password;
  bool? isSelected;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
      aridNo: json["aridNo"],
      name: json["name"],
      image: json["image"],
      password: json["password"],
      isSelected: false);

  Map<String, dynamic> toJson() => {
        "aridNo": aridNo,
        "name": name,
        "image": image,
        "password": password,
      };
}
