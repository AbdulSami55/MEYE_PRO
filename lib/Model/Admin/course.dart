import 'dart:convert';

Course courseFromJson(Map<String, dynamic> mp) => Course.fromJson(mp);
List<Course> lstcourseFromJson(String str) =>
    List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(Course data) => json.encode(data.toJson());
List<Course> rlstcourseFromJson(List lst) {
  List<Course> templst = [];
  for (var i in lst) {
    templst.add(Course.fromJson(i));
  }
  return templst;
}

class Course {
  Course({
    this.id,
    this.courseID,
    this.creditHours,
    this.name,
  });

  int? id;
  String? courseID;
  int? creditHours;
  String? name;

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["id"],
        courseID: json["courseID"],
        creditHours: json["creditHours"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "courseID": courseID,
        "creditHours": creditHours,
        "name": name,
      };
}
