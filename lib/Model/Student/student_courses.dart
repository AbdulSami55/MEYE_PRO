import 'dart:convert';

List<StudentCourses> studentCoursesFromJson(String str) =>
    List<StudentCourses>.from(
        json.decode(str).map((x) => StudentCourses.fromJson(x)));

String studentCoursesToJson(List<StudentCourses> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StudentCourses {
  StudentCourses(
      {required this.teacherName,
      required this.courseName,
      required this.discipline,
      required this.image,
      required this.percentage});

  String teacherName;
  String courseName;
  String discipline;
  String image;
  double percentage;

  factory StudentCourses.fromJson(Map<String, dynamic> json) => StudentCourses(
      teacherName: json["teacherName"],
      courseName: json["courseName"],
      discipline: json["discipline"],
      image: json["image"],
      percentage: json["percentage"]);

  Map<String, dynamic> toJson() => {
        "teacherName": teacherName,
        "courseName": courseName,
        "discipline": discipline,
        "image": image,
        "percentage": percentage
      };
}
