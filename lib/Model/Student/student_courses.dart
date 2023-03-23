import 'dart:convert';

List<StudentCourses> studentCoursesFromJson(String str) =>
    List<StudentCourses>.from(
        json.decode(str).map((x) => StudentCourses.fromJson(x)));

String studentCoursesToJson(List<StudentCourses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentCourses {
  StudentCourses({
    required this.teacherName,
    required this.courseName,
    required this.discipline,
    required this.image,
  });

  String teacherName;
  String courseName;
  String discipline;
  String image;

  factory StudentCourses.fromJson(Map<String, dynamic> json) => StudentCourses(
        teacherName: json["teacherName"],
        courseName: json["courseName"],
        discipline: json["discipline"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "teacherName": teacherName,
        "courseName": courseName,
        "discipline": discipline,
        "image": image,
      };
}
