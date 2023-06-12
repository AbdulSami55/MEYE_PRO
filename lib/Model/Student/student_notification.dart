import 'dart:convert';

List<StudentNotification> studentNotificationFromMap(String str) =>
    List<StudentNotification>.from(
        json.decode(str).map((x) => StudentNotification.fromMap(x)));

String studentNotificationToMap(List<StudentNotification> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class StudentNotification {
  String teacherName;
  String startTime;
  String endTime;
  String courseName;
  String day;
  String image;
  String date;

  StudentNotification(
      {required this.teacherName,
      required this.startTime,
      required this.endTime,
      required this.courseName,
      required this.day,
      required this.date,
      required this.image});

  factory StudentNotification.fromMap(Map<String, dynamic> json) =>
      StudentNotification(
        teacherName: json["teacherName"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        courseName: json["courseName"],
        day: json["day"],
        date: json["date"],
        image: json['image'],
      );

  Map<String, dynamic> toMap() => {
        "teacherName": teacherName,
        "startTime": startTime,
        "endTime": endTime,
        "courseName": courseName,
        "day": day,
        "date": date,
      };
}
