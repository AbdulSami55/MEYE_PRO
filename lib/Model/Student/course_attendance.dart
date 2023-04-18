import 'dart:convert';

List<CourseAttendance> courseAttendanceFromJson(String str) =>
    List<CourseAttendance>.from(
        json.decode(str).map((x) => CourseAttendance.fromJson(x)));

class CourseAttendance {
  String date;
  bool status;

  CourseAttendance({required this.date, required this.status});

  factory CourseAttendance.fromJson(Map<String, dynamic> json) =>
      CourseAttendance(date: json['Date'], status: json['Status']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Date'] = date;
    data['Status'] = status;
    return data;
  }
}
